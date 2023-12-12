import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools/types/double.dart';
import 'package:wan_mobile/models/loyer/abstracts/habitat.dart';
import 'package:wan_mobile/models/loyer/appartement.dart';
import 'package:wan_mobile/models/loyer/maison.dart';

import 'package:tools_flutter_project/tools_flutter_project.dart';
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
            return SingleChildScrollView(
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
                        leading: const CircleAvatar(
                          child: Icon(Icons.home),
                        ),
                        title: (habitat is Maison)
                            ? Text((habitat as Maison).libelle.value)
                            : Text(
                                "Appartement ${(habitat as Appartement).numeroAppartement.value}"),
                      ),
                      const Divider(),
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
                        leading: Image.asset(
                          "assets/images/icons/maison_icon.png",
                          width: 18,
                          height: 18,
                        ),
                        title: Text(habitat.loyer.toAmount()),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: CDropdownField(
                              labelText: "Mois",
                              require: true,
                              // items: Functions.months
                              //     .map((e) => e["full"])
                              //     .toList(),
                              onChanged: (value) {
                                // ctl.selectedMois = Functions.getMonthIndex(
                                //     value.value,
                                //     lite: false);

                                // ctl.update();
                              },
                            ),
                          ),
                          const Gap(10),
                          Expanded(
                            child: CTextFormField(
                              controller: ctl.anneeCtl,
                              require: true,
                              contentPadding: null,
                              labelText: "Année",
                              keyboardType: TextInputType.number,
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
            );
          }),
    );
  }
}
