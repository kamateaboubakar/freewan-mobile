import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gap/gap.dart';
import 'package:wan_mobile/models/location_vehicule/categorie_vehicule.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_dropdown_field.dart';
import 'package:wan_mobile/tools/widgets/location_vehicule/ban_vehicule.dart';

class EditionDetailsVehicule extends StatelessWidget {
  const EditionDetailsVehicule({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Informations de la voiture"),
                  trailing: Text("1/2"),
                ),
                const Gap(20),
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
                const Gap(20),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "Détails de la voiture",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CDropdownField(
                        labelText: "Marque",
                        require: true,
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: CDropdownField(
                        labelText: "Modele",
                        require: true,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CDropdownField(
                        labelText: "Année",
                        require: true,
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: CDropdownField(
                        labelText: "Transmission",
                        require: true,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AssetColors.grey4),
                  ),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text("Air conditionné"),
                        value: false,
                        onChanged: (value) {},
                      ),
                      const Divider(color: AssetColors.grey4),
                      SwitchListTile(
                        title: const Text("Le plein sera fait"),
                        value: false,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: CButton(
            minWidth: double.infinity,
            height: 50,
            onPressed: () {},
            child: const Text("Continuer"),
          ),
        ),
      ],
    );
  }
}
