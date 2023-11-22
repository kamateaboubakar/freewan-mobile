import 'package:wan_mobile/api/controllers/pays_api_ctl.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/controllers/auth/phone_auth_vctl.dart';

class BottomSheetPhoneAuthVctl extends ViewController {
  PhoneAuthVctl pCtl;

  bool loading = false;

  BottomSheetPhoneAuthVctl(this.pCtl);

  Future<void> fetchPays({force = false}) async {
    if (pCtl.pays.isEmpty || force) {
      loading = true;
      update();
      var res = await PaysApiCtl().getAll();
      loading = false;
      update();
      if (res.status) {
        pCtl.pays = res.data!;
        update();
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    fetchPays();
  }
}
