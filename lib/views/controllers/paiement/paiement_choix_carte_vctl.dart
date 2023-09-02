import 'package:wan_mobile/api/controllers/paiement/wallet_api_ctl.dart';
import 'package:wan_mobile/models/paiement/carte_bancaire.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class PaiementChoixCarteVctl extends ViewController {
  List<CarteBancaire> cards = [];

  Future<void> getMobileMoneys() async {
    await pr.show();
    var res = await WalletApiCtl()
        .getUserCarteBancaires(userId: appCtl.user.accountId.value);
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
