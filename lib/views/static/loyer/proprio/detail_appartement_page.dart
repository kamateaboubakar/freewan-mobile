import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_dropdown_field.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';

import '../../../../tools/utils/asset_colors.dart';

class DetailAppartementPage extends StatelessWidget {
  const DetailAppartementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un appartement"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SizedBox(
            // height: 200,
            child: Column(
              children: [
                const Text(
                  "RSA09",
                  style: TextStyle(
                    color: Color.fromRGBO(242, 153, 74, 1),
                    fontSize: 36,
                  ),
                ),
                const Text(
                  "Code de maison",
                  style: TextStyle(
                    color: Color.fromRGBO(242, 153, 74, 1),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: CButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                      side: const BorderSide(
                        color: AssetColors.blueButton,
                      ),
                    ),
                    color: Colors.transparent,
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.share),
                        SizedBox(width: 5),
                        Text("Partager code"),
                      ],
                    ),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const CTextFormField(
            labelText: "Numéro d’appartement",
            initialValue: "A09",
          ),
          const CDropdownField(
            labelText: "Type d’appartement",
          ),
          const CDropdownField(
            labelText: "Bloc d’apparts",
          ),
          const CTextFormField(
            labelText: "Loyer",
            initialValue: "80 000",
          ),
          CTextFormField(
            labelText: "Date de paiement",
            suffixIcon: const Icon(Icons.calendar_month),
            initialValue: DateTime.now().toFrenchDate,
            onTap: () async {
              var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(3000));
            },
          ),
          const CTextFormField(
            labelText: "Nom du Locataire",
            initialValue: "Moliere Koffi",
          ),
          const CTextFormField(
            labelText: "Numéro du Locataire",
            initialValue: "07 07 45 75 63",
          ),
          const SizedBox(height: 20),
          CButton(
            height: 50,
            onPressed: () => Get.back(),
            child: const Text("Ajouter cet appart"),
          ),
        ],
      ),
    );
  }
}
