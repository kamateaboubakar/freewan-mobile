import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/controllers/auth/answer_security_question_page_vctl.dart';

class AnswerSecurityQuestionPage extends StatelessWidget {
  final SecurityQuestion question;
  final String phone;
  final String password;

  const AnswerSecurityQuestionPage(this.question, this.phone, this.password,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnswerSecurityQuestionPageVctl>(
        init: AnswerSecurityQuestionPageVctl(
            question: question, password: password, phone: phone),
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
