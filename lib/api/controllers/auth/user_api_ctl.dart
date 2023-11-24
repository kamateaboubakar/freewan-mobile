import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';
import 'package:tools_flutter_project/tools/types/map.dart';

import 'package:wan_mobile/tools/utils/functions.dart';

import 'package:tools_flutter_project/tools/http/http_response.dart';

class UserApiCtl {
  Future<HttpResponse<User>> register(User user) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        AppHttpHeaders.baseUrl(module: "auth/register"),
        body: user.toJson().parseToJson(),
        headers: AppHttpHeaders.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        AppHttpHeaders.jwtToken = body.data["token"];
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
      var res = await WebRequest.nativRequest(
        AppHttpHeaders.baseUrl(module: "auth/phoneAuth/$phone/$paysId"),
        headers: AppHttpHeaders.headers,
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
      var response = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        AppHttpHeaders.baseUrl(module: "auth/checkOTP"),
        headers: AppHttpHeaders.headers,
        body: {"fullPhoneNumber": phone, "otp": code}.parseToJson(),
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
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        AppHttpHeaders.baseUrl(module: "auth/checkPassword"),
        body: {
          "login": phone,
          "password": password,
        }.parseToJson(),
        headers: AppHttpHeaders.headers,
        displayRequest: true,
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
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        AppHttpHeaders.baseUrl(module: "auth/checkSecurityQuestionAnswer"),
        body: {
          "login": phone,
          "security_question_id": securityQuestionId,
          "answer": answer,
        }.parseToJson(),
        headers: AppHttpHeaders.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        if (body.data["status"] == false) {
          return HttpResponse.error(message: body.data["message"]);
        } else {
          AppHttpHeaders.jwtToken = body.data["token"];
          return HttpResponse.success(data: User.fromJson(body.data["data"]));
        }
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<User>> getUserProfil() async {
    try {
      var res = await WebRequest.nativRequest(
        AppHttpHeaders.baseUrl(module: "profile"),
        headers: AppHttpHeaders.authHeaders,
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
      var res = await WebRequest.nativRequest(
        AppHttpHeaders.baseUrl(module: "admin/api/v1/accounts/$userId"),
        headers: AppHttpHeaders.authHeaders,
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
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        AppHttpHeaders.baseUrl(module: "auth/logout"),
        headers: AppHttpHeaders.authHeaders,
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

  Future<HttpResponse<User>> checkUserQrCode(
      {required String qrAccount}) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        AppHttpHeaders.baseUrl(module: "auth/profil/qrAccount"),
        body: {"qrAccount": qrAccount}.parseToJson(),
        headers: AppHttpHeaders.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(data: User.fromJson(body.data["data"]));
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<bool>> updateFCMToken() async {
    try {
      var token = await Functions.getFcmToken();
      if (token != null) {
        var res = await WebRequest.nativRequest(
          verbe: RequestVerbeEnum.POST,
          AppHttpHeaders.baseUrl(module: "auth/updateFcmToken"),
          body: {"fcm_token": token}.parseToJson(),
          headers: AppHttpHeaders.authHeaders,
        );
        var body = HttpResponse.decodeBody(res);
        if (body.status) {
          return HttpResponse.success(data: true);
        }
        return HttpResponse.error(message: body.message);
      } else {
        return HttpResponse.error(
            message: "Nous n'avons pas pu récupérer le token.");
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }
}
