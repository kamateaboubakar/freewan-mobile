import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/views/controllers/auth/opt_auth_vctl.dart';

import '../../../tools/utils/asset_colors.dart';

class OPTAuth extends StatelessWidget {
  final void Function(String code) onSubmit;
  final void Function() resendOtp;
  final String phone;
  final Pays? selectedPays;

  const OPTAuth(
      {required this.onSubmit,
      required this.phone,
      required this.resendOtp,
      super.key,
      this.selectedPays});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<OptAuthVctl>(
        init: OptAuthVctl(),
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
                  onSubmit: onSubmit,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CountdownTimer(
                        endTime: DateTime.now()
                                .add(const Duration(minutes: 3))
                                .millisecondsSinceEpoch +
                            1000,
                        widgetBuilder: (context, time) {
                          return Text(
                            "${time?.min ?? "0"}:${time?.sec ?? "00"}",
                            style: const TextStyle(
                              color: AssetColors.blueButton,
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                            ),
                          );
                        },
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Pas encore reçu ? ",
                        children: [
                          TextSpan(
                            text: "Cliquez ici pour renvoyer",
                            style: const TextStyle(
                              color: Color.fromRGBO(181, 196, 216, 1),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => resendOtp,
                          ),
                        ],
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
