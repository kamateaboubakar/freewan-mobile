import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/views/static/loyer/locataire/formulaire_code_maison_loyer.dart';
import 'package:wan_mobile/views/static/loyer/proprio/bien_immobilier_page.dart';

class LoyerBottomSheet extends StatelessWidget {
  const LoyerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      height: 249,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 17, bottom: 13),
            child: Text(
              "Choisissez votre profil",
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(
            thickness: 1,
            color: Color.fromRGBO(181, 196, 216, 0.65),
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/icons/proprio_logo.png",
              width: 48,
              height: 48,
            ),
            title: const Text(
              "Propriétaire / Manager",
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(7, 21, 60, 1),
              ),
            ),
            subtitle: const Text(
              "Vous possédez ou gérez 1 ou plusieurs biens immobilliers",
              style: TextStyle(
                fontSize: 12,
                color: Color.fromRGBO(38, 82, 140, 1),
              ),
            ),
            onTap: () => Get.to(() => const BienImmobilierPage()),
          ),
          const Divider(
            thickness: 1,
            color: Color.fromRGBO(181, 196, 216, 0.65),
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/icons/locataire_logo.png",
              width: 48,
              height: 48,
            ),
            title: const Text(
              "Locataire",
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(7, 21, 60, 1),
              ),
            ),
            subtitle: const Text(
              "Vous louer une maison, un appartement, des bureaux",
              style: TextStyle(
                fontSize: 12,
                color: Color.fromRGBO(38, 82, 140, 1),
              ),
            ),
            onTap: () => Get.to(() => const FormulaireCodeMaisonLoyer()),
          ),
        ],
      ),
    );
  }
}
