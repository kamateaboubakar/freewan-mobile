import 'package:get/get.dart';
import 'package:module_master/tools/tools.dart';
import 'package:wan_mobile/views/controllers/app_ctl.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

abstract class ViewController extends GetxController {
  late AppCtl _appCtl;
  late ProgressDialog pr;

  ViewController() {
    pr = Tools.progressDialog();
    try {
      _appCtl = Get.find();
    } catch (e) {
      _appCtl = Get.put(AppCtl());
    }
  }

  AppCtl get appCtl => _appCtl;
}
