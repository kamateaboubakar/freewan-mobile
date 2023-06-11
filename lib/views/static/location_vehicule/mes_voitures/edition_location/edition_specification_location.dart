import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_dropdown_field.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';

class EditionSpecificationLocation extends StatelessWidget {
  const EditionSpecificationLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Informations de la voiture"),
                  trailing: Text("2/2"),
                ),
                const Gap(20),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "Spécifications",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CDropdownField(
                        labelText: "Marque",
                        require: true,
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: CTextFormField(
                        labelText: "Moteur",
                        require: true,
                      ),
                    ),
                  ],
                ),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "Prix / Jour",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SwitchListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: AssetColors.grey4),
                  ),
                  value: false,
                  onChanged: (value) {},
                  title: const Text("Option chauffeur"),
                ),
                const Gap(10),
                CTextFormField(
                  labelText: "Prix avec chauffeur",
                  require: true,
                ),
                CTextFormField(
                  labelText: "Prix sans chauffeur",
                  require: true,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: CButton(
            minWidth: double.infinity,
            height: 50,
            onPressed: () {},
            child: const Text("Lister la voiture"),
          ),
        ),
      ],
    );
  }
}
