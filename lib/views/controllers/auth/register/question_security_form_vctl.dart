import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/security_question_ctl.dart';

class QuestionSecurityFormVctl extends GetxController {
  SecurityQuestion? question;
  var answerCtl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final List<int> selectedQuestionsId;

  QuestionSecurityFormVctl(
      SecurityQuestion securityQuestion, this.selectedQuestionsId) {
    if (securityQuestion.id != null) {
      question = securityQuestion;
      answerCtl.text = securityQuestion.answer.value;
    }
  }

  Future<List<SecurityQuestion>> fetchSecurityQuestion() async {
    var res = await SecurityQuestionCtl().getAll();
    if (res.status) {
      return res.data!..removeWhere((e) => selectedQuestionsId.contains(e.id));
    } else {
      return [];
    }
  }

  Future<void> save() async {
    if (formKey.currentState!.validate()) {
      question!.answer = answerCtl.text.trim();
      Get.back(result: question);
    }
  }
}
