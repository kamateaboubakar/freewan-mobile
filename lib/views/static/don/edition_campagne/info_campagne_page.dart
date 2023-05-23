import 'package:flutter/material.dart';

import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_dropdown_field.dart';
import 'package:wan_mobile/tools/widgets/c_outlined_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';

class InfosCampagne extends StatelessWidget {
  const InfosCampagne({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Informations de la campagne",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Ces informations permettront aux donateurs de"
                " mieux comprendre votre campagne",
                style: TextStyle(
                  fontSize: 13,
                  color: AssetColors.blue,
                ),
              ),
              const SizedBox(height: 20),
              const CTextFormField(
                labelText: "Titre de la campagne",
                require: true,
              ),
              const CDropdownField(
                labelText: "Catégorie",
                require: true,
              ),
              const CTextFormField(
                labelText: "Description",
                require: true,
                maxLines: 6,
              ),
              const SizedBox(height: 20),
              COutlinedButton(
                height: 50,
                textColor: AssetColors.blue,
                minWidth: double.infinity,
                icon: const Icon(Icons.add),
                onPressed: () {},
                child: const Text("Ajouter une image"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
