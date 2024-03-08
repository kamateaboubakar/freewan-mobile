import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/models/auth/credentials.dart';
import 'package:wan_mobile/views/static/auth/password_page.dart';
import 'package:wan_mobile/views/static/auth/phone_auth/phone_auth.dart';

class SplashscreenVctl extends ViewController {
  redirect() async {
    await Future.delayed(const Duration(seconds: 3));
    var cred = await Credentials.fromCache();
    if (cred != null) {
      Get.off(() => PasswordPage(phone: cred.phone.value));
    } else {
      Get.off(() => const PhoneAuth());
    }
  }

  @override
  void onReady() {
    super.onReady();
    redirect();
  }
}
