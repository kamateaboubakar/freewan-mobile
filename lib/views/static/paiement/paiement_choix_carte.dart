import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/controllers/paiement/paiement_choix_carte_vctl.dart';
import 'package:wan_mobile/views/static/paiement/paiement_pay_recap.dart';

class PaiementChoixCart extends StatelessWidget {
  final String motifPaiement;
  final String route;
  final int montant, frais;
  final String service;
  final int? userDestinationId;
  const PaiementChoixCart({
    required this.route,
    required this.frais,
    required this.motifPaiement,
    required this.montant,
    required this.service,
    this.userDestinationId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaiementChoixCarteVctl>(
        init: PaiementChoixCarteVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title: const Text("Choix de la carte"),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                      children: ctl.cards
                          .map(
                            (e) => Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                tileColor:
                                    const Color.fromRGBO(237, 242, 249, 1),
                                title: const Text(
                                  "Utiliser cette carte",
                                  style: TextStyle(
                                    color: Color.fromRGBO(72, 76, 79, 1),
                                    fontSize: 15,
                                  ),
                                ),
                                subtitle: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/images/master_card.png",
                                      width: 32,
                                      height: 29,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      e.numeroCarte.value,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                  color: Color.fromRGBO(7, 21, 60, 1),
                                ),
                                onTap: () => Get.to(
                                  () => PaiementRecap(
                                    motifPaiement: motifPaiement,
                                    route: route,
                                    moyenPaiement: e,
                                    frais: frais,
                                    montant: montant,
                                    service: service,
                                    userDestinationId: userDestinationId,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList()),
                  // AddAccountButton(
                  //   title: "Ajouter un autre carte bancaire",
                  //   onTap: () =>
                  //       Get.to(() => const EditionCardBank())?.then((value) {
                  //     if (value != null) {
                  //       ctl.cards.add(value);
                  //       ctl.update();
                  //     }
                  //   }),
                  // )
                ],
              ),
            ),
          );
        });
  }
}
