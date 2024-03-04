import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/models/pays.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/models/auth/otp_session.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/views/controllers/auth/otp_auth_vctl.dart';

class OPTAuth extends StatelessWidget {
  final String phone;
  final Pays? selectedPays;
  final OtpSession otp;

  const OPTAuth({
    required this.otp,
    required this.phone,
    this.selectedPays,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<OtpAuthVctl>(
        init: OtpAuthVctl(
          otp: otp,
          phone: phone,
          selectedPays: selectedPays!,
        ),
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
                  "Nous vous avons envoyé le code par SMS",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(38, 82, 140, 1),
                  ),
                ),
                const Gap(20),
                Center(
                  child: CountdownTimer(
                    endTime:
                        ctl.otp.endDate.toDateTime()!.millisecondsSinceEpoch +
                            1000,
                    widgetBuilder: (context, time) {
                      return Text(
                        "${time?.min ?? "0"}:${time?.sec ?? "00"}",
                        style: const TextStyle(
                          color: AssetColors.blueButton,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      );
                    },
                  ),
                ),
                const Gap(20),
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
                  onSubmit: ctl.submitOtp,
                ),
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CButton(
                      color: Colors.transparent,
                      textColor: AssetColors.blue,
                      onPressed: ctl.resendOtp,
                      child: const Text(
                        "Renvoyer le code",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
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
