import 'dart:convert';

import 'package:get/get.dart';

import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/cache/cache_keys.dart';
import 'package:wan_mobile/views/static/auth/password_page.dart';

import 'package:wan_mobile/views/static/auth/phone_auth/phone_auth.dart';

class SplashscreenVctl extends ViewController {
  redirect() async {
    await Future.delayed(const Duration(seconds: 3));
    var res = await Cache.getString(CacheKey.login.name);
    if (res != null) {
      Map<String, dynamic> cache = json.decode(res);

      String phone = cache["phone"];
      Get.off(() => PasswordPage(phone: phone));
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
