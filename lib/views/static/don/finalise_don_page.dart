import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:text_divider/text_divider.dart';
import 'package:wan_mobile/models/don/don.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/tools/widgets/toggle_button_widget/c_toggle_button.dart';
import 'package:wan_mobile/tools/widgets/toggle_button_widget/toggle_item.dart';
import 'package:wan_mobile/views/static/bills/bills_views.dart';

class FinaliseDonPage extends StatelessWidget {
  final Don don;
  const FinaliseDonPage(this.don, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Don'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CButton(
          height: 50,
          onPressed: () => Get.to(() => const PaiementModePaiement()),
          child: const Text("Donner"),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 283,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  don.image.value,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 25),
            CToggleButton(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              items: const [
                ToggleItem(label: "F 1 000"),
                ToggleItem(label: "F 5 000"),
                ToggleItem(label: "F 10 000"),
              ],
              onItemSelected: (index) {},
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
            const CTextFormField(labelText: "Entrez Don Manuellement"),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                tileColor: const Color.fromRGBO(237, 242, 249, 1),
                title: const Text(
                  "Utiliser ce moyen de paiement",
                  style: TextStyle(
                    color: Color.fromRGBO(72, 76, 79, 1),
                    fontSize: 15,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Image.asset(
                      "assets/images/master_card.png",
                      width: 45,
                      height: 45,
                    ),
                    const Text(
                      "**** **** **** 8357",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Color.fromRGBO(7, 21, 60, 1),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
