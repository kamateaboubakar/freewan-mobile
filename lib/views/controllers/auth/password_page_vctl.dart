import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/user_api_ctl.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/tools/cache/cache.dart';
import 'package:wan_mobile/tools/cache/cache_keys.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/answer_security_question_page.dart';
import 'package:wan_mobile/views/static/auth/phone_auth/phone_auth.dart';

class PasswordPageVctl extends ViewController {
  String phone;
  Pays pays;

  PasswordPageVctl(this.pays, this.phone);

  Future<void> submit(String password) async {
    await pr.show();
    var res = await UserApiCtl()
        .authenticate(phone: pays.callingCode! + phone, password: password);
    await pr.hide();
    if (res.status) {
      Get.to(
        () => AnswerSecurityQuestionPage(res.data!, phone, password, pays),
      );
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  Future<void> logout() async {
    var rep = await Tools.showChoiceMessage(
        message: "Voulez-vous vraiment vous déconnecter ?");
    if (rep == true) {
      await Cache.remove(CacheKey.credentials);
      Get.off(() => const PhoneAuth());
    }
  }
}
