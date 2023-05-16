import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/controllers/auth/register_page_vctl.dart';
import 'package:wan_mobile/views/static/auth/register/infos_perso_register.dart';
import 'package:wan_mobile/views/static/auth/register/password_register.dart';
import 'package:wan_mobile/views/static/auth/register/security_questions_register.dart';
import 'package:wan_mobile/views/static/auth/register/services_register.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPageVctl>(
      init: RegisterPageVctl(),
      builder: (ctl) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: CButton(
              textColor: Colors.white,
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
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => ctl.prevStep(),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Image.asset("assets/images/logo_bedoo.png",
                            width: 94, height: 43),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Text(
                          "${ctl.currentStep + 1}/3",
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
                    InfosPersoRegister(ctl),
                    SecurityQuestionRegister(ctl),
                    PasswordRegister(ctl),
                    // ServiceRegister(ctl),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
