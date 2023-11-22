import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/request_verbe_enum.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';
import 'package:path/path.dart' as p;
import 'package:tools_flutter_project/tools/http/http_response.dart';

import 'package:wan_mobile/models/file_upload_result.dart';
import '../../tools/const/const.dart';

import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';

class FileApiCtl {
  Future<HttpResponse<FileUploadResult>> uploadFile(File file) async {
    try {
      var res = await WebRequest.multipartRequest(
        url: "${Const.jobBaseUrl}/files/upload",
        verbe: RequestVerbeEnum.POST,
        files: [file],
      );

      var body = HttpResponse.decodeBody(res);

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
      // var url = "${Const.jobBaseUrl}/files/upload";
      // var req = http.MultipartRequest('POST', Uri.parse(url));
      // headers = (await _checkAndRefreshToken(headers)) ?? {};
      // req.headers.addAll(headers);
      // req.fields.addAll(body);
      // for (var file in files) {
      //   req.files.add(await http.MultipartFile.fromPath("file", file.path,
      //       filename: p.basename(file.path)));
      // }
      var response = await WebRequest.multipartRequest(
        url: "${Const.jobBaseUrl}/files/upload",
        verbe: RequestVerbeEnum.POST,
        headers: headers,
        files: files,
        fields: body,
      );

      return HttpResponse.success(
          data: FileUploadResult.fromJson(jsonDecode(response.body)));
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<Map<String, String>>? _checkAndRefreshToken(
      Map<String, String>? headers) async {
    if (headers?.containsKey("authorization") == true &&
        Jwt.isExpired(AppHttpHeaders.jwtToken)) {
      var response = await WebRequest.nativRequest(
        AppHttpHeaders.baseUrl(module: "auth/refreshToken"),
        headers: headers ?? {},
      );
      var body = HttpResponse.decodeBody(response);
      if (body.status) {
        AppHttpHeaders.jwtToken = body.data["token"];
        headers!["authorization"] = AppHttpHeaders.jwtToken;
        return headers;
      } else {
        return Future.value(headers);
      }
    }
    return Future.value(headers);
  }
}
