import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/views/controllers/auth/password_page_vctl.dart';

class PasswordPage extends StatelessWidget {
  final String phone;

  const PasswordPage({required this.phone, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PasswordPageVctl>(
      init: PasswordPageVctl(phone),
      builder: (ctl) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              tooltip: "Déconnectez-vous",
              color: AssetColors.blueButton,
              icon: const Icon(Icons.arrow_back),
              onPressed: ctl.logout,
            ),
            title: const Text("Mot de passe"),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Const.inLineAppLogo,
                        width: 120,
                        height: 80,
                      ),
                      const SizedBox(height: 10),
                      const AutoSizeText(
                        "Entrer votre mot de passe",
                        maxFontSize: 20,
                        minFontSize: 15,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(7, 21, 60, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      PinCodeTextField(
                        readOnly: true,
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
                          inactiveColor:
                              const Color.fromRGBO(38, 82, 140, 0.34),
                          activeColor: const Color.fromRGBO(38, 82, 140, 0.34),
                          selectedColor: AssetColors.blue,
                          activeFillColor: Colors.white,
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: const Text("Mot de passe oublié?"),
                      // ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 0),
              NumericKeyboard(
                onKeyboardTap: (String text) {
                  if (ctl.passwordCtl.text.length < 5) {
                    ctl.passwordCtl.text += text;
                    if (ctl.passwordCtl.text.length == 5) {
                      ctl.submit();
                    }
                  }
                },
                rightButtonFn: () {
                  if (ctl.passwordCtl.text.isNotEmpty) {
                    ctl.passwordCtl.text = ctl.passwordCtl.text
                        .substring(0, ctl.passwordCtl.text.length - 1);
                  }
                },
                leftButtonFn: ctl.biometricAuthenticate,
                leftIcon: Visibility(
                  visible:
                      (ctl.supportBiometrics && ctl.hasAlreadyAuthenticated),
                  child: const Icon(Icons.fingerprint),
                ),
                rightIcon: const Icon(Icons.backspace),
                textStyle: TextStyle(
                  fontSize: 23.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
