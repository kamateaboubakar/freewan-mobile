import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/loyer/form_edition_bien_immobilier_vctl.dart';

import '../../../../tools/utils/asset_colors.dart';

class FormEditionBienImmobilier extends StatelessWidget {
  final int selectedItem;
  const FormEditionBienImmobilier({this.selectedItem = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormEditionBienImmobilierVctl>(
        init: FormEditionBienImmobilierVctl(selectedItem: selectedItem),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Ajouter un bien immobilier"),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20),
              child: CButton(
                height: 50,
                onPressed: () {},
                child: const Text("Ajouter ce bien"),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          MaterialButton(
                            onPressed: () {
                              ctl.selectedItem = 0;
                              ctl.update();
                            },
                            shape: CircleBorder(
                              side: (ctl.selectedItem == 0)
                                  ? const BorderSide(
                                      color: AssetColors.blueButton,
                                      width: 3,
                                    )
                                  : BorderSide.none,
                            ),
                            elevation: 0,
                            highlightElevation: 0,
                            color: const Color.fromRGBO(238, 238, 238, 1),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Image.asset(
                                "assets/images/icons/immeuble.png",
                                width: 80,
                                height: 80,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Bloc d’apparts",
                            style: (ctl.selectedItem == 0)
                                ? const TextStyle(
                                    color: AssetColors.blueButton,
                                  )
                                : null,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            onPressed: () {
                              ctl.selectedItem = 1;
                              ctl.update();
                            },
                            shape: CircleBorder(
                              side: (ctl.selectedItem == 1)
                                  ? const BorderSide(
                                      color: AssetColors.blueButton,
                                      width: 3,
                                    )
                                  : BorderSide.none,
                            ),
                            elevation: 0,
                            highlightElevation: 0,
                            color: const Color.fromRGBO(238, 238, 238, 1),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Image.asset(
                                "assets/images/icons/maison.png",
                                width: 80,
                                height: 80,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Maison",
                            style: (ctl.selectedItem == 1)
                                ? const TextStyle(
                                    color: AssetColors.blueButton,
                                  )
                                : null,
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  (ctl.selectedItem == 0)
                      ? Column(
                          children: [
                            CTextFormField(
                              controller: ctl.nomLocalCtl,
                              labelText: "Nom",
                              require: true,
                            ),
                            CTextFormField(
                              controller: ctl.lieuCtl,
                              labelText: "Lieu",
                              require: true,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            CTextFormField(
                              controller: ctl.nomLocataireCtl,
                              labelText: "Nom du locataire",
                              require: true,
                            ),
                            CTextFormField(
                              controller: ctl.telLocataireCtl,
                              labelText: "Numéro du locataire",
                              require: true,
                            ),
                            CTextFormField(
                              controller: ctl.lieuCtl,
                              labelText: "Lieu",
                              require: true,
                            ),
                            CTextFormField(
                              controller: ctl.nbPieceCtl,
                              labelText: "Nombre de pièces",
                              require: true,
                            ),
                            CTextFormField(
                              controller: ctl.loyerCtl,
                              labelText: "Loyer",
                              require: true,
                            ),
                            CTextFormField(
                              controller: ctl.datePaiementCtl,
                              labelText: "Date de paiement",
                              require: true,
                              readOnly: true,
                              suffixIcon: const Icon(Icons.calendar_month),
                              onTap: () async {
                                var date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2023),
                                    lastDate: DateTime(3000));
                                ctl.datePaiementCtl.text = date.toFrenchDate;
                              },
                            ),
                          ],
                        )
                ],
              ),
            ),
          );
        });
  }
}
