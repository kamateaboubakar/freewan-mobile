import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/views/static/moyens_paiements/cartes_bancaires/cartes_bancaires_page.dart';
import 'package:wan_mobile/views/static/moyens_paiements/compte_bancaire/compte_bancaire_page.dart';
import 'package:wan_mobile/views/static/moyens_paiements/crypto_wallet/crypto_wallet_page.dart';
import 'package:wan_mobile/views/static/moyens_paiements/mobile_money/mobile_money_page.dart';

class MoyensPaiementsPage extends StatelessWidget {
  const MoyensPaiementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes moyens de paiement"),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Image.asset(
                "assets/images/icons/mobile_money.png",
                width: 30,
              ),
            ),
            title: const Text("Mobiles Money"),
            onTap: () => Get.to(() => const MobileMoneyPage()),
            trailing: const Icon(Icons.arrow_forward),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Image.asset(
                "assets/images/icons/carte-bancaire_lbd.png",
                width: 30,
              ),
            ),
            title: const Text("Cartes prépayées"),
            onTap: () => Get.to(() => const CartesBancairesPage()),
            trailing: const Icon(Icons.arrow_forward),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Image.asset(
                "assets/images/icons/compte-bancaire.png",
                width: 30,
              ),
            ),
            title: const Text("Comptes bancaires"),
            onTap: () => Get.to(() => const CompteBancairePage()),
            trailing: const Icon(Icons.arrow_forward),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Image.asset(
                "assets/images/icons/icons8-crypto-64.png",
                width: 30,
              ),
            ),
            title: const Text("Crypto wallets"),
            onTap: () => Get.to(() => const CryptoWalletPage()),
            trailing: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
