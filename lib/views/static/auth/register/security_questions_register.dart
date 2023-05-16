import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_dropdown_field.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/auth/register_page_vctl.dart';

class SecurityQuestionRegister extends StatelessWidget {
  final RegisterPageVctl ctl;
  const SecurityQuestionRegister(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ctl.questionFormKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Questions de sécurité",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(7, 21, 60, 1),
              ),
            ),
            const Text(
              "5 questions pour récupérer votre compte en cas de bésoin",
              style: TextStyle(
                fontSize: 13,
                color: Color.fromRGBO(38, 82, 140, 1),
              ),
            ),
            Expanded(
              child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      width: double.infinity,
                      child: Column(
                        children: [
                          CDropdownField(
                              require: true,
                              hintText: "Question 1",
                              items: ctl.getAvailaibleQuestions,
                              selectedItem: ctl.q1,
                              itemAsString: (e) => e.name ?? "Question 1",
                              onChanged: (value) {
                                ctl.q1 = value!;
                                ctl.update();
                              }),
                          CTextFormField(
                              require: true,
                              initialValue: ctl.q1.answer,
                              enabled: ctl.q1.id != null,
                              hintText: "La réponse ici",
                              onChanged: (value) {
                                ctl.q1.answer = value;
                                ctl.update();
                              }),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      width: double.infinity,
                      child: Column(
                        children: [
                          CDropdownField(
                              require: true,
                              hintText: "Question 2",
                              selectedItem: ctl.q2,
                              items: ctl.getAvailaibleQuestions,
                              itemAsString: (e) => e.name ?? "Question 2",
                              onChanged: (value) {
                                ctl.q2 = value!;
                                ctl.update();
                              }),
                          CTextFormField(
                              require: true,
                              initialValue: ctl.q2.answer,
                              hintText: "La réponse ici",
                              enabled: ctl.q2.id != null,
                              onChanged: (value) {
                                ctl.q2.answer = value;
                                ctl.update();
                              }),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      width: double.infinity,
                      child: Column(
                        children: [
                          CDropdownField(
                              require: true,
                              hintText: "Question 3",
                              selectedItem: ctl.q3,
                              items: ctl.getAvailaibleQuestions,
                              itemAsString: (e) => e.name ?? "Question 3",
                              onChanged: (value) {
                                ctl.q3 = value!;
                                ctl.update();
                              }),
                          CTextFormField(
                              initialValue: ctl.q3.answer,
                              require: true,
                              hintText: "La réponse ici",
                              enabled: ctl.q3.id != null,
                              onChanged: (value) {
                                ctl.q3.answer = value;
                                ctl.update();
                              }),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      width: double.infinity,
                      child: Column(
                        children: [
                          CDropdownField(
                              require: true,
                              hintText: "Question 4",
                              selectedItem: ctl.q4,
                              items: ctl.getAvailaibleQuestions,
                              itemAsString: (e) => e.name ?? "Question 4",
                              onChanged: (value) {
                                ctl.q4 = value!;
                                ctl.update();
                              }),
                          CTextFormField(
                              initialValue: ctl.q4.answer,
                              require: true,
                              hintText: "La réponse ici",
                              enabled: ctl.q4.id != null,
                              onChanged: (value) {
                                ctl.q4.answer = value;
                                ctl.update();
                              }),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      width: double.infinity,
                      child: Column(
                        children: [
                          CDropdownField(
                              require: true,
                              hintText: "Question 5",
                              selectedItem: ctl.q5,
                              items: ctl.getAvailaibleQuestions,
                              itemAsString: (e) => e.name ?? "Question 5",
                              onChanged: (value) {
                                ctl.q5 = value!;
                                ctl.update();
                              }),
                          CTextFormField(
                              require: true,
                              hintText: "La réponse ici",
                              enabled: ctl.q5.id != null,
                              initialValue: ctl.q5.answer,
                              onChanged: (value) {
                                ctl.q5.answer = value;
                                ctl.update();
                              }),
                        ],
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
