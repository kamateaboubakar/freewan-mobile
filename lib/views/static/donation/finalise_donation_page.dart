import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_divider/text_divider.dart';
import 'package:wan_mobile/models/don/campagne.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/tools/widgets/toggle_button_widget/c_toggle_button.dart';
import 'package:wan_mobile/tools/widgets/toggle_button_widget/toggle_item.dart';
import 'package:wan_mobile/views/controllers/donation/finalise_donation_page_vctl.dart';
import 'package:wan_mobile/views/static/paiement/paiement_mode_paiement.dart';

class FinaliseDonPage extends StatelessWidget {
  final Campagne don;
  const FinaliseDonPage(this.don, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FinaliseDonPageVctl>(
        init: FinaliseDonPageVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(title: const Text('Don')),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20),
              child: CButton(
                height: 50,
                onPressed: () => Get.to(
                  () => PaiementModePaiement(
                    route: Get.currentRoute,
                    motifPaiement: "Paiement pour don",
                    frais: 0,
                    montant: ctl.montant,
                    service: "Don",
                  ),
                ),
                child: const Text("Donner"),
              ),
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 283,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          don.imageUrl.value,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    CToggleButton(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      items: [
                        ToggleItem(
                          selected: ctl.selectedIndexSomme == 0,
                          label: "F 1 000",
                          fontSize: 20,
                        ),
                        ToggleItem(
                          selected: ctl.selectedIndexSomme == 1,
                          label: "F 5 000",
                          fontSize: 20,
                        ),
                        ToggleItem(
                          selected: ctl.selectedIndexSomme == 2,
                          label: "F 10 000",
                          fontSize: 20,
                        ),
                      ],
                      onItemSelected: (index) {
                        ctl.selectedIndexSomme = index;
                        ctl.update();
                      },
                    ),
                    const SizedBox(height: 25),
                    TextDivider.horizontal(
                      text: const Text(
                        'OU',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: AssetColors.grey4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    CTextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      labelText: "Entrez Don Manuellement",
                      onChanged: (value) {
                        ctl.montant = value.toInt();
                        ctl.update();
                      },
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
