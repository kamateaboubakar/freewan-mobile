import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/user_api_ctl.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/answer_security_question_page.dart';

class PasswordPageVctl extends ViewController {
  String phone;
  Pays pays;
  var passCtl = TextEditingController();

  PasswordPageVctl(this.pays, this.phone);

  Future<void> submit() async {
    if (passCtl.text.isNotEmpty) {
      await pr.show();
      var res = await UserApiCtl().authenticate(
          phone: pays.callingCode! + phone, password: passCtl.text);
      await pr.hide();
      if (res.status) {
        Get.to(
          () =>
              AnswerSecurityQuestionPage(res.data!, phone, passCtl.text, pays),
        );
      } else {
        Tools.messageBox(message: res.message);
      }
    } else {
      Tools.messageBox(message: "Veuillez saisir votre mot de passe.");
    }
  }
}
