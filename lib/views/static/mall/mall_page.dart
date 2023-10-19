import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';

class MallPage extends StatelessWidget {
  const MallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mall"),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          ButtonMenu(
            icon: Image.asset("assets/images/jumia_food.jpeg"),
            onPressed: () {},
          ),
          ButtonMenu(
            icon: Image.asset("assets/images/jumia.png"),
            onPressed: () {},
          ),
          ButtonMenu(
            icon: Image.asset("assets/images/yango.png"),
            onPressed: () {},
          ),
          ButtonMenu(
            icon: Image.asset("assets/images/carrefour.png"),
            onPressed: () {},
          ),
          ButtonMenu(
            icon: Image.asset("assets/images/socofrais.png"),
            onPressed: () {},
          ),
          ButtonMenu(
            icon: Image.asset("assets/images/texas-grillz.jpg"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
