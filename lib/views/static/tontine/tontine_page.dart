import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/views/controllers/tontine/tontine_liste_page_vctl.dart';
import 'package:wan_mobile/views/static/tontine/historique_tontine_page.dart';
import 'package:wan_mobile/views/static/tontine/tontine_liste_page.dart';

class TontinePage extends StatelessWidget {
  const TontinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tontines"),
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
                Tab(text: "Tontines"),
                Tab(text: "Historique"),
              ]),
        ),
        body: GetBuilder<TontineListePageVctl>(
            init: TontineListePageVctl(),
            builder: (ctl) {
              return TabBarView(children: [
                TontineListePage(ctl),
                HistoriqueTontinePage(ctl),
              ]);
            }),
      ),
    );
  }
}
