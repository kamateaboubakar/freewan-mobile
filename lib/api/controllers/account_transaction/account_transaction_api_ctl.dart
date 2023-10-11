import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/solde_historique/account_transaction.dart';
import 'package:wan_mobile/models/solde_historique/stats/mode_paiement_stats.dart';
import 'package:wan_mobile/models/solde_historique/stats/month_stats.dart';
import 'package:wan_mobile/models/solde_historique/stats/service_stats.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class AccountTransactionApiCtl extends WebController {
  final url = "http://148.113.143.59:8184/api";
  Future<HttpResponse<List<AccountTransaction>>> getUserTransactions(
      {required String userId}) async {
    try {
      var res = await get(
        "$url/transactions/$userId",
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
          data: (body.data["data"] as List)
              .map((e) => AccountTransaction.fromJson(e))
              .toList(),
        );
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<List<MonthStats>>> getUserPerMonth(
      {required String userId}) async {
    try {
      var res = await get(
        "$url/statistique/amountBymouth/user/$userId",
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
          data: (body.data as List).map((e) => MonthStats.fromJson(e)).toList(),
        );
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<List<ServiceStats>>> getUserPerService(
      {required String userId}) async {
    try {
      var res = await get(
        "$url/statistique/amountsByService/user/$userId",
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
          data:
              (body.data as List).map((e) => ServiceStats.fromJson(e)).toList(),
        );
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<List<ModePaiementStats>>> getUserPerModePaiement(
      {required String userId}) async {
    try {
      var res = await get(
        "$url/statistique/amountsByPaymentMode/user/$userId",
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
          data: (body.data as List)
              .map((e) => ModePaiementStats.fromJson(e))
              .toList(),
        );
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<int>> getTotalUserDepense(
      {required String userId}) async {
    try {
      var res = await get(
        "$url/statistique/totalamount/user/$userId",
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(data: (body.data as double).toInt());
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<int>> getTotalUserCB({required String userId}) async {
    try {
      var res = await get(
        "$url/statistique/totalamount/user/$userId",
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(data: (body.data as double).toInt());
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<int>> getTotalUserMM({required String userId}) async {
    try {
      var res = await get(
        "$url/statistique/totalamount/user/$userId",
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(data: (body.data as double).toInt());
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<int>> getTotalUserTransactionMoisEnCours(
      {required String userId}) async {
    try {
      var res = await get(
        "$url/statistique/totalamount/user/$userId",
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(data: (body.data as double).toInt());
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<AccountTransaction>> makePaiement(
      AccountTransaction accountTransaction) async {
    try {
      print(accountTransaction.toJson().parseToJson());
      var res = await post(
        "$url/transactions",
        accountTransaction.toJson().parseToJson(),
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        if (body.data["data"]["payment_url"] != null) {
          return HttpResponse.success(
              data: AccountTransaction.fromJson(body.data["data"]));
        } else {
          return HttpResponse.error();
        }
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }
}
