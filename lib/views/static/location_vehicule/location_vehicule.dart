import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/views/static/location_vehicule/location/a_louer_page.dart';
import 'package:wan_mobile/views/static/location_vehicule/mes_voitures/mes_voitures_page.dart';

class LocationVehicule extends StatelessWidget {
  const LocationVehicule({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Voitures"),
          bottom: const TabBar(
            labelColor: AssetColors.blueButton,
            indicatorColor: AssetColors.blueButton,
            indicatorWeight: 3,
            tabs: [
              Tab(text: "A Louer"),
              Tab(text: "Mes voitures"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            VehiculeALouerPage(),
            MesVoituresPage(),
          ],
        ),
      ),
    );
  }
}
