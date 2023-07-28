import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

import 'package:wan_mobile/api/controllers/user_api_ctl.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/tools/cache/cache.dart';
import 'package:wan_mobile/tools/cache/cache_keys.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/answer_security_question_page.dart';
import 'package:wan_mobile/views/static/auth/phone_auth/phone_auth.dart';

class PasswordPageVctl extends ViewController {
  final userApiCtrl = Get.put(UserApiCtl());
  var codeCtl = TextEditingController();
  String phone;
  Pays pays;
  final LocalAuthentication _auth = LocalAuthentication();
  bool supportBiometrics = false;
  bool hasAlreadyAuthenticated = false;

  PasswordPageVctl(this.pays, this.phone);

  Future<void> submit() async {
    await pr.show();
    var res = await userApiCtrl.authenticate(
        phone: pays.callingCode! + phone, password: codeCtl.text);
    await pr.hide();
    if (res.status) {
      var resp = await Cache.setBool(CacheKey.password, true);
      if (resp) {
        await Cache.setString(CacheKey.password, codeCtl.text);
      }
      Get.to(() =>
          AnswerSecurityQuestionPage(res.data!, phone, codeCtl.text, pays));
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  Future<void> logout() async {
    var rep = await Tools.showChoiceMessage(
        message: "Voulez-vous vraiment vous déconnecter ?");
    if (rep == true) {
      await Cache.remove(CacheKey.credentials);
      Get.offAll(() => const PhoneAuth());
    }
  }

  Future<void> _checkBiometric() async {
    supportBiometrics = await _auth.canCheckBiometrics;
    update();
  }

  Future<void> biometricAuthenticate() async {
    if (supportBiometrics) {
      var password = await Cache.getString(CacheKey.password);
      if (password != null) {
        try {
          hasAlreadyAuthenticated = true;
          update();
          var result = await _auth.authenticate(
            localizedReason: "Authentifiez-vous pour continuer",
            authMessages: const [
              AndroidAuthMessages(
                signInTitle: 'Authentifiez-vous',
                cancelButton: 'Entrer le mot de passe',
              ),
              IOSAuthMessages(
                cancelButton: 'Entrer le mot de passe',
              ),
            ],
          );
          if (result) {
            codeCtl.text = password;
            submit();
          }
        } catch (e) {
          if (kDebugMode) {
            Tools.messageBox(
              message:
                  "Désolé, un problème est survenu pendant l'authentification."
                  " Veuillez réessayer.",
            );
            print(e);
          }
        }
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
