import 'package:flutter/material.dart';
import 'package:lbd_e_assurance/views/static/e_assurance_home_page.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/routes/tools/actions/on_pressed_action.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';

class AssurancesHomePage extends StatelessWidget {
  const AssurancesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AssetColors.blue2,
      appBar: AppBar(
        title: const Text("Assurances"),
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
          "assets/images/assurances/activa.jpg",
          "assets/images/assurances/allianz.jpg",
          "assets/images/assurances/Atl.png",
          "assets/images/assurances/Atlantique-Assurances.png",
          "assets/images/assurances/axa.jpeg",
          "assets/images/assurances/gna.png",
          "assets/images/assurances/matca.png",
          "assets/images/assurances/nsia.png",
          "assets/images/assurances/ogImage.jpg",
          "assets/images/assurances/serenity.png",
          "assets/images/assurances/sunu.jpg",
          "assets/images/assurances/wafa.jpg",
          "assets/images/assurances/schiba_assurance_center.png",
          "assets/images/assurances/coris.png",
          "assets/images/assurances/leadway.png",
        ]
            .map(
              (e) => ButtonMenu(
                withCircleIcon: false,
                icon: Image.asset(e),
                action: OnPressedAction(
                  onPressed: () => Get.to(() => const EAssuranceHomePage()),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
