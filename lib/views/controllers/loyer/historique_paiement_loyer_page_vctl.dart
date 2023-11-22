import 'package:wan_mobile/api/controllers/loyer/loyer_api_ctl.dart';
import 'package:wan_mobile/models/loyer/paiement_loyer.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';

class HistoriquePaiementLoyerPageVctl extends ViewController {
  List<PaiementLoyer> paiements = [];
  bool loading = false;
  int habitatId;

  HistoriquePaiementLoyerPageVctl(this.habitatId);

  Future<void> fetchPaiements() async {
    loading = true;
    update();
    var res =
        await LoyerApiCtl().historiquePaiementFromAppartementId(habitatId);
    loading = false;
    update();
    if (res.status) {
      paiements = res.data!;
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  @override
  void onReady() {
    super.onReady();
    fetchPaiements();
  }
}
