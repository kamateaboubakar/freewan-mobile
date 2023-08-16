import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/tontine/tontine.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:module_master/module_master.dart';

import 'package:wan_mobile/tools/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/views/controllers/tontine/tontine_liste_page_vctl.dart';
import 'package:wan_mobile/views/static/tontine/edition_tontine_page.dart';

class TontineListePage extends StatelessWidget {
  final TontineListePageVctl ctl;
  const TontineListePage(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: ctl.tontines.isNotEmpty,
        child: FloatingActionButton(
          onPressed: () => Get.to(() => const EditionTontinePage()),
          backgroundColor: AssetColors.blue,
          child: const Icon(Icons.add),
        ),
      ),
      body: WrapperBodyListView(
        loading: false,
        emptyWidget: Image.asset("assets/images/empty_tontine.png"),
        emptyText: "Aucune tontine",
        onRefresh: () => Future.value(),
        refreshButton: COutlinedButton(
          borderRadius: 9,
          onPressed: () =>
              Get.to(() => const EditionTontinePage())?.then((value) {
            ctl.tontines.add(Tontine(
              label: "Tontine Projet",
              nbParticipants: 1,
              montant: 50000,
            ));
            ctl.update();
          }),
          textColor: AssetColors.blue,
          icon: const Icon(Icons.add),
          child: const Text("Créer une tontine"),
        ),
        listPadding: const EdgeInsets.all(20),
        children: ctl.tontines
            .map(
              (e) => ListTile(
                leading: Image.asset("assets/images/Vector.png",
                    width: 21, height: 16),
                title: Text(e.label.value),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${e.nbParticipants} participants",
                      style: const TextStyle(
                        color: AssetColors.grey4,
                      ),
                    ),
                    Text("${e.montant} F / pers"),
                  ],
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
