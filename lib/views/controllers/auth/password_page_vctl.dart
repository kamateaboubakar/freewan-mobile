import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/services/biometric_auth_service.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/auth/user_api_ctl.dart';
import 'package:wan_mobile/models/auth/credentials.dart';
import 'package:wan_mobile/tools/cache/cache_keys.dart';
import 'package:wan_mobile/views/static/auth/answer_security_question_page.dart';
import 'package:wan_mobile/views/static/auth/phone_auth/phone_auth.dart';

class PasswordPageVctl extends ViewController {
  var passwordCtl = TextEditingController();
  String phone;

  bool supportBiometrics = false;
  bool hasAlreadyAuthenticated = false;
  bool biometricAuthStatus = true;

  PasswordPageVctl(this.phone);

  Future<void> submit() async {
    await EasyLoading.show(maskType: EasyLoadingMaskType.black);
    var res = await UserApiCtl.authenticate(
      phone: phone,
      password: passwordCtl.text,
    );
    await EasyLoading.dismiss();
    if (res.status) {
      await Get.to(
        () => AnswerSecurityQuestionPage(
          res.data!,
          phone,
          passwordCtl.text,
        ),
      );
      passwordCtl.clear();
    } else {
      Tools.messageBox(title: AppConst.appName, message: res.message);
      passwordCtl.clear();
    }
  }

  Future<void> logout() async {
    var rep = await Tools.showChoiceMessage(
      title: AppConst.appName,
      message: "Voulez-vous vraiment vous déconnecter ?",
      secondaryColor: AssetColors.blue,
    );
    if (rep == true) {
      await Cache.clear();
      Get.offAll(() => const PhoneAuth());
    }
  }

  Future<void> _checkBiometric() async {
    supportBiometrics = await BiometricAuthService.isAvailable;
    update();
  }

  Future<void> _getBiometricStatus() async {
    var res = await Cache.getBool(CacheKey.biometricAuthStatus.name);
    biometricAuthStatus = res ?? true;
    update();
  }

  Future<void> biometricAuthenticate() async {
    var creds = await Credentials.fromCache();
    if (creds != null && creds.password.value.isNotEmpty) {
      var result = await BiometricAuthService.check();
      if (result.status) {
        hasAlreadyAuthenticated = true;
        passwordCtl.text = creds.password.value;
        update();
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
    await _getBiometricStatus();
    await _checkBiometric();
    if (biometricAuthStatus) {
      await biometricAuthenticate();
    }
  }
}
