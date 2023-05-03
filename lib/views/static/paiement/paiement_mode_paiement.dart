import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/moyen_paiement.dart';
import 'package:wan_mobile/views/static/paiement/paiement_choix_carte.dart';
import 'package:wan_mobile/views/static/paiement/paiement_choix_numero.dart';

class PaiementModePaiement extends StatelessWidget {
  const PaiementModePaiement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Mode de Paiement"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(11),
        child: Column(
          children: [
            MoyenPaiement(
              label: "Orange Money",
              icon: "assets/images/Orange-Money-logo-2048x1375_1.png",
            ),
            MoyenPaiement(
              label: "MTN Money",
              icon: "assets/images/mtn_1.png",
            ),
            MoyenPaiement(
              label: "Moov Money",
              icon: "assets/images/moov2-PhotoRoom_1.png",
            ),
            MoyenPaiement(
              label: "Wave",
              icon: "assets/images/wave.png",
            ),
            MoyenPaiement(
              label: "Carte Visa et Mastercard ",
              icon: "assets/images/visa.png",
              isMobileMoney: false,
            ),
          ]
              .map(
                (e) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    tileColor: const Color.fromRGBO(237, 242, 249, 1),
                    leading: Image.asset(e.icon, width: 50),
                    title: Text(e.label),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Color.fromRGBO(7, 21, 60, 1),
                    ),
                    onTap: () {
                      if (e.isMobileMoney) {
                        Get.to(() => const PaiementChoixNumero());
                      } else {
                        Get.to(() => const PaiementChoixCart());
                      }
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
