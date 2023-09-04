import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/static/tv_bills/tv_bills_menu_page.dart';

class TvBillsSelectionDialog extends StatelessWidget {
  const TvBillsSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      height: 249,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 17, bottom: 13),
            child: Text(
              "Choisissez le service",
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(
            thickness: 1,
            color: Color.fromRGBO(181, 196, 216, 0.65),
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/Canal+1.png",
              width: 35,
              height: 35,
            ),
            title: const Text(
              "Abonnement CANALPLUS",
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(7, 21, 60, 1),
              ),
            ),
            subtitle: const Text(
              "Payez our votre abonnement et l’abonnement de vos proches",
              style: TextStyle(
                fontSize: 12,
                color: Color.fromRGBO(38, 82, 140, 1),
              ),
            ),
            onTap: () async {
              var page = Get.currentRoute;
              await Get.to(() => TvBillsMenuPage(route: page));
              if (Get.parameters["paiementResult"] == "true") {
                Tools.showToast();
              }
            },
          ),
          const Divider(
            thickness: 1,
            color: Color.fromRGBO(181, 196, 216, 0.65),
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/startime.png",
              width: 40,
              height: 40,
            ),
            title: const Text(
              "Abonnement STARTIMES",
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(7, 21, 60, 1),
              ),
            ),
            subtitle: const Text(
              "Payez pour votre abonnement et l’abonnement de vos proches",
              style: TextStyle(
                fontSize: 12,
                color: Color.fromRGBO(38, 82, 140, 1),
              ),
            ),
            //onTap: () => Get.to(() => const FormulaireCodeMaisonLoyer()),
          ),
        ],
      ),
    );
  }
}
