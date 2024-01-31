import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/services/biometric_auth_service.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/auth/user_api_ctl.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/tools/cache/cache_keys.dart';
import 'package:wan_mobile/views/static/auth/answer_security_question_page.dart';
import 'package:wan_mobile/views/static/auth/phone_auth/phone_auth.dart';

class PasswordPageVctl extends ViewController {
  final userApiCtrl = Get.put(UserApiCtl());
  var passwordCtl = TextEditingController();
  String phone;

  bool supportBiometrics = false;
  bool hasAlreadyAuthenticated = false;

  PasswordPageVctl(this.phone);

  Future<void> submit() async {
    await pr.show();
    var res = await userApiCtrl.authenticate(
        phone: phone, password: passwordCtl.text);
    await pr.hide();
    if (res.status) {
      await Cache.setString(CacheKey.password.name, passwordCtl.text);

      passwordCtl.clear();
      Get.to(
          () => AnswerSecurityQuestionPage(res.data!, phone, passwordCtl.text));
    } else {
      Tools.messageBox(message: res.message);
      passwordCtl.clear();
    }
  }

  Future<void> logout() async {
    var rep = await Tools.showChoiceMessage(
        message: "Voulez-vous vraiment vous déconnecter ?");
    if (rep == true) {
      await Cache.clear();
      Get.offAll(() => const PhoneAuth());
    }
  }

  Future<void> _checkBiometric() async {
    supportBiometrics = await BiometricAuthService.isAvailable;
    update();
  }

  Future<void> biometricAuthenticate() async {
    var password = await Cache.getString(CacheKey.password.name);
    if (password != null) {
      var result = await BiometricAuthService.check();
      if (result.status) {
        hasAlreadyAuthenticated = true;
        update();

        passwordCtl.text = password;
        submit();
      } else {
        hasAlreadyAuthenticated = false;
        update();
      }
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await _checkBiometric();
    await biometricAuthenticate();
  }
}
