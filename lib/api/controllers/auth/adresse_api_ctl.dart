import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/adresse.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class AdresseApiCtl extends WebController {
  Future<HttpResponse<List<Adresse>>> getUserAdresses() async {
    try {
      var res = await get(
        HttpClientConst.baseUrl(module: "adresses/all"),
        headers: HttpClientConst.authHeaders,
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

  Future<HttpResponse<Adresse>> createAdresse(Adresse adresse) async {
    try {
      var res = await post(
        HttpClientConst.baseUrl(module: "adresses/create"),
        adresse.toJson().parseToJson(),
        headers: HttpClientConst.authHeaders,
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

  Future<HttpResponse<Adresse>> updateAdresse(Adresse adresse) async {
    try {
      var res = await put(
        HttpClientConst.baseUrl(module: "adresses/update/${adresse.id}"),
        adresse.toJson().parseToJson(),
        headers: HttpClientConst.authHeaders,
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

  Future<HttpResponse<Adresse>> deleteAdresse(int adresseId) async {
    try {
      var res = await put(
        HttpClientConst.baseUrl(module: "adresses/$adresseId"),
        {}.parseToJson(),
        headers: HttpClientConst.authHeaders,
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
