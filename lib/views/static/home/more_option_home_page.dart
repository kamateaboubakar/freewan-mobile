import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/widgets/card_menu.dart';
import 'package:wan_mobile/views/tools/menu_button_enum.dart';
import 'package:wan_mobile/views/tools/routes.dart';

class MoreOptionHomePage extends StatelessWidget {
  const MoreOptionHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Image.asset(
          Const.inLineAppLogo,
          width: 100,
          height: 50,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          CardMenu(
            children: Routes.routes(menus: [
              MenuButtonEnum.scolarite,
            ]).map((e) => e.button).toList(),
          )
        ],
      ),
    );
  }
}
