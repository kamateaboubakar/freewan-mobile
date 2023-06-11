import 'package:flutter/material.dart';
import 'package:wan_mobile/models/location_vehicule/categorie_vehicule.dart';
import 'package:wan_mobile/models/location_vehicule/vehicule.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/tools/widgets/location_vehicule/ban_vehicule.dart';
import 'package:wan_mobile/tools/widgets/location_vehicule/card_vehicule.dart';

class ALouerPage extends StatelessWidget {
  const ALouerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: CTextFormField(
              hintText: "Chercher une voiture",
              suffixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(
            height: 130,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategorieVehicule(
                  image: "assets/images/image_vehicule.png",
                  name: "Standard",
                  nb: "56",
                ),
                CategorieVehicule(
                  image: "assets/images/image_vehicule_2.png",
                  name: "Prestige",
                  nb: "22",
                ),
                CategorieVehicule(
                  image: "assets/images/image_vehicule_3.png",
                  name: "SUV",
                  nb: "34",
                ),
              ].map((e) => BanVehicule(e)).toList(),
            ),
          ),
          const ListTile(
            title: Text("Véhicules Disponibles"),
          ),
          GridView.count(
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            primary: false,
            childAspectRatio: .8,
            crossAxisCount: 2,
            children: [
              Vehicule(
                marque: "Toyota",
                moteur: "4-Cyl 1.5 Liter",
                nbJour: "2",
                name: "Yaris iA",
                image: "assets/images/img_boutique_vehicule.png",
                prix: "F 50 000",
              ),
              Vehicule(
                marque: "Toyota",
                moteur: "4-Cyl 1.5 Liter",
                nbJour: "2",
                name: "Yaris iA",
                image: "assets/images/img_boutique_vehicule.png",
                prix: "F 50 000",
              ),
              Vehicule(
                marque: "Toyota",
                moteur: "4-Cyl 1.5 Liter",
                nbJour: "2",
                name: "Yaris iA",
                image: "assets/images/img_boutique_vehicule.png",
                prix: "F 50 000",
              ),
              Vehicule(
                marque: "Toyota",
                moteur: "4-Cyl 1.5 Liter",
                nbJour: "2",
                name: "Yaris iA",
                image: "assets/images/img_boutique_vehicule.png",
                prix: "F 50 000",
              ),
            ].map((e) => CardVehicule(e)).toList(),
          )
        ],
      ),
    );
  }
}
