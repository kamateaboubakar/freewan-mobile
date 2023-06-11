import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/location_vehicule/vehicule.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/static/location_vehicule/location/detail_location_page.dart';

class DetailVehiculePage extends StatelessWidget {
  final Vehicule vehicule;
  const DetailVehiculePage(this.vehicule, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CButton(
          height: 50,
          onPressed: () => Get.to(() => DetailLocationVehiculePage(vehicule)),
          child: const Text("Louer"),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(vehicule.image.value),
              ),
            ),
            const Gap(20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${vehicule.marque.value} ${vehicule.modele.value}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: vehicule.prix.value,
                      children: const [
                        TextSpan(
                          text: " / jour",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AssetColors.grey4,
                          ),
                        ),
                      ],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AssetColors.blueButton,
                      ),
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const Gap(20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundImage: AssetImage("assets/images/Ellipse.png"),
              ),
              title: const Text("Franck Lepard"),
              subtitle: const Text("Propriétaire"),
              trailing: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.amber,
                      ),
                      Text(vehicule.propietaireVehicule!.rating.value),
                    ],
                  ),
                  const Text("(20 votes)")
                ],
              ),
            ),
            const Gap(10),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Spécifications",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Gap(13),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "Moteur",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AssetColors.grey3,
                          ),
                        ),
                        Text(vehicule.moteur.value),
                      ],
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "Puissance",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AssetColors.grey3,
                          ),
                        ),
                        Text(vehicule.puissance.value),
                      ],
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "Vitesse Max",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AssetColors.grey3,
                          ),
                        ),
                        Text(vehicule.vitesseMax.value),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Informations de la voiture",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Gap(16),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 5,
                        leading: Image.asset(
                          "assets/images/passagers.png",
                          width: 17,
                        ),
                        title: const Text("5 passagers"),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 5,
                        leading: Image.asset(
                          "assets/images/Plein.png",
                          width: 17,
                        ),
                        title: const Text("Plein"),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      minLeadingWidth: 5,
                      leading: Image.asset(
                        "assets/images/air_Conditionne.png",
                        width: 17,
                      ),
                      title: const Text("Air Conditionné"),
                    )),
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 5,
                        leading: Image.asset(
                          "assets/images/portieres.png",
                          width: 17,
                        ),
                        title: const Text("5 portières"),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 5,
                        leading: Image.asset(
                          "assets/images/automatique.png",
                          width: 17,
                        ),
                        title: const Text("Automatique"),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 5,
                        leading: Image.asset(
                          "assets/images/annee.png",
                          width: 17,
                        ),
                        title: const Text("2021"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
