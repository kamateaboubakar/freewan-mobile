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
        question: question,
        password: password,
        phone: phone,
      ),
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
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "Question de sécurité",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(7, 21, 60, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(question.label.value),
                ),
                const SizedBox(height: 20),
                CTextFormField(
                  controller: ctl.answerCtl,
                  hintText: "Saisir la reponse",
                ),
                const SizedBox(height: 20),
                CButton(
                  height: 50,
                  color: AssetColors.blue,
                  minWidth: double.infinity,
                  onPressed: () => ctl.submit(),
                  child: const Text("Valider"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
