import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/location_vehicule/vehicule.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';

class ResumeLocationVehiculePage extends StatelessWidget {
  final Vehicule vehicule;
  const ResumeLocationVehiculePage(this.vehicule, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Résumé'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CButton(
          height: 50,
          onPressed: () => Get.to(() => ResumeLocationVehiculePage(vehicule)),
          child: const Text("Payer | 120 000 F"),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(vehicule.image.value),
              ),
            ),
            const Gap(20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${vehicule.marque.value} ${vehicule.modele.value}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: vehicule.prix.value,
                      children: const [
                        TextSpan(
                          text: " / jour",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AssetColors.grey4,
                          ),
                        ),
                      ],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AssetColors.blueButton,
                      ),
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              children: const [
                Expanded(
                  child: CTextFormField(
                    labelText: "Début",
                    require: true,
                    readOnly: true,
                  ),
                ),
                Gap(10),
                Expanded(
                  child: CTextFormField(
                    labelText: "Fin",
                    require: true,
                    readOnly: true,
                  ),
                ),
              ],
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Lieu de récupération",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Gap(10),
            ListTile(
              contentPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: AssetColors.grey8),
              ),
              title: const Text("Utiliser cette localisation"),
              subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.location_on,
                    color: AssetColors.blueButton,
                    size: 13,
                  ),
                  Gap(5),
                  Text(
                    "Rue M66",
                    style: TextStyle(
                      color: AssetColors.blueButton,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 12,
              ),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Paiement",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: AssetColors.grey8),
              ),
              title: const Text("Utiliser ce moyen de paiement"),
              subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/master_card.png",
                    width: 32,
                    height: 29,
                  ),
                  const Gap(5),
                  const Text(
                    "**** **** **** 8357",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
