import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/auth/adresse_api_ctl.dart';
import 'package:wan_mobile/models/adresse.dart';

import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';

class AdresseListPageVctl extends ViewController {
  List<Adresse> adresses = [];
  var loading = true;

  Future<void> getAdresses() async {
    loading = true;
    update();
    var res = await AdresseApiCtl().getUserAdresses();
    loading = false;
    update();
    if (res.status) {
      adresses = res.data!;
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  @override
  void onReady() {
    super.onReady();
    getAdresses();
  }
}
