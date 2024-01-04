import 'package:lebedoo_wallets_transactions/models/carte_bancaire.dart';
import 'package:tools_flutter_project/tools/types/int.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/paiement/wallet_api_ctl.dart';

import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';

class PaiementChoixCarteVctl extends ViewController {
  List<CarteBancaire> cards = [];

  Future<void> getMobileMoneys() async {
    await pr.show();
    var res = await WalletApiCtl()
        .getUserCarteBancaires(userId: appCtl.user.id.value.toString());
    await pr.hide();
    if (res.status) {
      cards = res.data!;
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  @override
  void onReady() {
    super.onReady();
    getMobileMoneys();
  }
}
