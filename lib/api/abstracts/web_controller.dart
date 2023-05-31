import 'dart:io';

import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:http/http.dart' as http;
import 'package:wan_mobile/models/fichier.dart';
import '../../tools/utils/http_response.dart';
import '../../views/controllers/app_ctl.dart';

abstract class WebController extends GetConnect {
  final AppCtl appCtl = Get.find();

  // TODO fix
  /*@override
  void onInit() {
    httpClient.defaultContentType = "json";
    httpClient.addResponseModifier((request, response) {
      if (kDebugMode) {
        print('---- [RESPONSE] ${request.url}');
        print(request.method);
        print(response.status.code);
        print(response.body);
      }
    });
    httpClient.addRequestModifier<Object?>((request) async {
      if (kDebugMode) {
        print('---- [REQUEST] ${request.url}');
        print(request.method);
        print(request.headers);
        String bodyString =
            await request.bodyBytes.transform(utf8.decoder).join();
        log(bodyString);
      }
      return request;
    });
    super.onInit();
  }*/

  @override
  Future<Response<T>> put<T>(String url, dynamic body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress}) async {
    headers = await _checkAndRefreshToken(headers);
    return super.put(url, body,
        contentType: contentType,
        headers: headers,
        query: query,
        decoder: decoder,
        uploadProgress: uploadProgress);
  }

  @override
  Future<Response<T>> post<T>(String? url, body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress}) async {
    headers = await _checkAndRefreshToken(headers);
    return super.post(url, body,
        contentType: contentType,
        headers: headers,
        query: query,
        decoder: decoder,
        uploadProgress: uploadProgress);
  }

  @override
  Future<Response<T>> get<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      Decoder<T>? decoder}) async {
    headers = await _checkAndRefreshToken(headers);

    return super.get(url,
        headers: headers,
        contentType: contentType,
        query: query,
        decoder: decoder);
  }

  Future<http.MultipartRequest> multiPartclient(String method, Uri url,
      {Map<String, String> headers = const {},
      Map<String, String> body = const {},
      List<File> files = const []}) async {
    var req = http.MultipartRequest(method, url);
    headers = await _checkAndRefreshToken(headers);
    req.headers.addAll(headers);
    req.fields.addAll(body);
    for (var file in files) {
      req.files.add(await http.MultipartFile.fromPath("file", file.path));
    }
    return req;
  }

  Future<Map<String, String>> _checkAndRefreshToken(
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
