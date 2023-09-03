import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/solde_historique/account_transaction.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class AccountTransactionApiCtl extends WebController {
  final url = "http://148.113.143.59:8184/api/transactions";
  Future<HttpResponse<List<AccountTransaction>>> getUserTransactions(
      {required String userId}) async {
    try {
      var res = await get(
        "$url/$userId",
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

  Future<HttpResponse<AccountTransaction>> makePaiement(
      AccountTransaction accountTransaction) async {
    try {
      var res = await post(
        url,
        accountTransaction.toJson().parseToJson(),
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
            data: AccountTransaction.fromJson(body.data["data"]));
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }
}
