import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_dropdown_field.dart';
import 'package:wan_mobile/tools/widgets/c_outlined_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/static/don/edition_campagne/besoin_finance_campagne_page.dart';
import 'package:wan_mobile/views/static/don/edition_campagne/info_campagne_page.dart';

class EditionCampagnePage extends StatelessWidget {
  const EditionCampagnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ma campagne"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CButton(
          height: 50,
          onPressed: () {},
          child: const Text("Créer ma campagne"),
        ),
      ),
      body: PageView(
        children: [
          InfosCampagne(),
          BesoinFinanceCampagnePage(),
        ],
      ),
    );
  }
}
