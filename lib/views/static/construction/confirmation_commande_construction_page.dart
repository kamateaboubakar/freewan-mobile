import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';

class ConfirmationCommandeConstructionPage extends StatelessWidget {
  const ConfirmationCommandeConstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirmation"),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Sous-Total:",
                style: TextStyle(
                  fontSize: 16,
                  color: AssetColors.grey4,
                ),
              ),
              trailing: Text("15 000 F"),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Frais de livraison:",
                style: TextStyle(
                  fontSize: 16,
                  color: AssetColors.grey4,
                ),
              ),
              trailing: Text("5 000 F"),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Taxe:",
                style: TextStyle(
                  fontSize: 16,
                  color: AssetColors.grey4,
                ),
              ),
              trailing: Text("0 F"),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Total:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                "20 000 F",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Gap(30),
            CButton(
              minWidth: double.infinity,
              onPressed: () {},
              height: 50,
              child: const Text("Continuer"),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Lieu de livraison",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
                side: const BorderSide(color: AssetColors.grey300),
              ),
              title: const Text(
                "Utiliser cette localisation",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 15,
                    color: AssetColors.blueButton,
                  ),
                  Gap(5),
                  Text("Rue M66"),
                ],
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 12,
              ),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Paiement",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              tileColor: AssetColors.grey300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              title: const Text(
                "Utiliser ce moyen de paiement",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/master_card.png",
                    width: 29,
                    height: 22,
                  ),
                  const Text("**** **** **** 8357"),
                ],
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 12,
              ),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Détails",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const ListTile(
              title: Text(
                "Colis 1",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text("1x Fer Torsadé"),
              trailing: Text(
                "Livré le 1 Juin 2023",
                style: TextStyle(color: AssetColors.blueButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
