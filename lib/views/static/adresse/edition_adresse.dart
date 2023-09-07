import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/services/location_service.dart';
import 'package:wan_mobile/models/adresse.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
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
                    leading: const Icon(Icons.pin_drop_rounded),
                    title: const Text("Prendre ma position actuelle"),
                    subtitle: Text(ctl.location.title),
                    onTap: ctl.getLocation,
                  ),
                  const Gap(20),
                  CButton(
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
