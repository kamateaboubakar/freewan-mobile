import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/location_vehicule/vehicule.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/location_vehicule/card_vehicule.dart';
import 'package:wan_mobile/tools/widgets/location_vehicule/proprietaire_vehicule.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body_gridview.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/views/static/location_vehicule/mes_voitures/edition_location/edition_location.dart';

class MesVoituresPage extends StatelessWidget {
  const MesVoituresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const EditionLocationVehicule()),
        backgroundColor: AssetColors.blueButton,
        child: const Icon(Icons.add),
      ),
      body: WrapperBodyGridView(
        childAspectRatio: .8,
        emptyText: "Aucune voiture",
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        emptyWidget: Image.asset("assets/images/empty_content.png"),
        onRefresh: () async {},
        loading: false,
        children: [
          Vehicule(
            marque: "Toyota",
            moteur: "4-Cyl 1.5 Liter",
            nbJour: "2",
            puissance: "100 Ch",
            modele: "Yaris iA",
            image: "assets/images/img_boutique_vehicule.png",
            prix: "F 50 000",
            vitesseMax: "220 km/h",
            propietaireVehicule: PropietaireVehicule(
              prenoms: "Franck",
              nom: "Lepard",
              rating: "5",
            ),
          ),
          Vehicule(
            marque: "Toyota",
            moteur: "4-Cyl 1.5 Liter",
            nbJour: "2",
            puissance: "100 Ch",
            modele: "Yaris iA",
            image: "assets/images/img_boutique_vehicule.png",
            prix: "F 50 000",
            vitesseMax: "220 km/h",
            propietaireVehicule: PropietaireVehicule(
              prenoms: "Franck",
              nom: "Lepard",
              rating: "5",
            ),
          ),
        ].map((e) => CardVehicule(e)).toList(),
      ),
    );
  }
}
