import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/location_vehicule/car.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/date_time_range_editing_controller.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/views/controllers/location_vehicule/resume_location_vehicule_page_vctl.dart';

class ResumeLocationVehiculePage extends StatelessWidget {
  final Car vehicule;
  final bool withDriver;
  final List<CustomDateTimeRange> seletedDays;
  const ResumeLocationVehiculePage(this.vehicule, this.seletedDays,
      {required this.withDriver, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResumeLocationVehiculePageVctl>(
        init: ResumeLocationVehiculePageVctl(vehicule, seletedDays, withDriver),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Résumé'),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20),
              child: CButton(
                height: 50,
                onPressed: () => ctl.submit(),
                child: Text(
                    "Payer | ${ctl.vehicule.getTotal(seletedDays.length, withDriver: withDriver).toAmount()}"),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: .1,
                        color: Colors.grey,
                      ),
                    ),
                    child: (ctl.vehicule.images.isEmpty)
                        ? const Center(child: Text("Aucune image"))
                        : ImageSlideshow(
                            children: ctl.vehicule.images
                                .map(
                                  (e) => ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      e.url.value,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          const Icon(Icons.broken_image_sharp),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${vehicule.brand!.name.value} ${vehicule.model.value}",
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: (withDriver)
                                ? ctl.vehicule.priceWithDriver.value.toAmount()
                                : ctl.vehicule.priceWithoutDriver.value
                                    .toAmount(),
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
                    title: const Text("Utiliser ma localisation"),
                    subtitle: (ctl.locationModel?.title == null)
                        ? const Text("Cliquez ici pour utiliser votre "
                            "localisation actuelle")
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: AssetColors.blueButton,
                                size: 13,
                              ),
                              const Gap(5),
                              Text(
                                ctl.locationModel!.title,
                                style: const TextStyle(
                                  color: AssetColors.blueButton,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                    // trailing: const Icon(
                    //   Icons.arrow_forward_ios,
                    //   size: 12,
                    // ),
                    onTap: ctl.requestPermissionForLocation,
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
                    subtitle: (ctl.selectedModePaiement == null)
                        ? null
                        : Text(ctl.selectedModePaiement!.libelle.value),
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     Image.asset(
                    //       "assets/images/master_card.png",
                    //       width: 32,
                    //       height: 29,
                    //     ),
                    //     const Gap(5),
                    //     const Text(
                    //       "**** **** **** 8357",
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                    ),
                    onTap: () => Tools.openBottomSheet(
                      Container(
                        height: Get.height / 2,
                        color: Colors.white,
                        width: double.infinity,
                        child: WrapperBodyListView(
                          loading: false,
                          children: ctl.modePaiements
                              .map(
                                (e) => ListTile(
                                  title: Text(
                                    e.libelle.value,
                                  ),
                                  onTap: () {
                                    ctl.selectedModePaiement = e;
                                    ctl.update();
                                    Get.back();
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
