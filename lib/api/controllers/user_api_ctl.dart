import 'dart:convert';

import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/user.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class UserApiCtl extends WebController {
  Future<HttpResponse<bool>> register(User user) async {
    try {
      var response = await client.post(
        baseUrl(module: "register"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode(user.toJson()),
      );
      var body = HttpResponse.decodeBody(response);
      if (body.status) {
        return HttpResponse.success(data: true);
      }
      return HttpResponse.error();
    } catch (e) {
      return HttpResponse.error();
    }
  }

  Future<HttpResponse<bool>> loginPhone(String phone) async {
    try {
      var response = await client.post(
        baseUrl(module: "challenge-otp"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode({"login": phone}),
      );
      var body = HttpResponse.decodeBody(response);
      if (body.status) {
        return HttpResponse.success(data: true);
      }
      return HttpResponse.error();
    } catch (e) {
      return HttpResponse.error();
    }
  }

  Future<void> verifyOtp(String code) async {
    try {
      var response = await client.post(
        baseUrl(module: "verify-otp"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode({"code": code, "login": ""}),
      );
    } catch (e) {
      // return HttpResponse.error();
    }
  }
}
