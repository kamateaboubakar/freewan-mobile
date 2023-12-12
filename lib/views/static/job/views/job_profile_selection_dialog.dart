import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/views/static/job/views/employee/employee_views.dart';

import 'employer/employer_views.dart';

class JobProfileSelectionDialog extends StatelessWidget {
  const JobProfileSelectionDialog({super.key});

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
              "Choisissez votre profil",
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(
            thickness: 1,
            color: Color.fromRGBO(181, 196, 216, 0.65),
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/flat-color-icons_manager.png",
              width: 48,
              height: 48,
            ),
            title: const Text(
              "Employeur",
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(7, 21, 60, 1),
              ),
            ),
            subtitle: const Text(
              "Vous pouvez ajouter des emplois",
              style: TextStyle(
                fontSize: 12,
                color: Color.fromRGBO(38, 82, 140, 1),
              ),
            ),
            onTap: () => Get.to(() => const JobEmployerOffersPage()),
          ),
          const Divider(
            thickness: 1,
            color: Color.fromRGBO(181, 196, 216, 0.65),
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/twemoji_deaf-man-medium-dark-skin-tone.png",
              width: 48,
              height: 48,
            ),
            title: const Text(
              "Demandeur d’emploi",
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(7, 21, 60, 1),
              ),
            ),
            subtitle: const Text(
              "Trouvez l’emploi de vos rêves",
              style: TextStyle(
                fontSize: 12,
                color: Color.fromRGBO(38, 82, 140, 1),
              ),
            ),
            onTap: () => Get.to(() => const JobHomePage()),
          ),
        ],
      ),
    );
  }
}
