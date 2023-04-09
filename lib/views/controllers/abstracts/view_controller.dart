import 'package:get/get.dart';
import 'package:wan_mobile/views/controllers/app_ctl.dart';

abstract class ViewController extends GetxController {
  late AppCtl _appCtl;

  AppCtl get appCtl {
    try {
      _appCtl = Get.find();
    } catch (e) {
      _appCtl = Get.put(AppCtl());
    }
    return _appCtl;
  }
}
