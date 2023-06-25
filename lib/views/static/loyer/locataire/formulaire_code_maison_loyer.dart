import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/loyer/locataire/formulaire_code_maison_loyer_vctl.dart';

class FormulaireCodeMaisonLoyer extends StatelessWidget {
  const FormulaireCodeMaisonLoyer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paiement Loyer"),
      ),
      body: GetBuilder<FormulaireCodeMaisonLoyerVctl>(
          init: FormulaireCodeMaisonLoyerVctl(),
          builder: (ctl) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(33),
              child: Form(
                key: ctl.formKey,
                child: Column(
                  children: [
                    const Text(
                      "Entrez le code de la maison pour laquelle vous aimeriez"
                      " effectuer un paiement de loyer.",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 17),
                    CTextFormField(
                      controller: ctl.codeCtl,
                      labelText: "Code de maison",
                      maxLength: 5,
                      require: true,
                    ),
                    const SizedBox(height: 17),
                    CButton(
                      height: 50,
                      minWidth: double.infinity,
                      onPressed: () => ctl.submit(),
                      child: const Text("Valider"),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
