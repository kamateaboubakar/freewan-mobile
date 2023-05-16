import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/security_question.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';

class AnswerSecurityQuestionPageVctl extends ViewController {
  SecurityQuestion question;
  var answerCtl = TextEditingController();
  AnswerSecurityQuestionPageVctl(this.question);

  void submit() {
    if (answerCtl.text == question.answer) {
      Get.offAll(() => const HomePage());
    } else {
      Tools.messageBox(message: "Réponse incorrecte.");
    }
  }

  @override
  void dispose() {
    answerCtl.dispose();
    super.dispose();
  }
}
