import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/models/paiement/carte_bancaire.dart';
import 'package:wan_mobile/views/static/moyens_paiements/cartes_bancaires/edition_carte_bancaire.dart';

class CartesBancairesPage extends StatelessWidget {
  const CartesBancairesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes cartes bancaires"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AssetColors.blueButton,
        onPressed: () => Get.to(() => const EditionCarteBancaire()),
        child: const Icon(FontAwesomeIcons.plus),
      ),
      body: WrapperBodyListView(
        loading: false,
        emptyWidget: Column(
          children: [
            Image.asset("assets/images/icons/mobile_money.png"),
            const ListTile(
              title: Text(
                "Vous n'avez pas de mobile money",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        children: [
          CarteBancaire(numeroCarte: "9128273728199798778"),
          CarteBancaire(numeroCarte: "9979877891282737281"),
        ]
            .map(
              (e) => ListTile(
                leading: CircleAvatar(
                  child: Image.asset(
                    "assets/images/icons/carte-bancaire_lbd.png",
                    width: 30,
                  ),
                ),
                title: Text(e.label),
                // subtitle: Text(e.numeroCarte),
                trailing: const Icon(Icons.arrow_forward),
              ),
            )
            .toList(),
      ),
    );
  }
}
