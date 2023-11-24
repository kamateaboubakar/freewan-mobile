import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';
import 'package:tools_flutter_project/tools/types/map.dart';
import 'package:wan_mobile/models/paiement/carte_bancaire.dart';
import 'package:wan_mobile/models/paiement/mobile_money.dart';
import 'package:tools_flutter_project/tools/http/http_response.dart';

class WalletApiCtl {
  String url = "http://148.113.143.59:8182/api";
  Future<HttpResponse<List<MobileMoney>>> getUserMobileMoneys(
      {required String userId}) async {
    try {
      var res = await WebRequest.nativRequest(
        "$url/mobile-moneys/users/$userId/mobile-moneys",
        headers: AppHttpHeaders.authHeaders,
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
      var res = await WebRequest.nativRequest(
        "$url/carte-bancaires/users/$userId/carte-bancaires",
        headers: AppHttpHeaders.authHeaders,
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
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        "$url/mobile-moneys",
        body: mobileMoney.toJson().parseToJson(),
        headers: AppHttpHeaders.authHeaders,
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
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        "$url/carte-bancaires",
        body: carteBancaire.toJson().parseToJson(),
        headers: AppHttpHeaders.authHeaders,
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
