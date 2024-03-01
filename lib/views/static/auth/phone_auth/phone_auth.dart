import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/controllers/auth/phone_auth_vctl.dart';
import 'package:wan_mobile/views/static/auth/phone_auth/bottom_sheet_phone_auth.dart';
import 'package:wan_mobile/views/static/cgu_page.dart';

class PhoneAuth extends StatelessWidget {
  const PhoneAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/pci_dsi.png",
              height: 40,
            ),
            const SizedBox(height: 10),
            const Text(
              "Freewan 2024 - V${Const.appVersion}",
              style: TextStyle(fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: GetBuilder<PhoneAuthVctl>(
        init: PhoneAuthVctl(),
        builder: (ctl) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  Const.inLineAppLogo,
                  width: 120,
                  height: 63,
                ),
                const SizedBox(height: 10),
                const AutoSizeText(
                  "Identifiez-vous ou créez un compte",
                  maxFontSize: 20,
                  minFontSize: 15,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 5),
                const AutoSizeText(
                  "Payez en utilisant Moov money, Orange money, wave,"
                  " compte bancaire et cartes, etc.",
                  maxFontSize: 15,
                  minFontSize: 12,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              Tools.openBottomSheet(BottomSheetPhoneAuth(ctl)),
                          child: Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: .5,
                                color: const Color.fromRGBO(181, 196, 216, 1),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: (ctl.selectedPays?.flag != null)
                                        ? Image.asset(
                                            ctl.selectedPays!.flag!,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(Icons.flag),
                                            width: 30,
                                          )
                                        : Text(
                                            ctl.selectedPays?.callingCode ??
                                                "--",
                                            textAlign: TextAlign.center,
                                          ),
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        flex: 2,
                        child: CTextFormField(
                          controller: ctl.phoneCtl,
                          contentPadding: null,
                          margin: EdgeInsets.zero,
                          keyboardType: TextInputType.number,
                          hintText: "Numéro de téléphone",
                          maxLength: ctl.selectedPays?.phoneNumberLength,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Checkbox(
                    value: ctl.acceptCgu,
                    onChanged: (value) {
                      ctl.acceptCgu = !ctl.acceptCgu;
                      ctl.update();
                    },
                    checkColor: const Color.fromRGBO(229, 229, 229, 1),
                  ),
                  title: AutoSizeText.rich(
                    TextSpan(
                      text: "Cochez pour signifier que vous "
                          "avez lu et accepté nos ",
                      children: [
                        TextSpan(
                          text: "termes et conditions",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => const CGUPage()),
                          style: const TextStyle(
                            color: Color.fromRGBO(0, 159, 249, 1),
                          ),
                        ),
                        const TextSpan(text: " et notre "),
                        TextSpan(
                          text: "politique de confidentialité",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => const CGUPage()),
                          style: const TextStyle(
                            color: Color.fromRGBO(0, 159, 249, 1),
                          ),
                        ),
                      ],
                    ),
                    maxFontSize: 15,
                    minFontSize: 10,
                    maxLines: 3,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 65,
                  padding: const EdgeInsets.all(8.0),
                  child: CButton(
                    color: AssetColors.blue,
                    onPressed: () => ctl.submit(),
                    child: const AutoSizeText(
                      "Envoyez-moi un OTP",
                      maxFontSize: 18,
                      minFontSize: 15,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
