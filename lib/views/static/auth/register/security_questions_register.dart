import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/controllers/auth/register_page_vctl.dart';
import 'package:wan_mobile/views/static/auth/register/question_security_form.dart';

class SecurityQuestionRegister extends StatelessWidget {
  final RegisterPageVctl ctl;
  const SecurityQuestionRegister(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: List.generate(ctl.selectedQuestions.length, (index) {
          var e = ctl.selectedQuestions[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: (e.answer != null) ? Colors.green : Colors.grey,
              radius: 14,
              child: Icon(
                (e.answer != null) ? Icons.check : Icons.question_mark_sharp,
                size: 17,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            title: Text(
              e.id == null ? "Sélectionnez une question" : e.label.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Visibility(
              visible: e.id != null,
              child: IconButton(
                tooltip: "Supprimer la réponse",
                splashRadius: 20,
                onPressed: () async {
                  var rep = await Tools.showChoiceMessage(
                    title: AppConst.appName,
                    message: "Voulez-vous vraiment supprimer cette réponse ?",
                    secondaryColor: AssetColors.blue,
                  );
                  if (rep == true) {
                    ctl.selectedQuestions[index] = SecurityQuestion();
                    ctl.update();
                  }
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ),
            ),
            subtitle:
                e.answer != null ? const Text("Cliquez pour modifier") : null,
            onTap: () async {
              var res = await Get.to(
                () => QuestionSecurityForm(
                    e,
                    ctl.selectedQuestions
                        .where((e) => e.id != null)
                        .map((e) => e.id!)
                        .toList()),
              );
              if (res is SecurityQuestion) {
                ctl.selectedQuestions[index] = res;
                ctl.update();
              }
            },
          );
        }),
      ),
    );
  }
}
