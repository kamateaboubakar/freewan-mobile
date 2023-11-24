import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:wan_mobile/views/controllers/donation/donation_page_vctl.dart';
import 'package:wan_mobile/views/static/donation/campagne_list_page.dart';
import 'package:wan_mobile/views/static/donation/edition_campagne/edition_campagne_page.dart';
import 'package:wan_mobile/views/static/donation/organisation/organisation_page.dart';
import 'package:wan_mobile/views/static/donation/user_campagne_page.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DonationPageVctl>(
        init: DonationPageVctl(),
        builder: (ctl) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Campagnes'),
                bottom: const TabBar(
                    indicatorColor: AssetColors.blue,
                    indicatorWeight: 3,
                    labelColor: AssetColors.blue,
                    unselectedLabelColor: Colors.black,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    tabs: [
                      Tab(text: "Tout"),
                      Tab(text: "Mes campagnes"),
                    ]),
                actions: [
                  IconButton(
                    onPressed: () => Get.to(() => const OrganisationPage()),
                    icon: const Icon(Icons.group),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: AssetColors.blueButton,
                onPressed: () => Get.to(() => const EditionCampagnePage()),
                child: const Icon(Icons.add),
              ),
              body: TabBarView(children: [
                DonationListPage(ctl),
                UserCampagnePage(ctl),
              ]),
            ),
          );
        });
  }
}
