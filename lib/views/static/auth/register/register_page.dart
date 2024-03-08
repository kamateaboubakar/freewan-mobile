import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/models/pays.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/controllers/auth/register_page_vctl.dart';
import 'package:wan_mobile/views/static/auth/register/infos_perso_register.dart';
import 'package:wan_mobile/views/static/auth/register/password_register.dart';
import 'package:wan_mobile/views/static/auth/register/security_questions_register.dart';

class RegisterPage extends StatelessWidget {
  final Pays selectedPays;
  final String phone;
  const RegisterPage(this.selectedPays, this.phone, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPageVctl>(
      init: RegisterPageVctl(selectedPays, phone),
      builder: (ctl) {
        return Scaffold(
          appBar: AppBar(title: const Text("Inscription")),
          body: SingleChildScrollView(
            child: Stepper(
              physics: const NeverScrollableScrollPhysics(),
              currentStep: ctl.currentStep,
              onStepContinue: ctl.nextStep,
              onStepCancel: ctl.prevStep,
              controlsBuilder: (context, details) => Row(
                children: [
                  CButton(
                    borderRadius: 2,
                    color: AssetColors.blue,
                    onPressed: details.onStepContinue,
                    child: const Text("Continuer"),
                  ),
                  const Gap(20),
                  Visibility(
                    visible: details.currentStep > 0,
                    child: CButton(
                      textColor: AssetColors.blue,
                      borderRadius: 2,
                      color: Colors.transparent,
                      onPressed: details.onStepCancel,
                      child: const Text("Retour"),
                    ),
                  ),
                ],
              ),
              steps: [
                Step(
                  title: const Text("Informations personnelles"),
                  content: InfosPersoRegister(ctl),
                ),
                Step(
                  title: const Text("Questions de securité"),
                  content: SecurityQuestionRegister(ctl),
                ),
                Step(
                  title: const Text("Saisir votre mot de passe"),
                  content: PasswordRegister(ctl),
                ),
              ],
            ),
          ),
          // bottomNavigationBar: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          //   child: SafeArea(
          //     child: CButton(
          //       textColor: Colors.white,
          //       color: AssetColors.blue,
          //       minWidth: double.infinity,
          //       height: 50,
          //       onPressed: () => ctl.nextStep(),
          //       child: const Text(
          //         "Continue",
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // body: Column(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 20),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Row(
          //             children: [
          //               IconButton(
          //                 onPressed: () => ctl.prevStep(),
          //                 icon: const Icon(Icons.arrow_back),
          //               ),
          //               Image.asset(
          //                 Const.inLineAppLogo,
          //                 width: 120,
          //                 height: 63,
          //               ),
          //             ],
          //           ),
          //           SizedBox(
          //             width: 50,
          //             child: ClipRRect(
          //               borderRadius: BorderRadius.circular(5),
          //               child: Text(
          //                 "${ctl.currentStep + 1}/3",
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     Expanded(
          //       child: PageView(
          //         controller: ctl.pageController,
          //         physics: const NeverScrollableScrollPhysics(),
          //         children: [
          //           InfosPersoRegister(ctl),
          //           SecurityQuestionRegister(ctl),
          //           PasswordRegister(ctl),
          //           // ServiceRegister(ctl),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        );
      },
    );
  }
}
