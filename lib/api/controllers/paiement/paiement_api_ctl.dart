import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/paiement/carte_bancaire.dart';
import 'package:wan_mobile/models/paiement/mobile_money.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class PaiementApiCtl extends WebController {
  String url = "http://148.113.143.59:8182/api";
  Future<HttpResponse<List<MobileMoney>>> getUserMobileMoneys(
      {required String userId}) async {
    try {
      var res = await get(
        "$url/mobile-moneys/users/$userId/mobile-moneys",
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
            data: (body.data["data"] as List)
                .map((e) => MobileMoney.fromJson(e))
                .toList());
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<List<CarteBancaire>>> getUserCarteBancaires(
      {required String userId}) async {
    try {
      var res = await get(
        "$url/carte-bancaires/users/$userId/carte-bancaires",
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
            data: (body.data["data"] as List)
                .map((e) => CarteBancaire.fromJson(e))
                .toList());
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<MobileMoney>> addMobileMoney(
      {required MobileMoney mobileMoney}) async {
    try {
      var res = await post(
        "$url/mobile-moneys",
        mobileMoney.toJson().parseToJson(),
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
            data: MobileMoney.fromJson(body.data["data"]));
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<CarteBancaire>> addCarteBancaire(
      {required CarteBancaire carteBancaire}) async {
    try {
      var res = await post(
        "$url/carte-bancaires",
        carteBancaire.toJson().parseToJson(),
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
            data: CarteBancaire.fromJson(body.data["data"]));
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }
}
