import 'package:flutter/material.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:wan_mobile/models/location_vehicule/marque_vehicule.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/widgets/location_vehicule/ban_vehicule.dart';
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
                    trailing: Text("1/3"),
                  ),
                  const Gap(20),
                  SizedBox(
                    height: 130,
                    width: double.infinity,
                    child: WrapperBodyListView(
                      onRefresh: ctl.fecthCategories,
                      // scrollDirection: Axis.horizontal,
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
                  CDropdownField<MarqueVehicule>(
                    labelText: "Marque",
                    selectedItem: ctl.marqueVehicule,
                    require: true,
                    asyncItems: (e) => ctl.fetchMarque(),
                    itemAsString: (e) => e.name.value,
                    onChanged: (value) {
                      ctl.marqueVehicule = value;
                      ctl.update();
                    },
                  ),
                  CTextFormField(
                    controller: ctl.modeleVehiculeCtl,
                    labelText: "Modèle",
                    require: true,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  CTextFormField(
                    controller: ctl.anneeVehiculeCtl,
                    labelText: "Année",
                    require: true,
                    keyboardType: TextInputType.number,
                  ),
                  CDropdownField(
                    labelText: "Transmission",
                    items: const ["Manuelle", "Automatique"],
                    selectedItem: ctl.transmission,
                    require: true,
                    onChanged: (e) {
                      ctl.transmission = e;
                      ctl.update();
                    },
                  ),
                  CTextFormField(
                    require: true,
                    labelText: "Plaque d'immatriculation",
                    controller: ctl.plaqueImmatriculation,
                  ),
                  CDropdownField(
                    labelText: "Energie",
                    items: const ["Diesel / Gasoil", "Super / Essence"],
                    selectedItem: ctl.energie,
                    require: true,
                    onChanged: (e) {
                      ctl.energie = e;
                      ctl.update();
                    },
                  ),
                  CTextFormField(
                    require: true,
                    labelText: "Couleur",
                    controller: ctl.couleur,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  CTextFormField(
                    require: true,
                    labelText: "Nombre de places",
                    controller: ctl.nbPlaces,
                  ),
                  CTextFormField(
                    controller: ctl.vitesseMaxCtl,
                    labelText: "Vitesse max",
                    hintText: "KM/h",
                    require: true,
                    keyboardType: TextInputType.number,
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
