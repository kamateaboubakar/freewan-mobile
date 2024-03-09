import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';

class PaiementLinkPage extends StatelessWidget {
  const PaiementLinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liens de paiement")),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const CTextFormField(
              require: true,
              labelText: "Numéro du destinanaire",
            ),
            const CTextFormField(
              require: true,
              labelText: "Montant",
            ),
            CheckboxListTile(
              title: const Text("Rendre le lien paiement permanent"),
              value: false,
              onChanged: (e) {},
            ),
            const Gap(20),
            CButton(
              height: 50,
              color: AssetColors.blue,
              child: const Text("Valider"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
