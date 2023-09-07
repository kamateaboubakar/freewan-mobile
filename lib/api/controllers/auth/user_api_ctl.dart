import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/security_question.dart';
import 'package:wan_mobile/models/user.dart';
import 'package:wan_mobile/tools/types/types.dart';

import 'package:wan_mobile/tools/utils/http_response.dart';

class UserApiCtl extends WebController {
  Future<HttpResponse<User>> register(User user) async {
    try {
      var res = await post(
        HttpClientConst.baseUrl(module: "auth/register"),
        HttpResponse.encodeBody(user.toJson()),
        headers: HttpClientConst.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        appCtl.jwtToken = body.data["token"];
        return HttpResponse.success(data: User.fromJson(body.data["data"]));
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

  Future<HttpResponse<int>> loginPhone(
      {required String phone, required int paysId}) async {
    try {
      var res = await get(
        HttpClientConst.baseUrl(module: "auth/phoneAuth/$phone/$paysId"),
        headers: HttpClientConst.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        if (body.data["status"] == true) {
          if (body.data["data"] is int) {
            return HttpResponse.success(data: body.data["data"]);
          } else {
            return HttpResponse.success(data: null);
          }
        } else {
          if (body.data["message"] == null) {
            return HttpResponse.success(data: null);
          } else {
            return HttpResponse.error(message: body.data["message"]);
          }
        }
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
        HttpClientConst.baseUrl(module: "auth/checkOTP"),
        headers: HttpClientConst.headers,
        {"fullPhoneNumber": phone, "otp": code}.parseToJson(),
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
        HttpClientConst.baseUrl(module: "auth/checkPassword"),
        {"login": phone, "password": password}.parseToJson(),
        headers: HttpClientConst.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        if (body.data["status"] == false) {
          return HttpResponse.error(message: body.data["message"]);
        } else {
          return HttpResponse.success(
              data: SecurityQuestion.fromJson(body.data["data"]));
        }
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<User>> answerSecurityQuestionLogin(
      {required String phone,
      required int securityQuestionId,
      required String answer}) async {
    try {
      var res = await post(
        HttpClientConst.baseUrl(module: "auth/checkSecurityQuestionAnswer"),
        {
          "login": phone,
          "security_question_id": securityQuestionId,
          "answer": answer,
        }.parseToJson(),
        headers: HttpClientConst.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        appCtl.jwtToken = body.data["token"];
        return HttpResponse.success(data: User.fromJson(body.data["data"]));
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

      if (body.status) {
        return HttpResponse.success(data: User.fromJson(body.data));
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<User>> getUserProfilById(String userId) async {
    try {
      var res = await get(
        HttpClientConst.baseUrl(module: "admin/api/v1/accounts/$userId"),
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);

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
        HttpClientConst.baseUrl(module: "auth/logout"),
        {}.parseToJson(),
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
