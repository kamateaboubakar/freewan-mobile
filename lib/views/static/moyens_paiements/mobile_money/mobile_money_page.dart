import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/models/paiement/mobile_money.dart';
import 'package:wan_mobile/views/static/moyens_paiements/mobile_money/edition_mobile_money.dart';

class MobileMoneyPage extends StatelessWidget {
  const MobileMoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes mobiles money"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AssetColors.blueButton,
        onPressed: () => Get.to(() => const EditionMobileMoney()),
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
          MobileMoney(numeroTelephone: "0131234567"),
        ]
            .map(
              (e) => ListTile(
                leading: CircleAvatar(
                  child: Image.asset(
                    "assets/images/icons/mobile_money.png",
                    width: 30,
                  ),
                ),
                title: Text(e.numeroTelephone.value),
                subtitle: Text(e.provider),
                trailing: const Icon(Icons.arrow_forward),
              ),
            )
            .toList(),
      ),
    );
  }
}
