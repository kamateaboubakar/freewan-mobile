import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/models/security_question.dart';

import 'package:module_master/module_master.dart';

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    Const.inLineAppLogo,
                    width: 120,
                    height: 80,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Question de sécurité",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(7, 21, 60, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "${question.label}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CTextFormField(
                    autofocus: true,
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
