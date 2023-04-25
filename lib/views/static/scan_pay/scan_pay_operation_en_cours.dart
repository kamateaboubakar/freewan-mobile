import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/static/scan_pay/scan_pay_operation_success.dart';

class ScanPayOperationEnCours extends StatelessWidget {
  const ScanPayOperationEnCours({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: const Text("Paiement en cours"),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 120,
        child: Column(
          children: [
            CButton(
              height: 48,
              minWidth: double.infinity,
              color: const Color.fromRGBO(13, 51, 159, 1),
              onPressed: () => Get.to(() => const ScanPayOperationSucess()),
              child: const Text(
                "Effectuer Paiement",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 15),
            CButton(
              height: 48,
              minWidth: double.infinity,
              color: Colors.transparent,
              onPressed: () => Get.back(),
              child: const Text(
                "Annuler paiement",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(13, 51, 159, 1),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: Get.width,
          child: Column(
            children: [
              const SizedBox(height: 19),
              Image.asset(
                "assets/images/Orange-Money-logo-2048x1375_1.png",
                height: 45,
              ),
              const SizedBox(height: 19),
              const Text(
                "Obtenez un code de confirmation en cliquant sur :",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 15),
              const Chip(
                backgroundColor: Color.fromRGBO(191, 208, 255, 1),
                padding: EdgeInsets.all(14),
                avatar: Icon(Icons.phone, size: 18),
                label: Text(
                  "#144*82#",
                  style: TextStyle(
                    color: Color.fromRGBO(13, 51, 159, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Entrer le code reçu dans le champ ci dessous puis "
                "tapez sur ‘Effectuer Paiement’",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 20),
              OtpTextField(
                numberOfFields: 4,
                fieldWidth: 60,
                borderWidth: 1,
                focusedBorderColor: Const.primaryColor,
                enabledBorderColor: const Color.fromRGBO(38, 82, 140, 0.34),
                filled: true,
                fillColor: Colors.white,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                borderColor: Const.primaryColor,
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                onSubmit: (code) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
