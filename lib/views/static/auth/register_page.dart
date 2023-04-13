import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
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
            body: PageView(
              controller: ctl.pageCtl,
              children: [
                ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    const Text("Logo"),
                    const SizedBox(height: 20),
                    const Text(
                      "Create an account",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                        "Enter your email and password to create account"),
                    const SizedBox(height: 20),
                    const CTextFormField(
                      margin: EdgeInsets.zero,
                      hintText: "E-mail address",
                    ),
                    const SizedBox(height: 20),
                    CTextFormField(
                      margin: EdgeInsets.zero,
                      hintText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove_red_eye),
                      ),
                    ),
                    const SizedBox(height: 40),
                    CButton(
                      height: 45,
                      onPressed: () => ctl.pageCtl.nextPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeIn),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Next",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Logo"),
                      const SizedBox(height: 20),
                      const Text(
                        "Create an account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                          "Choose a security question to secure your account"),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          children: List.generate(
                            10,
                            (index) => Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black26),
                              ),
                              child: CheckboxListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                onChanged: (value) {},
                                title: Text("Question de securite num $index"),
                                checkboxShape: const CircleBorder(),
                                value: false,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const CTextFormField(
                        labelText: "Réponse",
                      ),
                      const SizedBox(height: 5),
                      CButton(
                        height: 45,
                        borderRadius: 5,
                        onPressed: () => Get.offAll(() => const HomePage()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.lock, size: 16),
                            SizedBox(width: 10),
                            Text(
                              "Next",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
