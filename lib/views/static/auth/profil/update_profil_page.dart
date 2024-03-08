import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';

class UpdateProfilPage extends StatelessWidget {
  const UpdateProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Modification du profil")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CTextFormField(
            labelText: "Nom",
          ),
          const CTextFormField(
            labelText: "Prénom",
          ),
          const CTextFormField(
            labelText: "Email",
          ),
          const Gap(20),
          CButton(
            color: AssetColors.blue,
            minWidth: double.infinity,
            height: 50,
            onPressed: () {},
            child: const Text("Valider"),
          ),
        ],
      ),
    );
  }
}
