import 'package:flutter/material.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/models/location_vehicule/categorie_vehicule.dart';

class BanVehicule extends StatelessWidget {
  final CategorieVehicule categorieVehicule;
  final void Function()? onTap;
  final bool seleted;
  const BanVehicule(this.categorieVehicule,
      {this.seleted = false, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                Image.network(categorieVehicule.image, width: 135, height: 64,
                    errorBuilder: (context, e, st) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Text(
                    categorieVehicule.libelle.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            Visibility(
              visible: seleted,
              child: const Align(
                alignment: Alignment(0.9, -0.9),
                child: Icon(
                  Icons.check_box,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
