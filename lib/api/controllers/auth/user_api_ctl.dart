import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';
import 'package:tools_flutter_project/tools/http/http_response.dart';
import 'package:tools_flutter_project/tools/types/map.dart';
import 'package:wan_mobile/models/auth/otp_session.dart';
import 'package:wan_mobile/tools/utils/functions.dart';

class UserApiCtl {
  static String module = "auth-center/api/v1/auth";
  static Future<HttpResponse<User>> register(User user, int paysId) async {
    try {
      var params = user.toJson();
      params.addAll({"country_id": paysId});
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        AppHttpHeaders.baseUrl(module: "$module/register"),
        body: params.parseToJson(),
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

  static Future<HttpResponse<bool>> saveUsersSecuriteQuestionAnswers(
      SecurityQuestion question, String userId) async {
    try {
      return HttpResponse.success(data: true);
    } catch (e) {
      return HttpResponse.error();
    }
  }

  static Future<HttpResponse<OtpSession>> loginPhone(
      {required String phone, required int paysId}) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        AppHttpHeaders.baseUrl(module: "$module/phoneAuth"),
        headers: AppHttpHeaders.headers,
        body: {
          "login": phone,
          "country_id": paysId,
        }.parseToJson(),
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        if (body.data["status"] == true) {
          if (body.data["data"] is String) {
            return HttpResponse.success(data: null);
          } else {
            return HttpResponse.success(
                data: OtpSession.fromJson(body.data["data"]));
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

  static Future<HttpResponse<bool>> verifyOtp(
      {required String code, required String fullPhone}) async {
    try {
      var response = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        AppHttpHeaders.baseUrl(module: "$module/checkOTP"),
        headers: AppHttpHeaders.headers,
        body: {
          "fullPhoneNumber": fullPhone,
          "otp": code,
        }.parseToJson(),
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
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  static Future<HttpResponse<SecurityQuestion>> authenticate(
      {required String phone, required String password}) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        AppHttpHeaders.baseUrl(module: "$module/checkPassword"),
        body: {
          "login": phone,
          "password": password,
        }.parseToJson(),
        headers: AppHttpHeaders.headers,
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

  static Future<HttpResponse<User>> answerSecurityQuestionLogin(
      {required String phone,
      required int securityQuestionId,
      required String answer}) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        AppHttpHeaders.baseUrl(module: "$module/checkSecurityQuestionAnswer"),
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

  static Future<HttpResponse<User>> getUserProfil() async {
    try {
      var res = await WebRequest.nativRequest(
        AppHttpHeaders.baseUrl(module: "$module/profile"),
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

  static Future<HttpResponse<User>> getUserProfilById(String userId) async {
    try {
      var res = await WebRequest.nativRequest(
        AppHttpHeaders.baseUrl(module: "$module/profile/$userId"),
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

  static Future<HttpResponse<bool>> logout() async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        AppHttpHeaders.baseUrl(module: "$module/logout"),
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

  static Future<HttpResponse<User>> checkUserQrCode(
      {required String qrAccount}) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        AppHttpHeaders.baseUrl(module: "$module/profil/qrAccount"),
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

  static Future<HttpResponse<bool>> updateFCMToken() async {
    try {
      var token = await Functions.getFcmToken();
      if (token != null) {
        var res = await WebRequest.nativRequest(
          verbe: RequestVerbeEnum.POST,
          AppHttpHeaders.baseUrl(module: "$module/updateFcmToken"),
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

  static Future<HttpResponse<User>> updateProfil({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.PUT,
        AppHttpHeaders.baseUrl(module: "$module/update"),
        body: {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
        }.parseToJson(),
        headers: AppHttpHeaders.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
          data: User.fromJson(body.data["data"]),
        );
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  static Future<HttpResponse<bool>> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.PUT,
        AppHttpHeaders.baseUrl(module: "$module/password/update"),
        body: {
          "oldPassword": oldPassword,
          "password": newPassword,
        }.parseToJson(),
        headers: AppHttpHeaders.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        AppHttpHeaders.jwtToken = body.data["token"];
        return HttpResponse.success(data: true);
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  static Future<HttpResponse<bool>> qrLogin(
      {required String userId, required String qrCode}) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.GET,
        AppHttpHeaders.baseUrl(module: "$module/qrLogin/setUser"),
        body: {"qrCode": qrCode}.parseToJson(),
        headers: AppHttpHeaders.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(data: true);
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error();
    }
  }
}
