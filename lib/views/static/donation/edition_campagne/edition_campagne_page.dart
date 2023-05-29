import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/don/categorie_donation.dart';
import 'package:wan_mobile/models/don/organization.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_dropdown_field.dart';
import 'package:wan_mobile/tools/widgets/c_outlined_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/donation/edition_donation_page_vctl.dart';
import 'package:wan_mobile/views/static/donation/edition_campagne/besoin_finance_campagne_page.dart';
import 'package:wan_mobile/views/static/donation/edition_campagne/info_campagne_page.dart';

class EditionCampagnePage extends StatelessWidget {
  final List<CategorieDonation> categories;

  const EditionCampagnePage(this.categories, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditionDonationVctl>(
        init: EditionDonationVctl(categories),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Ma campagne"),
            ),
            body: PageView(
              controller: ctl.pageCtl,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                InfosCampagne(ctl),
                BesoinFinanceCampagnePage(ctl),
              ],
            ),
          );
        });
  }
}
