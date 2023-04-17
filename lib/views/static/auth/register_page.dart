import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_dropdown_field.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/auth/register_page_vctl.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPageVctl>(
        init: RegisterPageVctl(),
        builder: (ctl) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back),
                ),
                elevation: 0,
              ),
              bottomNavigationBar: Container(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Le lorem ipsum est, en imprimerie, une suite de mots sans "
                  "signification utilisée à titre provisoire pour calibrer une"
                  " mise en page, le texte définitif venant remplacer",
                  style: TextStyle(fontSize: 10),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Logo"),
                        SizedBox(height: 20),
                        Text(
                          "Create an account",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stepper(
                      currentStep: ctl.currentStep,
                      onStepCancel: () => ctl.prevStep(),
                      onStepContinue: () => ctl.nextStep(),
                      steps: [
                        Step(
                          title: const Text(
                              "Enter your email and password to create account"),
                          content: Form(
                            key: ctl.form1,
                            child: Column(
                              children: [
                                CDropdownField(
                                  require: true,
                                  margin: EdgeInsets.zero,
                                  labelText: "Pays",
                                  items: ctl.pays,
                                  itemAsString: (e) =>
                                      "${e.label}(${e.libelle})",
                                  onChanged: (e) {
                                    ctl.selectedPays = e;
                                    ctl.update();
                                  },
                                ),
                                const SizedBox(height: 20),
                                CTextFormField(
                                  controller: ctl.telCtl,
                                  maxLength:
                                      ctl.selectedPays?.phoneNumberLength,
                                  require: true,
                                  margin: EdgeInsets.zero,
                                  labelText: "Téléphone",
                                ),
                                const SizedBox(height: 20),
                                CTextFormField(
                                  controller: ctl.emailCtl,
                                  require: true,
                                  margin: EdgeInsets.zero,
                                  labelText: "E-mail address",
                                ),
                                const SizedBox(height: 20),
                                CTextFormField(
                                  controller: ctl.passwordCtl,
                                  require: true,
                                  obscureText: ctl.hidePass,
                                  margin: EdgeInsets.zero,
                                  labelText: "Password",
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      ctl.hidePass = !ctl.hidePass;
                                      ctl.update();
                                    },
                                    icon: const Icon(Icons.remove_red_eye),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Step(
                          title: const Text("Select your securities questions"),
                          content: Column(
                            children: ctl.securityQuestions
                                .map(
                                  (e) => CheckboxListTile(
                                    title: Text(e.label ?? ""),
                                    onChanged: (vaue) {
                                      if (ctl.selectedQuestions
                                          .where((el) =>
                                              el.securityQuestionId ==
                                              e.securityQuestionId)
                                          .isNotEmpty) {
                                        ctl.selectedQuestions.removeWhere(
                                            (el) =>
                                                el.securityQuestionId ==
                                                e.securityQuestionId);
                                      } else {
                                        if (ctl.selectedQuestions.length < 5) {
                                          ctl.selectedQuestions.add(e);
                                        } else {
                                          Get.snackbar(
                                              "Message",
                                              "Vous avez déjà 5 questions."
                                                  " Vous pouvez passer à l'étape suivant.");
                                        }
                                      }
                                      ctl.update();
                                    },
                                    value: (ctl.selectedQuestions.contains(e)),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Step(
                          title: const Text(
                              "Response to your securities questions"),
                          content: Form(
                            key: ctl.form2,
                            child: Column(
                              children: ctl.selectedQuestions
                                  .map(
                                    (e) => Column(
                                      children: [
                                        ListTile(
                                          title: Text(e.label ?? ""),
                                        ),
                                        CTextFormField(
                                          require: true,
                                          initialValue: e.answer,
                                          onChanged: (value) {
                                            e.answer = value;
                                            ctl.update();
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
              // PageView(
              //   controller: ctl.pageCtl,
              //   children: [
              //     ListView(
              //       padding: const EdgeInsets.all(20),
              //       children: [
              //         const Text("Logo"),
              //         const SizedBox(height: 20),
              //         const Text(
              //           "Create an account",
              //           style:
              //               TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              //         ),
              //         const SizedBox(height: 5),
              //         const Text(
              //             "Enter your email and password to create account"),
              //         const SizedBox(height: 20),
              //         const CTextFormField(
              //           margin: EdgeInsets.zero,
              //           labelText: "E-mail address",
              //         ),
              //         const SizedBox(height: 20),
              //         CTextFormField(
              //           margin: EdgeInsets.zero,
              //           labelText: "Password",
              //           suffixIcon: IconButton(
              //             onPressed: () {},
              //             icon: const Icon(Icons.remove_red_eye),
              //           ),
              //         ),
              //         const SizedBox(height: 40),
              //         CButton(
              //           height: 45,
              //           onPressed: () => ctl.pageCtl.nextPage(
              //               duration: const Duration(milliseconds: 100),
              //               curve: Curves.easeIn),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: const [
              //               Text(
              //                 "Next",
              //                 style: TextStyle(fontSize: 18),
              //               ),
              //               SizedBox(width: 10),
              //               Icon(Icons.arrow_forward, size: 16),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(20),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           const Text("Logo"),
              //           const SizedBox(height: 20),
              //           const Text(
              //             "Create an account",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold, fontSize: 24),
              //           ),
              //           const SizedBox(height: 5),
              //           const Text(
              //               "Choose a security question to secure your account"),
              //           Expanded(
              //             child: Stepper(steps: [
              //               Step(
              //                 title: const Text("data"),
              //                 content: Column(
              //                   children: [],
              //                 ),
              //               ),
              //             ]),
              //             // ListView(
              //             //   padding: const EdgeInsets.symmetric(vertical: 20),
              //             //   children: List.generate(
              //             //     10,
              //             //     (index) => Container(
              //             //       margin: const EdgeInsets.only(bottom: 10),
              //             //       decoration: BoxDecoration(
              //             //         borderRadius: BorderRadius.circular(10),
              //             //         border: Border.all(color: Colors.black26),
              //             //       ),
              //             //       child: CheckboxListTile(
              //             //         shape: RoundedRectangleBorder(
              //             //           borderRadius: BorderRadius.circular(10),
              //             //         ),
              //             //         onChanged: (value) {},
              //             //         title: Text("Question de securite num $index"),
              //             //         checkboxShape: const CircleBorder(),
              //             //         value: false,
              //             //       ),
              //             //     ),
              //             //   ),
              //             // ),
              //           ),
              //           const SizedBox(height: 20),
              //           const CTextFormField(
              //             labelText: "Réponse",
              //           ),
              //           const SizedBox(height: 5),
              //           CButton(
              //             height: 45,
              //             borderRadius: 5,
              //             onPressed: () => Get.offAll(() => const HomePage()),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: const [
              //                 Icon(Icons.lock, size: 16),
              //                 SizedBox(width: 10),
              //                 Text(
              //                   "Next",
              //                   style: TextStyle(fontSize: 18),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              );
        });
  }
}
