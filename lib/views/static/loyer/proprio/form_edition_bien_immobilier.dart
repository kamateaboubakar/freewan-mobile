import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:tools_flutter_project/tools/types/int.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/controllers/loyer/form_edition_bien_immobilier_vctl.dart';

class FormEditionBienImmobilier extends StatelessWidget {
  final bool isMaison;
  const FormEditionBienImmobilier({this.isMaison = false, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormEditionBienImmobilierVctl>(
        init: FormEditionBienImmobilierVctl(isMaison),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Ajouter un bien immobilier"),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20),
              child: CButton(
                height: 50,
                onPressed: () => ctl.submit(),
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
                              ctl.isMaison = false;
                              ctl.update();
                            },
                            shape: CircleBorder(
                              side: (!ctl.isMaison)
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
                            style: (!ctl.isMaison)
                                ? const TextStyle(
                                    color: AssetColors.blueButton,
                                  )
                                : null,
                          )
                        ],
                      ),
                      Form(
                        key: ctl.formKey,
                        child: Column(
                          children: [
                            MaterialButton(
                              onPressed: () {
                                ctl.isMaison = true;
                                ctl.update();
                              },
                              shape: CircleBorder(
                                side: (ctl.isMaison)
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
                              style: (ctl.isMaison)
                                  ? const TextStyle(
                                      color: AssetColors.blueButton)
                                  : null,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      CTextFormField(
                        controller: ctl.nomLocalCtl,
                        labelText: "Nom",
                        require: true,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      CTextFormField(
                        controller: ctl.lieuCtl,
                        labelText: "Lieu",
                        require: true,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      Visibility(
                        visible: ctl.isMaison,
                        child: CTextFormField(
                          controller: ctl.nbPieceCtl,
                          labelText: "Nombre de pièces",
                          require: true,
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      Visibility(
                        visible: ctl.isMaison,
                        child: CTextFormField(
                          controller: ctl.loyerCtl,
                          labelText: "Loyer",
                          require: true,
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      Visibility(
                        visible: ctl.isMaison,
                        child: CTextFormField(
                          controller: ctl.jourPaiement,
                          labelText: "Jour de paiement",
                          hintText: "Jour du mois limit de paiement",
                          require: true,
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              if (value.isNum) {
                                if (value.toInt().value >= 1 &&
                                    value.toInt().value <= 31) {
                                  return null;
                                } else {
                                  return "Veuillez saisir un nombre entre 1 et 31";
                                }
                              } else {
                                return "Veuillez saisir un nombre entre 1 et 31";
                              }
                            } else {
                              return "Ce champs est obligatoire";
                            }
                          },
                        ),
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
