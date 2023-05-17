import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/models/security_question.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/auth/answer_security_question_page_vctl.dart';

class AnswerSecurityQuestionPage extends StatelessWidget {
  final SecurityQuestion question;
  final String phone;
  final String password;
  final Pays pays;
  const AnswerSecurityQuestionPage(
      this.question, this.phone, this.password, this.pays,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnswerSecurityQuestionPageVctl>(
        init: AnswerSecurityQuestionPageVctl(
            question: question, password: password, phone: phone, pays: pays),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Répondre à la question"),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ListTile(
                    title: Text("${question.label}"),
                  ),
                  const SizedBox(height: 20),
                  CTextFormField(
                    controller: ctl.answerCtl,
                    hintText: "Réponse",
                  ),
                  const SizedBox(height: 20),
                  CButton(
                    height: 50,
                    minWidth: double.infinity,
                    onPressed: () => ctl.submit(),
                    child: const Text("Valider"),
                  )
                ],
              ),
            ),
          );
        });
  }
}
