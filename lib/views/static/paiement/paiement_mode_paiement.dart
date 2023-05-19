import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/moyen_paiement.dart';
import 'package:wan_mobile/views/static/paiement/paiement_choix_carte.dart';
import 'package:wan_mobile/views/static/paiement/paiement_choix_numero.dart';

class PaiementModePaiement extends StatelessWidget {
  const PaiementModePaiement({super.key});

  @override
  Widget build(BuildContext context) {
    List<MoyenPaiement> moyensPaiements = [
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
        label: "Carte Visa",
        icon: "assets/images/visa.png",
        isMobileMoney: false,
      ),
      MoyenPaiement(
        label: "Mastercard",
        icon: "assets/images/master_card.png",
        isMobileMoney: false,
      )
    ];

    List<Color> colors = [
      Color(0xffff7900).withOpacity(0.09),
      Color(0xfffcc916).withOpacity(0.09),
      Color(0xffff7900).withOpacity(0.09),
      Color(0xff4AD2FA).withOpacity(0.09),
      Color(0xff2566AF).withOpacity(0.09),
      Color(0xffEA001B).withOpacity(0.15),
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
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                  Get.to(() => const PaiementChoixNumero());
                } else {
                  Get.to(() => const PaiementChoixCart());
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffE5E5E5),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: colors[index],
                        ),
                        child: Center(
                          child: Image.asset(
                            item.icon,
                            width: 35,
                            height: 35,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12
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
