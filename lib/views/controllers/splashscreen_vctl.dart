import 'dart:convert';

import 'package:get/get.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/tools/cache/cache.dart';
import 'package:wan_mobile/tools/cache/cache_keys.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/password_page.dart';

import 'package:wan_mobile/views/static/auth/phone_auth/phone_auth.dart';

class SplashscreenVctl extends ViewController {
  redirect() async {
    await Future.delayed(const Duration(seconds: 3));
    var res = await Cache.getString(CacheKey.credentials);
    if (res != null) {
      Map<String, dynamic> cache = json.decode(res);
      Pays pays = Pays.fromJson(cache["pays"]);
      String phone = cache["phone"];
      Get.off(() => PasswordPage(pays, phone));
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
