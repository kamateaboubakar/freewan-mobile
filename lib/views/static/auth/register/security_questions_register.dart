import 'package:advance_expansion_tile/advance_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:wan_mobile/models/security_question.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/tools/widgets/c_dropdown_field.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/auth/register_page_vctl.dart';

class SecurityQuestionRegister extends StatelessWidget {
  final RegisterPageVctl ctl;
  const SecurityQuestionRegister(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Security Questions",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(7, 21, 60, 1),
            ),
          ),
          const Text(
            "These will help you recover your account",
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
                          hintText: "Question 1",
                          items: ctl.getAvailaibleQuestions,
                          selectedItem: ctl.selectedQuestions[0],
                          itemAsString: (e) => e.label ?? "Question 1",
                          onChanged: (value) =>
                              ctl.selectQuestion(e: value!, index: 0),
                        ),
                        CTextFormField(
                          enabled:
                              ctl.selectedQuestions[0].securityQuestionId !=
                                  null,
                          hintText: "Answer here",
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    width: double.infinity,
                    child: Column(
                      children: [
                        CDropdownField(
                          hintText: "Question 2",
                          selectedItem: ctl.selectedQuestions[1],
                          items: ctl.getAvailaibleQuestions,
                          itemAsString: (e) => e.label ?? "Question 2",
                          onChanged: (value) =>
                              ctl.selectQuestion(e: value!, index: 1),
                        ),
                        CTextFormField(
                          hintText: "Answer here",
                          enabled:
                              ctl.selectedQuestions[1].securityQuestionId !=
                                  null,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    width: double.infinity,
                    child: Column(
                      children: [
                        CDropdownField(
                          hintText: "Question 3",
                          selectedItem: ctl.selectedQuestions[2],
                          items: ctl.getAvailaibleQuestions,
                          itemAsString: (e) => e.label ?? "Question 3",
                          onChanged: (value) =>
                              ctl.selectQuestion(e: value!, index: 2),
                        ),
                        CTextFormField(
                          hintText: "Answer here",
                          enabled:
                              ctl.selectedQuestions[2].securityQuestionId !=
                                  null,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    width: double.infinity,
                    child: Column(
                      children: [
                        CDropdownField(
                          hintText: "Question 4",
                          selectedItem: ctl.selectedQuestions[3],
                          items: ctl.getAvailaibleQuestions,
                          itemAsString: (e) => e.label ?? "Question 4",
                          onChanged: (value) =>
                              ctl.selectQuestion(e: value!, index: 3),
                        ),
                        CTextFormField(
                          hintText: "Answer here",
                          enabled:
                              ctl.selectedQuestions[3].securityQuestionId !=
                                  null,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    width: double.infinity,
                    child: Column(
                      children: [
                        CDropdownField(
                          hintText: "Question 5",
                          selectedItem: ctl.selectedQuestions[4],
                          items: ctl.getAvailaibleQuestions,
                          itemAsString: (e) => e.label ?? "Question 5",
                          onChanged: (value) =>
                              ctl.selectQuestion(e: value!, index: 4),
                        ),
                        CTextFormField(
                          hintText: "Answer here",
                          enabled:
                              ctl.selectedQuestions[4].securityQuestionId !=
                                  null,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
