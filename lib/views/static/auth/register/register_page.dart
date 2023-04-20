import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/controllers/auth/register_page_vctl.dart';
import 'package:wan_mobile/views/static/auth/register/email_register.dart';
import 'package:wan_mobile/views/static/auth/register/password_register.dart';
import 'package:wan_mobile/views/static/auth/register/security_questions_register.dart';

class RegisterPage extends StatelessWidget {
  final Pays selectedPays;
  const RegisterPage({required this.selectedPays, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPageVctl>(
        init: RegisterPageVctl(selectedPays: selectedPays),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
              elevation: 0,
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: CButton(
                textColor: const Color.fromRGBO(18, 43, 84, 1),
                minWidth: double.infinity,
                height: 48,
                onPressed: () => ctl.nextStep(),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            body: WillPopScope(
              onWillPop: () => ctl.onBack(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/images/logo_bedoo.png",
                            width: 94, height: 43),
                        SizedBox(
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: LinearProgressIndicator(
                              value: (ctl.currentStep + 1) / 3,
                              minHeight: 5,
                              color: const Color.fromRGBO(0, 159, 249, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: ctl.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        EmailRegister(ctl),
                        PasswordRegister(ctl),
                        SecurityQuestionRegister(ctl)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}