import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_loyer/views/static/locataire/loyer_locataire_home_page.dart';
import 'package:lebedoo_loyer/views/static/proprietaire/loyer_proprietaire_home_page.dart';

class LoyerBottomSheet extends StatelessWidget {
  const LoyerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loyer"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading:
                Image.asset("assets/images/icons/proprio_logo.png", width: 48),
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
            onTap: () => Get.to(() => const LoyerProprietaireHomePage()),
          ),
          const Divider(
            indent: 50,
            thickness: 1,
            color: Color.fromRGBO(181, 196, 216, 0.65),
          ),
          ListTile(
            leading: Image.asset("assets/images/icons/locataire_logo.png",
                width: 48),
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
            onTap: () => Get.to(() => const LoyerLocataireHomePage()),
          ),
        ],
      ),
    );
  }
}
