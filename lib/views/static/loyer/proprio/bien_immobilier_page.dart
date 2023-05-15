import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/controllers/loyer/bien_immobilier_page_vctl.dart';
import 'package:wan_mobile/views/static/loyer/proprio/detail_immobilier_page.dart';
import 'package:wan_mobile/views/static/loyer/proprio/form_edition_appartement.dart';
import 'package:wan_mobile/views/static/loyer/proprio/form_edition_bien_immobilier.dart';

import '../../../../tools/utils/asset_colors.dart';

class BienImmobilierPage extends StatelessWidget {
  const BienImmobilierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BienImmobilierPageVctl>(
        init: BienImmobilierPageVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Bien Immobilier"),
            ),
            floatingActionButton: Visibility(
              visible: ctl.immobiliers.isNotEmpty,
              child: SpeedDial(
                elevation: 0,
                children: [
                  SpeedDialChild(
                    label: "Appartement",
                    onTap: () => Get.to(() => const FormEditionAppartement()),
                    child: const Icon(Icons.add),
                  ),
                  SpeedDialChild(
                    label: "Maison",
                    onTap: () => Get.to(
                      () => const FormEditionBienImmobilier(selectedItem: 0),
                    ),
                    child: const Icon(Icons.add),
                  ),
                  SpeedDialChild(
                    label: "Bloc d’apparts",
                    onTap: () => Get.to(
                      () => const FormEditionBienImmobilier(selectedItem: 1),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ],
                child: const Icon(Icons.add),
              ),
            ),
            body: (ctl.immobiliers.isNotEmpty)
                ? ListView(
                    padding: const EdgeInsets.all(10),
                    children: [
                      MaterialButton(
                        onPressed: () =>
                            Get.to(() => const DetailImmobilierPage()),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/images/icons/immeuble.png",
                              width: 45,
                              height: 65,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Résidences Samray",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "Cocody Danga",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "0 appartements",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromRGBO(71, 36, 251, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Center(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 90),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/icons/empty_folder.png"),
                          const SizedBox(height: 11),
                          const Text("Aucun bien ajouté",
                              style: TextStyle(fontSize: 20)),
                          const SizedBox(height: 14),
                          CButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                              side: const BorderSide(
                                color: AssetColors.blueButton,
                              ),
                            ),
                            color: Colors.transparent,
                            onPressed: () =>
                                Get.to(() => const FormEditionBienImmobilier()),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.add),
                                SizedBox(width: 5),
                                Text("Ajouter un bien"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
