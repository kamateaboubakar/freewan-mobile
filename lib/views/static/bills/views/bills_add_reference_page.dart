import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_master/widgets/c_button.dart';
import 'package:module_master/widgets/c_textform_field.dart';

class BillsAddReferencePage extends StatelessWidget {
  final TextEditingController _referenceCtrl = TextEditingController();

  BillsAddReferencePage({super.key});

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
                    const SizedBox(height: 10),
                    const Text(
                      'Entrez les neufs premiers chiffre du numéro d’exploitation sur la facture',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
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
