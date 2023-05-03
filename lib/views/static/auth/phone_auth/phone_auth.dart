import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/auth/phone_auth_vctl.dart';
import 'package:wan_mobile/views/static/auth/phone_auth/bottom_sheet_phone_auth.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';

class PhoneAuth extends StatelessWidget {
  const PhoneAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(12),
        child: Text(
          "Wwan 2023 - V0.0.1",
          style: TextStyle(fontSize: 11),
          textAlign: TextAlign.center,
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
                    "assets/images/logo_bedoo.png",
                    width: 94,
                    height: 43,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Login or Create an account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Pay using UPI, Wallet, Bank Account and Cards",
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
                                        )
                                      : Text(
                                          ctl.selectedPays?.libelle ?? "--",
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
                  // CheckboxListTile(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(5),
                  //   ),
                  //   controlAffinity: ListTileControlAffinity.leading,
                  //   checkboxShape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(2),
                  //   ),
                  //   value: true,
                  //   dense: true,
                  //   onChanged: (value) {},
                  //   title: const Text(
                  //     "Get updates on Whatsapp. I authorize Paytm "
                  //     "to access my credit reports from credit bureaus",
                  //     style: TextStyle(
                  //       fontSize: 10,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 70,
                    padding: const EdgeInsets.all(8.0),
                    child: CButton(
                      color: const Color.fromRGBO(13, 51, 159, 1),
                      onPressed: () => ctl.submit(),
                      child: const Text(
                        "Send me an OTP",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 70,
                    padding: const EdgeInsets.all(8.0),
                    child: CButton(
                      color: const Color.fromRGBO(237, 242, 249, 1),
                      onPressed: () => Get.to(() => const HomePage()),
                      child: const Text(
                        "Send me an OTP",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(181, 196, 216, 1),
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
