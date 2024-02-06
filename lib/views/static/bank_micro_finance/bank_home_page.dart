import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';

class BankHomePage extends StatelessWidget {
  const BankHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AssetColors.blue2,
      appBar: AppBar(
        title: const Text("Banques"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: WrapperBodyGridView(
        listPadding: const EdgeInsets.all(10),
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        emptyWidget: const EmptyListContent(),
        loading: false,
        children: [
          "assets/images/banques/afg.png",
          "assets/images/banques/afriland.jpeg",
          "assets/images/banques/atlantique_banque.png",
          "assets/images/banques/bda.png",
          "assets/images/banques/bgfi.jpeg",
          "assets/images/banques/bhci.png",
          "assets/images/banques/bicici.jpeg",
          "assets/images/banques/bms.jpeg",
          "assets/images/banques/bni.png",
          "assets/images/banques/boa.jpeg",
          "assets/images/banques/bp.jpeg",
          "assets/images/banques/bridge.jpeg",
          "assets/images/banques/bsic.jpeg",
          "assets/images/banques/citi.png",
          "assets/images/banques/coris_bank.jpeg",
          "assets/images/banques/dbu.png",
          "assets/images/banques/ecobank.jpeg",
          "assets/images/banques/gt_bank.png",
          "assets/images/banques/nsia_banque.jpeg",
          "assets/images/banques/orabank.jpeg",
          "assets/images/banques/orange_bank.jpeg",
          "assets/images/banques/sib.png",
          "assets/images/banques/stanbik.jpeg",
          "assets/images/banques/standard_chartered.jpeg",
          "assets/images/banques/uba.jpeg",
          "assets/images/banques/versus_bank.jpeg",
        ]
            .map(
              (e) => ButtonMenu(
                withCircleIcon: false,
                icon: Image.asset(e),
              ),
            )
            .toList(),
      ),
    );
  }
}
