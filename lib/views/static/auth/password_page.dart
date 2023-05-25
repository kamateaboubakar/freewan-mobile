import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/controllers/auth/password_page_vctl.dart';

class PasswordPage extends StatelessWidget {
  final String phone;
  final Pays pays;
  const PasswordPage(this.pays, this.phone, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mot de passe")),
      body: GetBuilder<PasswordPageVctl>(
          init: PasswordPageVctl(pays, phone),
          builder: (ctl) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    Const.inLineAppLogo,
                    width: 120,
                    height: 63,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Entrer le mot de passe",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(7, 21, 60, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  OtpTextField(
                    numberOfFields: 5,
                    fieldWidth: 55,
                    borderWidth: 1,
                    focusedBorderColor: Const.primaryColor,
                    enabledBorderColor: const Color.fromRGBO(38, 82, 140, 0.34),
                    filled: true,
                    autoFocus: true,
                    obscureText: true,
                    fillColor: Colors.white,
                    mainAxisAlignment: MainAxisAlignment.center,
                    borderColor: Const.primaryColor,
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {},
                    onSubmit: (value) => ctl.submit(value),
                  ),
                  const SizedBox(height: 40),
                  TextButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => ctl.logout(),
                    label: const Text("Me déconnecter"),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
