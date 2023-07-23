import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/views/controllers/location_vehicule/edition_location_vehicule_vctl.dart';
import 'package:wan_mobile/views/static/location_vehicule/mes_voitures/edition_location/edition_detail_vehicule_location.dart';
import 'package:wan_mobile/views/static/location_vehicule/mes_voitures/edition_location/edition_image_vehicule.dart';
import 'package:wan_mobile/views/static/location_vehicule/mes_voitures/edition_location/edition_specification_location.dart';

class EditionLocationVehicule extends StatelessWidget {
  const EditionLocationVehicule({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditionLocationVehiculeVctl>(
        init: EditionLocationVehiculeVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Ma voiture"),
            ),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: ctl.pageController,
              children: [
                EditionDetailsVehicule(ctl),
                EditionSpecificationLocation(ctl),
                EditionImageVehicule(ctl),
              ],
            ),
          );
        });
  }
}
