import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:module_master/module_master.dart';

import 'package:wan_mobile/views/controllers/auth/phone_auth_vctl.dart';
import 'package:wan_mobile/views/static/auth/phone_auth/bottom_sheet_phone_auth.dart';

class PhoneAuth extends StatelessWidget {
  const PhoneAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
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
              "Freewan 2023 - V${Const.appVersion}",
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
                  const Text(
                    "Identifiez-vous ou créez un compte",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Payez en utilisant UPI, portefeuille,"
                    " compte bancaire et cartes",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            Tools.openBottomSheet(BottomSheetPhoneAuth(ctl)),
                        child: Container(
                          height: 54,
                          width: 90,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
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
                                          ctl.selectedPays?.callingCode ?? "--",
                                          textAlign: TextAlign.center,
                                        ),
                                ),
                              ),
                              const Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: CTextFormField(
                          keyboardType: TextInputType.phone,
                          controller: ctl.telCtl,
                          hintText: "Numéro de téléphone",
                          onChanged: (value) {},
                          maxLength: ctl.selectedPays?.phoneNumberLength,
                        ),
                      )
                    ],
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
                    title: const Text.rich(
                      TextSpan(
                        text: "Cochez pour signifier que vous avez lu nos ",
                        children: [
                          TextSpan(
                            text: "termes et conditions",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 159, 249, 1),
                            ),
                          ),
                          TextSpan(text: " et notre "),
                          TextSpan(
                            text: "politique de confidentialité",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 159, 249, 1),
                            ),
                          ),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 65,
                    padding: const EdgeInsets.all(8.0),
                    child: CButton(
                      onPressed: () => ctl.submit(),
                      child: const Text(
                        "Envoyez-moi un OTP",
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
          }),
    );
  }
}
