import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../tools/widgets/c_button.dart';
import '../../../../tools/widgets/c_textform_field.dart';

class BillsAddReferencePage extends StatelessWidget {
  final TextEditingController _referenceCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Ajout Compteur"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/cie.png',
                      height: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Entrez les neufs premiers chiffre du numéro d’exploitation sur la facture',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    CTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      require: true,
                      controller: _referenceCtrl,
                      labelText: "Numéro d'exploitation",
                    ),
                  ],
                ),
              ),
            ),
            CButton(
              height: 50,
              onPressed: () => Get.back(),
              child: const Text("Confirmer"),
            ),
          ],
        ),
      ),
    );
  }
}
