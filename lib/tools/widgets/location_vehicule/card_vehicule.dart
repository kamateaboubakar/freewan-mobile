import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wan_mobile/models/location_vehicule/vehicule.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';

class CardVehicule extends StatelessWidget {
  final Vehicule vehicule;
  const CardVehicule(this.vehicule, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AssetColors.grey8, width: .5),
        ),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  vehicule.image.value,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(15),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            vehicule.marque.value,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          vehicule.prix.value,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AssetColors.blueButton,
                          ),
                        )
                      ],
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            vehicule.name.value,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AssetColors.grey9,
                            ),
                          ),
                        ),
                        Text(
                          "${vehicule.nbJour.value}/jour",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AssetColors.grey9,
                          ),
                        )
                      ],
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Moteur",
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          vehicule.moteur.value,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
