import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:path/path.dart' as p;
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/file_upload_result.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

import '../../tools/const/const.dart';
import 'package:http/http.dart' as http;

import '../abstracts/http_client_const.dart';

class FileApiCtl extends WebController {
  Future<HttpResponse<FileUploadResult>> uploadFile(File file) async {
    try {
      var url = "${Const.jobBaseUrl}/files/upload";
      var filename = p.basename(file.path);
      print('file name $filename');
      final form = FormData({
        'file': MultipartFile(file, filename: filename),
      });

      var res = await post(
        url,
        form,
      );

      print(res.body);

      var body = HttpResponse.decodeBody(res);

      print(body.data);

      if (body.status) {
        return HttpResponse.success(
          data: FileUploadResult.fromJson(body.data),
        );
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<HttpResponse<FileUploadResult>> uploadFileNew(
      {Map<String, String> headers = const {},
      Map<String, String> body = const {},
      List<File> files = const []}) async {
    try {
      var url = "${Const.jobBaseUrl}/files/upload";
      var req = http.MultipartRequest('POST', Uri.parse(url));
      headers = (await _checkAndRefreshToken(headers)) ?? {};
      req.headers.addAll(headers);
      req.fields.addAll(body);
      for (var file in files) {
        req.files.add(
            await http.MultipartFile.fromPath("file", file.path, filename: p.basename(file.path)));
      }
      var response = await req.send();
      var responseString = await response.stream.bytesToString();
      return HttpResponse.success(
          data: FileUploadResult.fromJson(jsonDecode(responseString)));
    } catch (e) {
      print(e);
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<Map<String, String>>? _checkAndRefreshToken(
      Map<String, String>? headers) async {
    if (headers?.containsKey("authorization") == true &&
        Jwt.isExpired(appCtl.jwtToken)) {
      var response = await super.get(
          HttpClientConst.baseUrl(module: "auth/refreshToken"),
          headers: headers);
      var body = HttpResponse.decodeBody(response);
      if (body.status) {
        appCtl.jwtToken = body.data["token"];
        headers!["authorization"] = appCtl.jwtToken;
        return headers;
      } else {
        return Future.value(headers);
      }
    }
    return Future.value(headers);
  }
}
