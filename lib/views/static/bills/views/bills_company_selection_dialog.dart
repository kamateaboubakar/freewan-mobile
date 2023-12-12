import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/views/static/loyer/locataire/formulaire_code_maison_loyer.dart';

import '../bills_views.dart';

class BillsCompanySelectionDialog extends StatelessWidget {
  const BillsCompanySelectionDialog({super.key});

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
              "Choisissez le service",
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(
            thickness: 1,
            color: Color.fromRGBO(181, 196, 216, 0.65),
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/cie.png",
              width: 48,
              height: 48,
            ),
            title: const Text(
              "Facture d’électricité",
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(7, 21, 60, 1),
              ),
            ),
            subtitle: const Text(
              "Payez vos factures d’ électricité et celles de vos proches en toute simplicité",
              style: TextStyle(
                fontSize: 12,
                color: Color.fromRGBO(38, 82, 140, 1),
              ),
            ),
            onTap: () => Get.to(() => const BillsReferenceSelectionPage()),
          ),
          const Divider(
            thickness: 1,
            color: Color.fromRGBO(181, 196, 216, 0.65),
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/sodeci.png",
              width: 48,
              height: 48,
            ),
            title: const Text(
              "Facture d’eau",
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(7, 21, 60, 1),
              ),
            ),
            subtitle: const Text(
              "Payez vos factures d’eau et celles de vos proches en toute simplicité",
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
