import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:gap/gap.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_dropdown_field.dart';
import 'package:wan_mobile/tools/widgets/location_vehicule/ban_vehicule.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/views/controllers/location_vehicule/edition_location_vehicule_vctl.dart';

class EditionDetailsVehicule extends StatelessWidget {
  final EditionLocationVehiculeVctl ctl;
  const EditionDetailsVehicule(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ctl.form1Key,
      child: Column(
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
                    child: WrapperBodyListView(
                      onRefresh: ctl.fecthCategories,
                      scrollDirection: Axis.horizontal,
                      emptyWidget: const SizedBox.shrink(),
                      loading: ctl.loadCategories,
                      children: ctl.categories
                          .map(
                            (e) => BanVehicule(
                              e,
                              seleted: ctl.categorieVehicule == e,
                              onTap: () {
                                ctl.categorieVehicule = e;
                                ctl.update();
                              },
                            ),
                          )
                          .toList(),
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
                  const Row(
                    children: [
                      Expanded(
                        child: CDropdownField(
                          labelText: "Marque",
                          require: true,
                        ),
                      ),
                      Gap(10),
                      Expanded(
                        child: CDropdownField(
                          labelText: "Modele",
                          require: true,
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: CDropdownField(
                          labelText: "Année",
                          require: true,
                        ),
                      ),
                      Gap(10),
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
                          value: ctl.airConditioner,
                          onChanged: (value) {
                            ctl.airConditioner = value;
                            ctl.update();
                          },
                        ),
                        const Divider(color: AssetColors.grey4, height: 0),
                        SwitchListTile(
                          title: const Text("Le plein sera fait"),
                          value: ctl.fullFuel,
                          onChanged: (value) {
                            ctl.fullFuel = value;
                            ctl.update();
                          },
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
              onPressed: () => ctl.validStepOne(),
              child: const Text("Continuer"),
            ),
          ),
        ],
      ),
    );
  }
}
