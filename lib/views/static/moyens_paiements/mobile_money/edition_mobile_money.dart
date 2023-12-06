import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';

class EditionMobileMoney extends StatelessWidget {
  const EditionMobileMoney({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edition mobile money"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CTextFormField(
            require: true,
            labelText: "Numéro mobile money",
            keyboardType: TextInputType.number,
          ),
          const Gap(20),
          CButton(
            color: AssetColors.blue,
            height: 50,
            onPressed: () {},
            child: const Text("Valider"),
          ),
        ],
      ),
    );
  }
}
