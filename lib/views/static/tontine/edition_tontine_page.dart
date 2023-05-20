import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_dropdown_field.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/tools/widgets/toggle_button_widget/c_toggle_button.dart';
import 'package:wan_mobile/tools/widgets/toggle_button_widget/toggle_item.dart';
import 'package:wan_mobile/views/controllers/tontine/edition_tontine_page_vctl.dart';
import 'package:wan_mobile/views/static/tontine/tontine_success_creation_page.dart';

class EditionTontinePage extends StatelessWidget {
  const EditionTontinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditionTontinePageVctl>(
        init: EditionTontinePageVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(title: const Text("Ma tontine")),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20),
              child: CButton(
                height: 50,
                onPressed: () =>
                    Get.off(() => const TontineSuccessCreationPage()),
                child: const Text("Créer tontine"),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Informations sur la tontine",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const CTextFormField(
                    labelText: "Nom du groupe",
                    require: true,
                  ),
                  const CTextFormField(
                    labelText: "Montant total à contribuer",
                    require: true,
                  ),
                  const CDropdownField(
                    labelText: "Méthode de reversement",
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Versements",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 17),
                    child: CToggleButton(
                      crossAxisSpacing: 20,
                      onItemSelected: (index) {
                        ctl.selectedVersement = index;
                        ctl.update();
                      },
                      crossAxisCount: 3,
                      items: [
                        ToggleItem(
                          selected: ctl.selectedVersement == 0,
                          label: "Une fois par semaine",
                        ),
                        ToggleItem(
                          selected: ctl.selectedVersement == 1,
                          label: "Une fois chaque jour",
                        ),
                        ToggleItem(
                          selected: ctl.selectedVersement == 2,
                          label: "1 fois par mois",
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "Délai de contribution",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 17),
                    child: (ctl.selectedVersement == 2)
                        ? const CTextFormField(
                            labelText: "Date butoire",
                            suffixIcon: Icon(Icons.calendar_month),
                          )
                        : CToggleButton(
                            crossAxisSpacing: 13,
                            childAspectRatio: 0.4,
                            onItemSelected: (index) {
                              ctl.selectedDelaiContr = index;
                              ctl.update();
                            },
                            crossAxisCount: 7,
                            items: [
                              ToggleItem(
                                selected: ctl.selectedDelaiContr == 0,
                                label: "Lun",
                              ),
                              ToggleItem(
                                selected: ctl.selectedDelaiContr == 1,
                                label: "Mar",
                              ),
                              ToggleItem(
                                selected: ctl.selectedDelaiContr == 2,
                                label: "Mer",
                              ),
                              ToggleItem(
                                selected: ctl.selectedDelaiContr == 3,
                                label: "Jeu",
                              ),
                              ToggleItem(
                                selected: ctl.selectedDelaiContr == 4,
                                label: "Ven",
                              ),
                              ToggleItem(
                                selected: ctl.selectedDelaiContr == 5,
                                label: "Sam",
                              ),
                              ToggleItem(
                                selected: ctl.selectedDelaiContr == 6,
                                label: "Dim",
                              ),
                            ],
                          ),
                  ),
                  const Text(
                    "*Chaque participant contribuera chaque jour, une petite "
                    "partie du montant pendant les 30 prochains jours",
                    style: TextStyle(
                      fontSize: 11,
                      color: AssetColors.green,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
