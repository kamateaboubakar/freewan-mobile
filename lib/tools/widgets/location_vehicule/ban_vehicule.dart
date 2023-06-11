import 'package:flutter/material.dart';
import 'package:wan_mobile/models/location_vehicule/categorie_vehicule.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';

class BanVehicule extends StatelessWidget {
  final CategorieVehicule categorieVehicule;
  const BanVehicule(this.categorieVehicule, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      margin: const EdgeInsets.all(1),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                color: Colors.white,
                width: 30,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AssetColors.blueButton,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Image.asset(
                categorieVehicule.image.value,
                width: 135,
                height: 64,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 5),
                child: Column(
                  children: [
                    Text(
                      categorieVehicule.name.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      categorieVehicule.nb.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
