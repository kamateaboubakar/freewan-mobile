import 'package:get/get.dart';
import 'package:wan_mobile/views/controllers/app_ctl.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:wan_mobile/tools/utils/tools.dart';

abstract class ViewController extends GetxController {
  late AppCtl _appCtl;
  late ProgressDialog pr;

  ViewController() : pr = Tools.progressDialog();

  AppCtl get appCtl {
    try {
      _appCtl = Get.find();
    } catch (e) {
      _appCtl = Get.put(AppCtl());
    }
    return _appCtl;
  }
}
