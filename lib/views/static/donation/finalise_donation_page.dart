import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools/types/int.dart';
import 'package:wan_mobile/models/don/campagne.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/toggle_button_widget/c_toggle_button.dart';
import 'package:wan_mobile/tools/widgets/toggle_button_widget/toggle_item.dart';
import 'package:wan_mobile/views/controllers/donation/finalise_donation_page_vctl.dart';

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
              child: Visibility(
                visible: ctl.montant.value > 0,
                child: CButton(
                  height: 50,
                  onPressed: ctl.submit,
                  child: Text("Donner ${ctl.montant.toAmount()}"),
                ),
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
                    CToggleButton<int>(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      items: <ToggleItem<int>>[
                        ToggleItem(
                          selected: ctl.montant == 1000,
                          label: "F 1 000",
                          fontSize: 20,
                          value: 1000,
                        ),
                        ToggleItem(
                          selected: ctl.montant == 5000,
                          label: "F 5 000",
                          fontSize: 20,
                          value: 5000,
                        ),
                        ToggleItem(
                          selected: ctl.montant == 10000,
                          label: "F 10 000",
                          fontSize: 20,
                          value: 10000,
                        ),
                      ],
                      onItemSelected: (index, value) {
                        ctl.montant = value;
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
