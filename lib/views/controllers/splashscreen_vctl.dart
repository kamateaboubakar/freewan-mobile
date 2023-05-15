import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/pays_api_ctl.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/phone_auth/phone_auth.dart';

class SplashscreenVctl extends ViewController {
  @override
  void onInit() {
    super.onInit();
    redirect();
  }

  redirect() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.off(() => const PhoneAuth());
  }
}
