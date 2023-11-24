import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:tools_flutter_project/tools/types/int.dart';
import 'package:wan_mobile/models/paiement/mode_paiement.dart';

import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/controllers/paiement/paiement_pay_recap_vctl.dart';

class PaiementRecap extends StatelessWidget {
  final String motifPaiement;
  final String route;
  final MoyenPaiements moyenPaiement;
  final int montant, frais;
  final String service;
  final int? userDestinationId;
  const PaiementRecap(
      {required this.route,
      required this.motifPaiement,
      required this.frais,
      required this.moyenPaiement,
      required this.montant,
      required this.service,
      this.userDestinationId,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaiementRecapVctl>(
        init: PaiementRecapVctl(
            frais: frais,
            montant: montant,
            motifPaiement: motifPaiement,
            moyenPaiement: moyenPaiement,
            userDestinationId: userDestinationId,
            route: route,
            service: service),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title: const Text("Confirmation"),
            ),
            bottomNavigationBar: Container(
              margin: const EdgeInsets.only(bottom: 34, left: 20, right: 20),
              child: CButton(
                height: 48,
                onPressed: ctl.submit,
                child: const Text(
                  "Confirmer",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: ListTile(
                        title: Text(
                          motifPaiement,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const Text(
                            "Via",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AssetColors.blueButton,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(20),
                    Text(
                      moyenPaiement.label,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Stack(alignment: Alignment.center, children: [
                      Image.asset("assets/images/Rectangle_39.png"),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/images/chariot.png",
                                        width: 17,
                                        height: 17,
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "Montant",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  montant.toAmount(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Divider(color: Color.fromRGBO(71, 36, 251, 1)),
                          const SizedBox(height: 13),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/images/Vector_frais.png",
                                        width: 17,
                                        height: 17,
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "Frais",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  frais.toAmount(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 13),
                          const Divider(color: Color.fromRGBO(45, 128, 236, 1)),
                          const SizedBox(height: 27),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/images/portefeuil.png",
                                        width: 17,
                                        height: 17,
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "Total à payer",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  (montant + frais).toAmount(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ]),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
