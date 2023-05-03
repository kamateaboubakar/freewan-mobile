import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/static/loyer/locataire/paiement_loyer_page.dart';

class FormulaireCodeMaisonLoyer extends StatelessWidget {
  const FormulaireCodeMaisonLoyer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paiement Loyer"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(33),
        child: Column(
          children: [
            const Text(
              "Entrez le code de la maison pour laquelle vous aimeriez"
              " effectuer un paiement de loyer",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 17),
            CTextFormField(
              labelText: "Code de maison",
              require: true,
              onChanged: (va) {},
            ),
            const SizedBox(height: 17),
            CButton(
              color: const Color.fromRGBO(13, 51, 159, 1),
              height: 50,
              minWidth: double.infinity,
              onPressed: () => Get.to(() => const PaiementLoyerPage()),
              child: const Text("Valider"),
            )
          ],
        ),
      ),
    );
  }
}
