import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/location_vehicule/car.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:module_master/module_master.dart';
import 'package:wan_mobile/views/static/location_vehicule/location/detail_vehicule_page.dart';

class CardVehicule extends StatelessWidget {
  final Car vehicule;
  const CardVehicule(this.vehicule, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => DetailVehiculePage(vehicule)),
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
                child: (vehicule.images.isEmpty)
                    ? const Icon(Icons.broken_image_rounded,
                        color: AssetColors.blueButton)
                    : ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        child: Image.network(
                          vehicule.images.first.url.value,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image_rounded),
                        ),
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
                            vehicule.brand!.name.value,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          vehicule.priceWithoutDriver.value
                              .toAmount(withDevise: false),
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
                            vehicule.model.value,
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AssetColors.grey9,
                            ),
                          ),
                        ),
                        const Text(
                          "/jour",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AssetColors.grey9,
                          ),
                        )
                      ],
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        const Text(
                          "Moteur",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: Text(
                            vehicule.motor.value,
                            textAlign: TextAlign.end,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
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
