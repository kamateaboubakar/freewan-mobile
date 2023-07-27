import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:wan_mobile/tools/widgets/card_menu.dart';

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
              children: [
                ButtonMenu(
                  icon: Image.asset("assets/images/icons8-assurance-64.png"),
                  title: "Assurance",
                  onPressed: () {},
                ),
              ],
            )
          ],
        ));
  }
}
