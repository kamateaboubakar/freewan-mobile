import 'package:flutter/material.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wan_mobile/views/controllers/auth/register_page_vctl.dart';

class PasswordRegister extends StatelessWidget {
  final RegisterPageVctl ctl;

  const PasswordRegister(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ctl.passFormKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const Text(
              "Choisissez un mot de passe",
              style: TextStyle(
                fontSize: 13,
                color: Color.fromRGBO(38, 82, 140, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            PinCodeTextField(
              obscureText: true,
              controller: ctl.passwordCtl,
              animationType: AnimationType.scale,
              cursorColor: AssetColors.blueButton,
              appContext: context,
              length: 5,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldWidth: 55,
                fieldHeight: 65,
                borderWidth: 1,
                inactiveColor: const Color.fromRGBO(38, 82, 140, 0.34),
                activeColor: const Color.fromRGBO(38, 82, 140, 0.34),
                selectedColor: AssetColors.blue,
                activeFillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Confimez le mot de passe",
              style: TextStyle(
                fontSize: 13,
                color: Color.fromRGBO(38, 82, 140, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            PinCodeTextField(
              obscureText: true,
              controller: ctl.confirmPasswordCtl,
              animationType: AnimationType.scale,
              cursorColor: AssetColors.blueButton,
              appContext: context,
              length: 5,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldWidth: 55,
                fieldHeight: 65,
                borderWidth: 1,
                inactiveColor: const Color.fromRGBO(38, 82, 140, 0.34),
                activeColor: const Color.fromRGBO(38, 82, 140, 0.34),
                selectedColor: AssetColors.blue,
                activeFillColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
