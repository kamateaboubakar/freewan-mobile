import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/controllers/auth/register_page_vctl.dart';
import 'package:wan_mobile/views/static/auth/register/confirm_password_register.dart';
import 'package:wan_mobile/views/static/auth/register/email_register.dart';
import 'package:wan_mobile/views/static/auth/register/infos_perso_register.dart';
import 'package:wan_mobile/views/static/auth/register/password_register.dart';
import 'package:wan_mobile/views/static/auth/register/security_questions_register.dart';
import 'package:wan_mobile/views/static/auth/register/services_register.dart';
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
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: CButton(
                textColor: const Color.fromRGBO(18, 43, 84, 1),
                minWidth: double.infinity,
                height: 48,
                onPressed: () => Get.to(
                  () => const HomePage(
                    displayWelcome: true,
                  ),
                ),
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
                      Image.asset("assets/images/logo_bedoo.png",
                          width: 94, height: 43),
                      SizedBox(
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Text(
                            "${ctl.currentStep}/6",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: ctl.pageController,
                    // physics: const NeverScrollableScrollPhysics(),
                    children: [
                      InfosPersoRegister(ctl),
                      EmailRegister(ctl),
                      SecurityQuestionRegister(ctl),
                      PasswordRegister(ctl),
                      ConfirmPasswordRegister(ctl),
                      ServiceRegister(ctl),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
