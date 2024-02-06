import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/models/mall/maller.dart';
import 'package:wan_mobile/routes/tools/actions/on_pressed_action.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';

class MallPage extends StatelessWidget {
  const MallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AssetColors.blue2,
      appBar: AppBar(
        title: const Text("${AppConst.appName} Mall"),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: const EdgeInsets.all(10),
        children: [
          Maller(
            photoLink: "assets/images/peryssac.png",
            url: "https://peyrissac.com/shop/",
          ),
          Maller(
            photoLink: "assets/images/technibat.png",
            url: "https://peyrissac.com/shop/",
          ),
          Maller(
            photoLink: "assets/images/bernabe.png",
            url: "https://peyrissac.com/shop/",
          ),
          Maller(
            photoLink: "assets/images/mr_bricolage.png",
            url: "https://mrbricolage-ci.com/",
          ),
          Maller(
            photoLink: "assets/images/auchan.png",
            url: "https://www.auchan.ci/",
          ),
          Maller(
            photoLink: "assets/images/jumia.png",
            url: "https://www.jumia.ci/",
          ),
          Maller(
            photoLink: "assets/images/carrefour.png",
            url: "https://www.carrefour.ci/",
          ),
          Maller(
            photoLink: "assets/images/socofrais.png",
            url: "https://yango.com/fr_ci/city/abidjan",
          ),
        ]
            .map(
              (e) => ButtonMenu(
                withCircleIcon: false,
                icon: Image.asset(e.photoLink),
                action: OnPressedAction(
                  onPressed: () => launchUrl(
                    Uri.parse(e.url),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
