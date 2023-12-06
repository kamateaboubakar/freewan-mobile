import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/models/adresse.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/controllers/adresse/edition_adresse_vctl.dart';

class EditionAdresse extends StatelessWidget {
  final Adresse? adresse;
  const EditionAdresse({this.adresse, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edition d'adresse"),
      ),
      body: GetBuilder<EditionAdresseVctl>(
          init: EditionAdresseVctl(adresse: adresse),
          builder: (ctl) {
            return Form(
              key: ctl.formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  CTextFormField(
                    require: true,
                    controller: ctl.labelCtl,
                    labelText: "Nom de l'adresse",
                    hintText: "Exemple: Ma maison",
                  ),
                  const Gap(10),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.pin_drop_rounded),
                    ),
                    title: const Text("Prendre ma position actuelle"),
                    subtitle: Text(ctl.location.title),
                    onTap: ctl.getLocation,
                  ),
                  const Gap(20),
                  CButton(
                    color: AssetColors.blue,
                    onPressed: ctl.submit,
                    height: 50,
                    child: const Text("Valider"),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
