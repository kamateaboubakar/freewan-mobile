import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/don/organization.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_outlined_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/donation/organisation/edition_organisation_page_vctl.dart';

class EditionOrganisationPage extends StatelessWidget {
  final Organization? organisation;
  const EditionOrganisationPage({this.organisation, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edition d'une organisation"),
      ),
      body: GetBuilder<EditionOrganisationPageVctl>(
          init: EditionOrganisationPageVctl(editedItem: organisation),
          builder: (ctl) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: ctl.formKey,
                child: Column(
                  children: [
                    CTextFormField(
                      controller: ctl.nomCtl,
                      require: true,
                      labelText: "Nom",
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    CTextFormField(
                      controller: ctl.emailCtl,
                      require: true,
                      labelText: "Email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    CTextFormField(
                      controller: ctl.telCtl,
                      require: true,
                      labelText: "Téléphone",
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                    ),
                    CTextFormField(
                      controller: ctl.adresseCtl,
                      require: true,
                      labelText: "Adresse",
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    CTextFormField(
                      controller: ctl.descriptionCtl,
                      require: true,
                      labelText: "Description",
                      maxLines: 5,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    COutlinedButton(
                      height: 50,
                      textColor: AssetColors.blue,
                      minWidth: double.infinity,
                      icon: const Icon(Icons.add),
                      onPressed: () => ctl.pickImage(),
                      child: Text((ctl.image == null)
                          ? "Ajouter une image*"
                          : "Modifier l'image*"),
                    ),
                    const Gap(20),
                    (ctl.image == null)
                        ? const SizedBox.shrink()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: (ctl.image!.contains("http"))
                                  ? Image.network(
                                      ctl.image!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(ctl.image!),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                    const Gap(20),
                    CButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: () => ctl.submit(),
                      child: const Text("Enregistrer"),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
