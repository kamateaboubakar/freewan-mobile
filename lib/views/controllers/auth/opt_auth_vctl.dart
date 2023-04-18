import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:wan_mobile/api/controllers/user_api_ctl.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/register/register_page.dart';

class OptAuthVctl extends ViewController {
  late ProgressDialog pr;

  Pays selectedPays;

  OptAuthVctl({required this.selectedPays}) : pr = Tools.progressDialog();

  Future<void> submit({required String code, required String phone}) async {
    if (code.isNotEmpty) {
      await pr.show();
      var res = await UserApiCtl().verifyOtp(code: code, phone: phone);
      await pr.hide();
      if (res.status) {
        Get.to(() => RegisterPage(selectedPays: selectedPays));
      } else {
        Tools.messageBox(message: res.message);
      }
    }
  }
}
