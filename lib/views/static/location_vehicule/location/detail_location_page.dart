import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/location_vehicule/vehicule.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';

import 'resume_location_vehicule_page.dart';

class DetailLocationVehiculePage extends StatelessWidget {
  final Vehicule vehicule;
  const DetailLocationVehiculePage(this.vehicule, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la location'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CButton(
          height: 50,
          onPressed: () => Get.to(() => ResumeLocationVehiculePage(vehicule)),
          child: const Text("Continuer"),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: AssetColors.grey8),
              ),
              title: const Text("Avec chauffeur"),
              subtitle: const Text(
                "Vous n’avez pas de chauffeur? Louez la"
                " voiture avec un chauffeur et un rabais",
                style: TextStyle(fontSize: 12),
              ),
              trailing: Switch(value: false, onChanged: (value) {}),
            ),
            const Gap(20),
            Row(
              children: const [
                Expanded(
                  child: CTextFormField(
                    labelText: "Heure début",
                    require: true,
                  ),
                ),
                Gap(10),
                Expanded(
                  child: CTextFormField(
                    labelText: "Heure Fin",
                    require: true,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
