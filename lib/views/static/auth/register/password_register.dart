import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
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
            "Passcode",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(7, 21, 60, 1),
            ),
          ),
          const Text(
            "Choisissez un passcode",
            style: TextStyle(
              fontSize: 13,
              color: Color.fromRGBO(38, 82, 140, 1),
            ),
          ),
          const SizedBox(height: 30),
          OtpTextField(
            numberOfFields: 5,
            fieldWidth: 60,
            borderWidth: 1,
            focusedBorderColor: Const.primaryColor,
            enabledBorderColor: const Color.fromRGBO(38, 82, 140, 0.34),
            filled: true,
            fillColor: Colors.white,
            obscureText: true,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            borderColor: Const.primaryColor,
            showFieldAsBox: true,
            onCodeChanged: (String code) {},
            keyboardType: TextInputType.number,
            onSubmit: (String code) {
              ctl.passwordCtl.text = code;
            },
          ),
          const SizedBox(height: 30),
          const Text(
            "Confimez le mot de passe",
            style: TextStyle(
              fontSize: 13,
              color: Color.fromRGBO(38, 82, 140, 1),
            ),
          ),
          const SizedBox(height: 30),
          OtpTextField(
            numberOfFields: 5,
            fieldWidth: 60,
            borderWidth: 1,
            focusedBorderColor: Const.primaryColor,
            enabledBorderColor: const Color.fromRGBO(38, 82, 140, 0.34),
            filled: true,
            fillColor: Colors.white,
            obscureText: true,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            borderColor: Const.primaryColor,
            showFieldAsBox: true,
            onCodeChanged: (String code) {},
            keyboardType: TextInputType.number,
            onSubmit: (String code) {
              ctl.confirmPasswordCtl.text = code;
            },
          ),
        ],
      ),
    );
  }
}
