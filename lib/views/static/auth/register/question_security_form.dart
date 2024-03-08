import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/controllers/auth/register/question_security_form_vctl.dart';

class QuestionSecurityForm extends StatelessWidget {
  final SecurityQuestion question;
  final List<int> selectedQuestionsId;
  const QuestionSecurityForm(this.question, this.selectedQuestionsId,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionSecurityFormVctl>(
        init: QuestionSecurityFormVctl(question, selectedQuestionsId),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Question de securité"),
            ),
            body: Form(
              key: ctl.formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  CDropdownField<SecurityQuestion>(
                    require: true,
                    labelText: "Question",
                    asyncItems: (e) => ctl.fetchSecurityQuestion(),
                    selectedItem: ctl.question,
                    onChanged: (e) {
                      ctl.question = e;
                      ctl.update();
                    },
                    itemAsString: (e) => e.label.value,
                  ),
                  const Gap(20),
                  CTextFormField(
                    controller: ctl.answerCtl,
                    require: true,
                    labelText: "Réponse",
                  ),
                  const Gap(20),
                  CButton(
                    color: AssetColors.blue,
                    height: 50,
                    onPressed: ctl.save,
                    child: const Text("Sauvegarder"),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
