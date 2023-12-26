import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/widgets/card_menu.dart';
import 'package:wan_mobile/views/tools/menu_button_enum.dart';
import 'package:wan_mobile/views/tools/routes.dart';

class MoreOptionHomePage extends StatelessWidget {
  final Set<MenuButtonEnum> menus;
  final String groupeTitle;
  const MoreOptionHomePage(
      {required this.groupeTitle, required this.menus, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(title: Text(groupeTitle)),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          CardMenu(
            children: Routes()
                .routesByList(menus: menus.toList())
                .map((e) => e.button)
                .toList(),
          ),
        ],
      ),
    );
  }
}
