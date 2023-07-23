import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_outlined_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/location_vehicule/edition_location_vehicule_vctl.dart';

class EditionSpecificationLocation extends StatelessWidget {
  final EditionLocationVehiculeVctl ctl;
  const EditionSpecificationLocation(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ctl.form2Key,
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
                    trailing: Text("2/3"),
                  ),
                  const Gap(20),
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Spécifications",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CTextFormField(
                    controller: ctl.moteur,
                    labelText: "Moteur",
                    require: true,
                  ),
                  CTextFormField(
                    controller: ctl.puissance,
                    labelText: "Puissance",
                    hintText: "En chevaux",
                    require: true,
                    keyboardType: TextInputType.number,
                  ),
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Prix / Jour",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Gap(10),
                  SwitchListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: AssetColors.grey4),
                    ),
                    value: ctl.withDriver,
                    onChanged: (value) {
                      ctl.withDriver = value;
                      ctl.priceWithDriver.clear();
                      ctl.update();
                    },
                    title: const Text("Option chauffeur"),
                  ),
                  const Gap(10),
                  Visibility(
                    visible: ctl.withDriver,
                    child: CTextFormField(
                      controller: ctl.priceWithDriver,
                      labelText: "Prix avec chauffeur",
                      require: true,
                      keyboardType: const TextInputType.numberWithOptions(),
                    ),
                  ),
                  CTextFormField(
                    controller: ctl.priceWithoutDriver,
                    labelText: "Prix sans chauffeur",
                    require: true,
                    keyboardType: const TextInputType.numberWithOptions(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                COutlinedButton(
                  height: 50,
                  child: const Icon(Icons.arrow_back),
                  onPressed: () => ctl.pageController.jumpToPage(0),
                ),
                const Gap(10),
                Expanded(
                  child: CButton(
                    minWidth: double.infinity,
                    height: 50,
                    onPressed: ctl.validStepTwo,
                    child: const Text("Continuer"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
