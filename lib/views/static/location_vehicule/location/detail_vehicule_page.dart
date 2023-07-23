import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/location_vehicule/car.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/static/location_vehicule/location/detail_location_page.dart';

class DetailVehiculePage extends StatelessWidget {
  final Car vehicule;
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
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: .1,
                  color: Colors.grey,
                ),
              ),
              child: (vehicule.images.isEmpty)
                  ? const Center(child: Text("Aucune image"))
                  : ImageSlideshow(
                      isLoop: true,
                      autoPlayInterval: 6000,
                      children: vehicule.images
                          .map(
                            (e) => ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    e.url.value,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
            const Gap(20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${vehicule.brand.value} ${vehicule.model.value}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: vehicule.priceWithoutDriver.value.toAmount(),
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
                      Text(vehicule.propietaireVehicule?.rating ?? "0"),
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
              // height: 100,
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
                        Text(vehicule.motor.value),
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
                        Text("${vehicule.power.value} Ch"),
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
                        Text("${vehicule.maxSpeed.value} km/h"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            (vehicule.options.isEmpty)
                ? const SizedBox.shrink()
                : Column(
                    children: [
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
                                  title: Text("${vehicule.seats} passager(s)"),
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
                                  title: Text(
                                    "Plein",
                                    style: TextStyle(
                                      decoration: (vehicule
                                                  .options.first.withFullFuel ==
                                              1)
                                          ? TextDecoration.none
                                          : TextDecoration.lineThrough,
                                    ),
                                  ),
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
                                  title: Text(
                                    "Air Conditionné",
                                    style: TextStyle(
                                      decoration: (vehicule.options.first
                                                  .airConditoner ==
                                              1)
                                          ? TextDecoration.none
                                          : TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                              ),
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
                                  title: Text(vehicule.transmission.value),
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
                                  title: Text(vehicule.year.value),
                                ),
                              ),
                            ],
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
