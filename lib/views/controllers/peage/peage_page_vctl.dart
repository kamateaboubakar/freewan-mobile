import 'package:wan_mobile/api/controllers/peage/peage_api_ctl.dart';
import 'package:wan_mobile/models/peage/fournisseur_peage.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class PeagePageVctl extends ViewController {
  List<FournisseurPeage> fournisseurs = [];

  Future<void> getFournisseurs() async {
    await pr.show();
    var res = await PeageApiCtl().getAllFournisseur();
    await pr.hide();
    if (res.status) {
      fournisseurs = res.data!;
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  @override
  void onReady() {
    super.onReady();
    getFournisseurs();
  }
}
