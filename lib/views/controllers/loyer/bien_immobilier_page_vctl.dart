import 'package:wan_mobile/api/controllers/loyer/loyer_api_ctl.dart';
import 'package:wan_mobile/models/loyer/abstracts/bloc_appartement.dart';
import 'package:wan_mobile/models/loyer/maison.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class BienImmobilierPageVctl extends ViewController {
  List<BlocAppartement> blocAppartements = [];
  List<Maison> maisons = [];
  bool loadBloc = false;
  bool loadMaisons = false;

  Future<void> fetchBiens() async {
    fetchBlockApparts();
    fetchMaisons();
  }

  Future<void> fetchMaisons() async {
    loadMaisons = true;
    update();
    var res =
        await LoyerApiCtl().getMaisonsByUser(appCtl.user.id.value.toString());
    loadMaisons = false;
    update();
    if (res.status) {
      maisons = res.data!;
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  Future<void> fetchBlockApparts() async {
    loadBloc = true;
    update();
    var res = await LoyerApiCtl()
        .getBlocAppartementsByUser(appCtl.user.id.value.toString());
    loadBloc = false;
    update();
    if (res.status) {
      blocAppartements = res.data!;
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  @override
  void onReady() {
    super.onReady();
    fetchBiens();
  }
}
