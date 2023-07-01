import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/loyer/abstracts/habitat.dart';
import 'package:wan_mobile/models/loyer/appartement.dart';
import 'package:wan_mobile/models/loyer/maison.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_dropdown_field.dart';
import 'package:wan_mobile/views/controllers/loyer/locataire/paiement_loyer_page_vctl.dart';

class PaiementLoyerPage extends StatelessWidget {
  final Habitat habitat;
  const PaiementLoyerPage(this.habitat, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paiement Loyer"),
      ),
      body: GetBuilder<PaiementLoyerPageVctl>(
          init: PaiementLoyerPageVctl(habitat),
          builder: (ctl) {
            return Form(
              key: ctl.formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(33),
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: .7,
                        color: const Color.fromRGBO(181, 196, 216, 1),
                      ),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor: AssetColors.blueButton,
                            child: Image.asset(
                                "assets/images/icons/icons8-paiement-64.png"),
                          ),
                          title: (habitat is Maison)
                              ? Text((habitat as Maison).libelle.value)
                              : Text(
                                  "Appartement ${(habitat as Appartement).numeroAppartement.value}"),
                          subtitle: Text(ctl.habitat.code.value),
                        ),
                        const Divider(height: 0),
                        (habitat is Appartement)
                            ? ListTile(
                                leading: Image.asset(
                                  "assets/images/icons/maison_icon.png",
                                  width: 18,
                                  height: 18,
                                ),
                                title: Text((habitat as Appartement)
                                    .typeAppartement!
                                    .libelle
                                    .value),
                              )
                            : const SizedBox.shrink(),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Image.asset(
                            "assets/images/icons/icons8-estimation-96.png",
                            width: 30,
                            height: 30,
                          ),
                          title: Text(habitat.loyer.toAmount()),
                          subtitle: const Text("Montant du loyer"),
                        ),
                        const Divider(height: 0),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Image.asset(
                            "assets/images/icons/icons8-warehouse-96.png",
                            width: 30,
                            height: 30,
                          ),
                          title: Text((ctl.habitat is Appartement)
                              ? "Appartement"
                              : "Maison"),
                          subtitle: const Text("Type de maison"),
                        ),
                        const Divider(),
                        const Gap(10),
                        Row(
                          children: [
                            // Expanded(
                            //   child: CTextFormField(
                            //     controller: ctl.moisCtl,
                            //     labelText: "Mois",
                            //     require: true,
                            //     hintText: "Ex: 01",
                            //     maxLength: 4,
                            //     keyboardType:
                            //         const TextInputType.numberWithOptions(),
                            //   ),
                            // ),
                            Expanded(
                              child: CDropdownField(
                                selectedItem: ctl.mois,
                                labelText: "Mois",
                                require: true,
                                items: List.generate(12, (i) => i + 1),
                                onChanged: (value) {
                                  ctl.mois = value;
                                  ctl.update();
                                },
                              ),
                            ),
                            const Gap(20),
                            Expanded(
                              child: CDropdownField(
                                selectedItem: ctl.annee,
                                items: List.generate(100, (i) => 2023 + i),
                                labelText: "Année",
                                require: true,
                                onChanged: (value) {
                                  ctl.annee = value;
                                  ctl.update();
                                },
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(height: 10),
                        // CButton(
                        //   height: 50,
                        //   minWidth: double.infinity,
                        //   onPressed: () => Get.to(() => const PaiementRecap()),
                        //   color: const Color.fromRGBO(71, 36, 251, 0.1),
                        //   child: const Text(
                        //     "Paiement dû le 5 Mai 2023",
                        //     style: TextStyle(
                        //       color: Color.fromRGBO(71, 36, 251, 1),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(height: 10),
                        CButton(
                          height: 50,
                          minWidth: double.infinity,
                          onPressed: () => ctl.submit(),
                          child: const Text(
                            "Payer",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ]),
              ),
            );
          }),
    );
  }
}
