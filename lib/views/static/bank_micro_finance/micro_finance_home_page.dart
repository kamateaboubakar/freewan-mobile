import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';

class MicroFinanceHomePage extends StatelessWidget {
  const MicroFinanceHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AssetColors.blue2,
      appBar: AppBar(
        title: const Text("Microfinances"),
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
          "assets/images/microfinances/adec.jpeg",
          "assets/images/microfinances/advans.png",
          "assets/images/microfinances/baobab.png",
          "assets/images/microfinances/coopec.png",
          "assets/images/microfinances/finelle.png",
          "assets/images/microfinances/fidra.jpg",
          "assets/images/microfinances/cofina.jpg",
          "assets/images/microfinances/witti.jpg",
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
