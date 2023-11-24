import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/widgets/construction/panier_materiau_construction_listtile.dart';
import 'package:wan_mobile/views/static/construction/confirmation_commande_construction_page.dart';

class PanierMateriauConstructionPage extends StatelessWidget {
  const PanierMateriauConstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AssetColors.grey300,
      appBar: AppBar(title: const Text("Panier")),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Articles (1):",
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
                "Taxe:",
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
                "Total:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                "15 000 F",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Gap(30),
            CButton(
              minWidth: double.infinity,
              onPressed: () =>
                  Get.to(() => const ConfirmationCommandeConstructionPage()),
              height: 50,
              child: const Text("Continuer"),
            ),
          ],
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          children: [
            PanierMateriauConstructionListTile(),
          ],
        ),
      ),
    );
  }
}
