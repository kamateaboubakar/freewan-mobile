import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/models/pays.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/models/auth/otp_session.dart';
import 'package:wan_mobile/views/controllers/auth/otp_auth_page_vctl.dart';

class OPTAuthPage extends StatelessWidget {
  final String phone;
  final Pays? selectedPays;
  final OtpSession otp;

  const OPTAuthPage({
    required this.otp,
    required this.phone,
    this.selectedPays,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirmation OTP")),
      body: GetBuilder<OtpAuthPageVctl>(
        init: OtpAuthPageVctl(
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
                const Text(
                  "Entrez le code OTP reçu",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(7, 21, 60, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Nous vous avons envoyé le code par SMS. Veuillez saisir "
                  "le code avant la fin du temps-ci dessous.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(38, 82, 140, 1),
                  ),
                ),
                const Gap(20),
                SizedBox(
                  height: 80,
                  child: Center(
                    child: TimerCountdown(
                      secondsDescription: "Secondes",
                      format: CountDownTimerFormat.minutesSeconds,
                      timeTextStyle: const TextStyle(
                        fontSize: 30,
                        color: AssetColors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      endTime: ctl.endDate,
                      onEnd: () async {
                        await Tools.messageBox(
                          message: "Le code a expiré."
                              " Veuillez en renvoyer un nouveau.",
                        );
                        ctl.codeCtl.clear();
                        ctl.timerExpired = true;
                        ctl.update();
                      },
                    ),
                  ),

                  // Center(
                  //   child:
                  //   // TimerCountdown(
                  //   //   endTime: ctl.endDate,
                  //   //   onEnd: () {
                  //   //     ctl.codeCtl.clear();
                  //   //     ctl.timerExpired = true;
                  //   //     ctl.update();
                  //   //   },
                  //   //   // endWidget: const Text(
                  //   //   //   "Le code a expiré.",
                  //   //   //   style: TextStyle(
                  //   //   //     fontWeight: FontWeight.bold,
                  //   //   //     fontSize: 17,
                  //   //   //     color: Colors.red,
                  //   //   //   ),
                  //   //   // ),
                  //   //   // textStyle: const TextStyle(
                  //   //   //   fontSize: 45,
                  //   //   //   color: AssetColors.blue,
                  //   //   //   fontWeight: FontWeight.bold,
                  //   //   // ),
                  //   // ),
                  // ),
                ),
                // Center(
                //   child: TimerCountdown(
                //     secondsDescription: "Secondes",
                //     format: CountDownTimerFormat.minutesSeconds,
                //     timeTextStyle: const TextStyle(
                //       fontSize: 30,
                //       color: AssetColors.blue,
                //       fontWeight: FontWeight.bold,
                //     ),
                //     endTime: DateTime.now().add(const Duration(minutes: 2)),
                //     onEnd: () async {
                //       await Tools.messageBox(
                //         message: "Le code a expiré."
                //             " Veuillez en renvoyer un nouveau.",
                //       );
                //       ctl.codeCtl.clear();
                //       ctl.timerExpired = true;
                //       ctl.update();
                //     },
                //   ),
                // ),
                const Gap(20),
                PinCodeTextField(
                  keyboardType: TextInputType.number,
                  controller: ctl.codeCtl,
                  animationType: AnimationType.scale,
                  cursorColor: AssetColors.blueButton,
                  appContext: context,
                  length: 4,
                  enabled: !ctl.timerExpired,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldWidth: 70,
                    fieldHeight: 85,
                    borderWidth: 1,
                    inactiveColor: const Color.fromRGBO(38, 82, 140, 0.34),
                    activeColor: const Color.fromRGBO(38, 82, 140, 0.34),
                    selectedColor: AssetColors.blue,
                    activeFillColor: Colors.white,
                  ),
                ),
                const Gap(10),
                CButton(
                  height: 50,
                  onPressed: (ctl.timerExpired) ? null : ctl.submitOtp,
                  color: AssetColors.blue,
                  minWidth: double.infinity,
                  child: const Text("Valider le code"),
                ),
                // const OTPTextField(
                //   // enabled: !ctl.timerExpired,
                //   // numberOfFields: 4,
                //   fieldWidth: 60,
                //   // borderWidth: 1,
                //   // focusedBorderColor: Const.primaryColor,
                //   // enabledBorderColor: const Color.fromRGBO(38, 82, 140, 0.34),
                //   // filled: true,
                //   // autoFocus: true,
                //   // fillColor: Colors.white,
                //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   // borderColor: Const.primaryColor,
                //   // showFieldAsBox: true,
                //   keyboardType: TextInputType.number,
                //   // onSubmit: ctl.submitOtp,
                //   // textStyle: const TextStyle(
                //   //   fontSize: 30,
                //   //   color: AssetColors.blue,
                //   //   fontWeight: FontWeight.bold,
                //   // ),
                // ),
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
                          fontSize: 17,
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
