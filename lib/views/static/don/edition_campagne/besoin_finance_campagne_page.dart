import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';

class BesoinFinanceCampagnePage extends StatelessWidget {
  const BesoinFinanceCampagnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Besoins en financement",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AssetColors.blue,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Ces informations permettront aux donateurs"
            " de mieux comprendre votre campagne",
            style: TextStyle(
              fontSize: 13,
              color: AssetColors.blue,
            ),
          ),
          const SizedBox(height: 20),
          const CTextFormField(
            labelText: "Montant demandé",
            require: true,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AssetColors.grey5,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                SwitchListTile(
                    title: const Text("Délai"),
                    value: true,
                    onChanged: (value) {}),
                const SizedBox(height: 20),
                CTextFormField(
                  suffixIcon: Icon(Icons.calendar_month),
                  labelText: "Date butoire",
                  require: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
