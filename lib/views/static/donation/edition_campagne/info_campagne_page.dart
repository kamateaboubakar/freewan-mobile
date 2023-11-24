import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:wan_mobile/models/don/categorie_campagne.dart';
import 'package:wan_mobile/models/don/organization.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/widgets/c_outlined_button.dart';
import 'package:wan_mobile/views/controllers/donation/edition_donation_page_vctl.dart';

class InfosCampagne extends StatelessWidget {
  final EditionDonationVctl ctl;
  const InfosCampagne(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CButton(
          height: 50,
          onPressed: ctl.validateForm1,
          child: const Text("Etape suivante"),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: ctl.formKey1,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ListTile(
                    title: Text(
                      "Informations de la campagne",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AssetColors.blue,
                      ),
                    ),
                    trailing: Text("1/2"),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Ces informations permettront aux donateurs de"
                    " mieux comprendre votre campagne",
                    style: TextStyle(
                      fontSize: 13,
                      color: AssetColors.blue,
                    ),
                  ),
                  const SizedBox(height: 40),
                  CTextFormField(
                    controller: ctl.titreCtl,
                    labelText: "Titre de la campagne",
                    require: true,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  CDropdownField<CategorieCampagne>(
                    labelText: "Catégorie",
                    require: true,
                    asyncItems: (e) => ctl.fetchCategories(),
                    selectedItem: ctl.categorieDonation,
                    itemAsString: (e) => e.label.value,
                    popupProps: const PopupProps.menu(
                      isFilterOnline: true,
                      showSearchBox: true,
                    ),
                    onChanged: (value) {
                      ctl.categorieDonation = value;
                      ctl.update();
                    },
                  ),
                  CDropdownField<Organization>(
                    labelText: "Organisation",
                    require: true,
                    asyncItems: (e) => ctl.fetchOrganisations(),
                    selectedItem: ctl.organization,
                    itemAsString: (e) => e.name.value,
                    popupProps: const PopupProps.menu(
                      isFilterOnline: true,
                      showSearchBox: true,
                    ),
                    onChanged: (value) {
                      ctl.organization = value;
                      ctl.update();
                    },
                  ),
                  CTextFormField(
                    controller: ctl.descriptionCtl,
                    labelText: "Description",
                    require: true,
                    maxLines: 6,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const Gap(20),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
