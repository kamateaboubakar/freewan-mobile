import 'package:wan_mobile/api/controllers/account_transaction/account_transaction_api_ctl.dart';
import 'package:wan_mobile/models/solde_historique/account_transaction.dart';
import 'package:wan_mobile/models/solde_historique/stats/mode_paiement_stats.dart';
import 'package:wan_mobile/models/solde_historique/stats/month_stats.dart';
import 'package:wan_mobile/models/solde_historique/stats/service_stats.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class SoldeHistoriquePageVctl extends ViewController {
  List<AccountTransaction> transactions = [];
  List<MonthStats> statPerMonth = [];
  List<ServiceStats> statPerService = [];
  List<ModePaiementStats> statPerModePaiement = [];
  bool loading = false;
  bool mthloading = false;
  bool serviceloading = false;
  bool modePaiementLoading = false;
  int totalDepense = 0;

  Future<void> getTransactions() async {
    loading = true;
    update();
    var res = await AccountTransactionApiCtl()
        .getUserTransactions(userId: appCtl.user.id.value.toString());
    loading = false;
    update();
    if (res.status) {
      transactions = res.data!;
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  Future<void> getUserPerMonth() async {
    mthloading = true;
    update();
    var res = await AccountTransactionApiCtl()
        .getUserPerMonth(userId: appCtl.user.id.value.toString());
    mthloading = false;
    update();
    if (res.status) {
      statPerMonth = res.data!;
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  Future<void> getUserPerService() async {
    serviceloading = true;
    update();
    var res = await AccountTransactionApiCtl()
        .getUserPerService(userId: appCtl.user.id.value.toString());
    serviceloading = false;
    update();
    if (res.status) {
      statPerService = res.data!;
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  Future<void> getUserPerModePaiement() async {
    modePaiementLoading = true;
    update();
    var res = await AccountTransactionApiCtl()
        .getUserPerModePaiement(userId: appCtl.user.id.value.toString());
    modePaiementLoading = false;
    update();
    if (res.status) {
      statPerModePaiement = res.data!;
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  Future<void> getTotalUserDepense() async {
    var res = await AccountTransactionApiCtl()
        .getTotalUserDepense(userId: appCtl.user.id.value.toString());
    if (res.status) {
      totalDepense = res.data!;
      update();
    }
  }

  String getTotalUserCB() {
    return transactions
        .where((e) => e.modePayment == "CB")
        .fold(0, (p, e) => p + e.amount.toDouble().toInt().value)
        .toAmount();
  }

  String getTotalUserMM() {
    return transactions
        .where((e) => e.modePayment == "MM")
        .fold(0, (p, e) => p + e.amount.toDouble().toInt().value)
        .toAmount();
  }

  String getTotalUserCurrentMonth() {
    var curMth = DateTime.now().toString().split("-")[1];
    return transactions
        .where((e) => e.createdAt.value.split("-")[1] == curMth)
        .fold(0, (p, e) => p + e.amount.toDouble().toInt().value)
        .toAmount();
  }

  Future<void> getData() async {
    getTransactions();
    getTotalUserDepense();
    getUserPerMonth();
    getUserPerService();
    getUserPerModePaiement();
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }
}
