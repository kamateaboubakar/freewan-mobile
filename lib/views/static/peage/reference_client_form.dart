import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:tools_flutter_project/widgets/c_textform_field.dart';

class ReferenceClientForm extends StatelessWidget {
  const ReferenceClientForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Référence client"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const ListTile(
            title: Text(
                "Veuillez entre les références ci-dessous pour continuer."),
          ),
          const Gap(20),
          const CTextFormField(
            labelText: "Référence de la carte",
          ),
          const CTextFormField(
            labelText: "Numéro de téléphone",
          ),
          const Gap(20),
          CButton(
            height: 50,
            onPressed: () {},
            child: const Text("Valider"),
          )
        ],
      ),
    );
  }
}
