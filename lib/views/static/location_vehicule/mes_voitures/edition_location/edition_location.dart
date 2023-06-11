import 'package:flutter/material.dart';
import 'package:wan_mobile/views/static/location_vehicule/mes_voitures/edition_location/edition_detail_vehicule_location.dart';
import 'package:wan_mobile/views/static/location_vehicule/mes_voitures/edition_location/edition_specification_location.dart';

class EditionLocationVehicule extends StatelessWidget {
  const EditionLocationVehicule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ma voiture"),
      ),
      body: PageView(
        children: const [
          EditionDetailsVehicule(),
          EditionSpecificationLocation()
        ],
      ),
    );
  }
}
