import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/models/don/campagne.dart';
import 'package:wan_mobile/views/controllers/donation/edition_donation_page_vctl.dart';
import 'package:wan_mobile/views/static/donation/edition_campagne/besoin_finance_campagne_page.dart';
import 'package:wan_mobile/views/static/donation/edition_campagne/info_campagne_page.dart';

class EditionCampagnePage extends StatelessWidget {
  final Campagne? campagne;
  const EditionCampagnePage({this.campagne, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditionDonationVctl>(
        init: EditionDonationVctl(editedItem: campagne),
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
