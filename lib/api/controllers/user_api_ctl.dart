import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/security_question.dart';
import 'package:wan_mobile/models/user.dart';
import 'package:wan_mobile/tools/types/types.dart';

import 'package:wan_mobile/tools/utils/http_response.dart';

class UserApiCtl extends WebController {
  Future<HttpResponse<bool>> register(User user) async {
    try {
      var res = await post(
        HttpClientConst.baseUrl(module: "register"),
        HttpResponse.encodeBody(user.toJson()),
        headers: HttpClientConst.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        appCtl.jwtToken = body.data["accessToken"];
        return HttpResponse.success(data: true);
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<bool>> saveUsersSecuriteQuestionAnswers(
      SecurityQuestion question, String userId) async {
    try {
      return HttpResponse.success(data: true);
    } catch (e) {
      return HttpResponse.error();
    }
  }

  Future<HttpResponse<bool>> loginPhone({required String phone}) async {
    try {
      var res = await post(
        HttpClientConst.baseUrl(module: "challenge-otp"),
        {"login": phone}.toJson(),
        headers: HttpClientConst.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        if (body.data != null && body.data["userExist"] == true) {
          return HttpResponse.success(data: true);
        }
        return HttpResponse.success(data: false);
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<bool>> verifyOtp(
      {required String code, required String phone}) async {
    try {
      var response = await post(
        HttpClientConst.baseUrl(module: "challenge-otp/verify"),
        headers: HttpClientConst.headers,
        {"otp": code, "login": phone}.toJson(),
      );
      var body = HttpResponse.decodeBody(response);
      if (body.status) {
        if (body.data != null) {
          if (body.data["errorCode"] == "otp-expired") {
            return HttpResponse.error(message: "Ce code OTP a expiré.");
          } else if (body.data["errorCode"] == "otp-invalid") {
            return HttpResponse.error(message: "Ce code OTP n'est pas valide.");
          } else {
            return HttpResponse.success(data: true);
          }
        } else {
          return HttpResponse.success(data: true);
        }
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<SecurityQuestion>> authenticate(
      {required String phone, required String password}) async {
    try {
      var res = await post(
        HttpClientConst.baseUrl(module: "auth/authenticate"),
        {"login": phone, "password": password}.toJson(),
        headers: HttpClientConst.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(data: SecurityQuestion.fromJson(body.data));
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<bool>> answerSecurityQuestionLogin(
      {required String phone,
      required String password,
      required int securityQuestionId,
      required String answer}) async {
    try {
      var res = await post(
        HttpClientConst.baseUrl(module: "auth/challenge-questions"),
        {
          "login": phone,
          "password": password,
          "securityQuestion": {
            "securityQuestionId": securityQuestionId,
            "answer": answer,
          }
        }.toJson(),
        headers: HttpClientConst.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        appCtl.jwtToken = body.data["accessToken"];
        return HttpResponse.success(data: true);
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<User>> getUserProfil() async {
    try {
      var res = await get(
        HttpClientConst.baseUrl(module: "profile"),
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);

      print(body.data);

      if (body.status) {
        return HttpResponse.success(data: User.fromJson(body.data));
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<bool>> logout() async {
    try {
      var res = await post(
        HttpClientConst.baseUrl(module: "auth/revoke"),
        {}.toJson(),
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(data: true);
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }
}
