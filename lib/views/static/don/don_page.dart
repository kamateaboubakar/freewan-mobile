import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/views/controllers/don/don_page_vctl.dart';
import 'package:wan_mobile/views/static/don/don_list_page.dart';
import 'package:wan_mobile/views/static/don/user_campagne_page.dart';

class DonPage extends StatelessWidget {
  const DonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DonPageVctl>(
        init: DonPageVctl(),
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
              ),
              body: TabBarView(children: [
                DonListPage(ctl),
                UserCampagnePage(ctl),
              ]),
            ),
          );
        });
  }
}
