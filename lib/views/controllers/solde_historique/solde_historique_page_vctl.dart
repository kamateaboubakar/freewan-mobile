import 'package:wan_mobile/api/controllers/account_transaction/account_transaction_api_ctl.dart';
import 'package:wan_mobile/models/solde_historique/account_transaction.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class SoldeHistoriquePageVctl extends ViewController {
  List<AccountTransaction> transactions = [];
  bool loading = false;

  Future<void> getTransactions() async {
    loading = true;
    update();
    var res = await AccountTransactionApiCtl()
        .getUserTransactions(userId: appCtl.user.accountId.value);
    loading = false;
    update();
    if (res.status) {
      transactions = res.data!;
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  @override
  void onReady() {
    super.onReady();
    getTransactions();
  }
}
