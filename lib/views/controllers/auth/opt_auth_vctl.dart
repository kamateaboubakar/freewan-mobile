import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:wan_mobile/api/controllers/user_api_ctl.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class OptAuthVctl extends ViewController {
  late ProgressDialog pr;

  String login;

  OptAuthVctl(this.login) : pr = Tools.progressDialog();

  Future<void> submit(String code) async {
    await pr.show();
    var res = await UserApiCtl().verifyOtp(code);
  }
}
