import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/views/controllers/auth/opt_auth_vctl.dart';

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
                  const Text("Logo"),
                  const SizedBox(height: 10),
                  const Text("Enter OTP Code", style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  const Text("We sent you the code via SMS"),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: OtpTextField(
                      numberOfFields: 4,
                      fieldWidth: 60,
                      borderColor: Const.primaryColor,
                      showFieldAsBox: true,
                      onCodeChanged: (String code) {},
                      onSubmit: (String verificationCode) {
                        print(verificationCode);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text.rich(
                    TextSpan(text: "Did not receive it yet? ", children: [
                      TextSpan(
                        text: "Tap here to resend the code",
                        style: TextStyle(color: Const.primaryColor),
                      ),
                    ]),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
