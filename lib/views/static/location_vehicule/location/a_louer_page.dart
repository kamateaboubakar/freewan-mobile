import 'package:flutter/material.dart';
import 'package:tools_flutter_project/widgets/c_textform_field.dart';
import 'package:tools_flutter_project/widgets/wrapper_body_gridview.dart';
import 'package:tools_flutter_project/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/tools/widgets/location_vehicule/ban_vehicule.dart';
import 'package:wan_mobile/tools/widgets/location_vehicule/card_vehicule.dart';
import 'package:wan_mobile/views/controllers/location_vehicule/location_vehicule_vctl.dart';

class VehiculeALouerPage extends StatelessWidget {
  final LocationVehiculeVclt ctl;
  const VehiculeALouerPage(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ctl.fecthData,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CTextFormField(
                hintText: "Chercher une voiture",
                suffixIcon: const Icon(Icons.search),
                onChanged: (e) {
                  ctl.search = e;
                  ctl.update();
                },
              ),
            ),
            SizedBox(
              height: 130,
              width: double.infinity,
              child: WrapperBodyListView(
                // error: ctl.marketCarsError,
                onRefresh: ctl.fecthCategories,
                // scrollDirection: Axis.horizontal,
                emptyWidget: const SizedBox.shrink(),
                loading: ctl.loadCategories,
                children: ctl.categories
                    .map(
                      (e) => BanVehicule(
                        e,
                        seleted: ctl.selectedCategorie == e.id,
                        onTap: () {
                          if (ctl.selectedCategorie == e.id) {
                            ctl.selectedCategorie = null;
                            ctl.update();
                          } else {
                            ctl.selectedCategorie = e.id;
                            ctl.update();
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            const ListTile(
              title: Text("Véhicules Disponibles"),
            ),
            WrapperBodyGridView(
              // primary: false,
              childAspectRatio: .8,
              crossAxisSpacing: 5,
              // shrinkWrap: true,
              onRefresh: ctl.fecthMarketCars,
              loading: ctl.loadMarketCars,
              crossAxisCount: 2,
              children: ctl.getMarketCars.map((e) => CardVehicule(e)).toList(),
            ),
            // GridView.count(
            //   padding: const EdgeInsets.all(10),
            //   crossAxisSpacing: 10,
            //   mainAxisSpacing: 10,
            //   shrinkWrap: true,
            //   primary: false,
            //   childAspectRatio: .8,
            //   crossAxisCount: 2,
            //   children: [
            //     Car(
            //       brand: "Toyota",
            //       motor: "4-Cyl 1.5 Liter",
            //       power: "100 Ch",
            //       model: "Yaris iA",
            //       image: "assets/images/img_boutique_vehicule.png",
            //       priceWithoutDriver: 50000,
            //       maxSpeed: "220 km/h",
            //       propietaireVehicule: PropietaireVehicule(
            //         prenoms: "Franck",
            //         nom: "Lepard",
            //         rating: "5",
            //       ),
            //     ),
            //   ].map((e) => CardVehicule(e)).toList(),
            // )
          ],
        ),
      ),
    );
  }
}
