import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/moyen_paiement.dart';
import 'package:wan_mobile/views/static/paiement/paiement_choix_carte.dart';
import 'package:wan_mobile/views/static/paiement/paiement_choix_numero.dart';

class PaiementModePaiement extends StatelessWidget {
  final String route;
  final String motifPaiement;
  final int montant, frais;
  final String service;
  final int? userDestinationId;
  const PaiementModePaiement(
      {required this.route,
      required this.motifPaiement,
      required this.frais,
      required this.montant,
      required this.service,
      this.userDestinationId,
      super.key});

  @override
  Widget build(BuildContext context) {
    List<MoyenPaiement> moyensPaiements = [
      MoyenPaiement(
        label: "Mobile Money",
        icon: "assets/images/icons/mobile_money.png",
      ),
      MoyenPaiement(
        label: "Carte Bancaire/Prépayée",
        icon: "assets/images/icons/carte_bancaire.png",
        isMobileMoney: false,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Mode de Paiement"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: moyensPaiements.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.6,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            var item = moyensPaiements[index];
            return InkWell(
              onTap: () {
                if (item.isMobileMoney) {
                  Get.to(() => PaiementChoixNumero(
                        route: route,
                        motifPaiement: motifPaiement,
                        frais: frais,
                        montant: montant,
                        service: service,
                        userDestinationId: userDestinationId,
                      ));
                } else {
                  Get.to(() => PaiementChoixCart(
                        route: route,
                        motifPaiement: motifPaiement,
                        frais: frais,
                        montant: montant,
                        service: service,
                        userDestinationId: userDestinationId,
                      ));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffE5E5E5),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Center(
                          child: Image.asset(
                            item.icon,
                            width: 35,
                            height: 35,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    AutoSizeText(
                      item.label,
                      maxLines: 15,
                      minFontSize: 10,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
