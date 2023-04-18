import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/views/controllers/auth/opt_auth_vctl.dart';
import 'package:wan_mobile/views/static/auth/register/register_page.dart';

class OPTAuth extends StatelessWidget {
  final String phone;
  const OPTAuth({required this.phone, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<OptAuthVctl>(
          init: OptAuthVctl(phone),
          builder: (context) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/logo_bedoo.png",
                    width: 94,
                    height: 43,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter OTP Code",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(7, 21, 60, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "We sent you the code via SMS",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromRGBO(38, 82, 140, 1),
                    ),
                  ),
                  const SizedBox(height: 27),
                  OtpTextField(
                    numberOfFields: 4,
                    fieldWidth: 60,
                    borderWidth: 1,
                    focusedBorderColor: Const.primaryColor,
                    enabledBorderColor: const Color.fromRGBO(38, 82, 140, 0.34),
                    filled: true,
                    autoFocus: true,
                    fillColor: Colors.white,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    borderColor: Const.primaryColor,
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {},
                    onSubmit: (String verificationCode) {
                      Get.to(() => const RegisterPage());
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text.rich(
                    TextSpan(
                      text: "Did not receive it yet? ",
                      children: [
                        TextSpan(
                          text: "Tap here to resend the code",
                          style: TextStyle(color: Const.primaryColor),
                        ),
                      ],
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
