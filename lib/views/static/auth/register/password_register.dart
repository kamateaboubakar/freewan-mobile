import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/auth/register_page_vctl.dart';

class PasswordRegister extends StatelessWidget {
  final RegisterPageVctl ctl;
  const PasswordRegister(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ctl.passFormKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Enter your password",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(7, 21, 60, 1),
            ),
          ),
          const SizedBox(height: 30),
          CTextFormField(
            obscureText: true,
            require: true,
            controller: ctl.passwordCtl,
            hintText: "Enter your password",
          ),
          const Text(
            "At least 8 characters",
            style: TextStyle(
              fontSize: 11,
              color: Color.fromRGBO(38, 82, 140, 1),
            ),
          ),
          const SizedBox(height: 15),
          CTextFormField(
              obscureText: true,
              require: true,
              controller: ctl.confirmPasswordCtl,
              hintText: "Confirm your password"),
        ],
      ),
    );
  }
}