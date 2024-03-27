import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';
import 'package:tools_flutter_project/tools/http/http_response.dart';
import 'package:tools_flutter_project/tools/types/map.dart';

class AdresseApiCtl {
  static String module = "auth-center/api/v1/adresses";
  static Future<HttpResponse<List<Adresse>>> getUserAdresses() async {
    try {
      var res = await WebRequest.nativRequest(
        AppHttpHeaders.baseUrl(module: "$module/all"),
        headers: AppHttpHeaders.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
          data: (body.data["data"] as List)
              .map((e) => Adresse.fromJson(e))
              .toList(),
        );
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(
        systemError: e,
        systemtraceError: st,
      );
    }
  }

  static Future<HttpResponse<Adresse>> createAdresse(Adresse adresse) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        AppHttpHeaders.baseUrl(module: "$module/create"),
        body: adresse.toJson().parseToJson(),
        headers: AppHttpHeaders.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
          data: Adresse.fromJson(body.data),
        );
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(
        systemError: e,
        systemtraceError: st,
      );
    }
  }

  static Future<HttpResponse<Adresse>> updateAdresse(Adresse adresse) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.PUT,
        AppHttpHeaders.baseUrl(module: "$module/update/${adresse.id}"),
        body: adresse.toJson().parseToJson(),
        headers: AppHttpHeaders.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
          data: Adresse.fromJson(body.data),
        );
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(
        systemError: e,
        systemtraceError: st,
      );
    }
  }

  static Future<HttpResponse<Adresse>> deleteAdresse(int adresseId) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.PUT,
        AppHttpHeaders.baseUrl(module: "$module/$adresseId"),
        headers: AppHttpHeaders.authHeaders,
      );

      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
          data: Adresse.fromJson(body.data),
        );
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(
        systemError: e,
        systemtraceError: st,
      );
    }
  }
}
