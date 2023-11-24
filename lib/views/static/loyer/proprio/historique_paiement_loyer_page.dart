import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tools_flutter_project/tools/types/double.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:tools_flutter_project/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/views/controllers/loyer/historique_paiement_loyer_page_vctl.dart';

class HistoriquePaiementLoyerPage extends StatelessWidget {
  final int habitatId;
  const HistoriquePaiementLoyerPage(this.habitatId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique de paiement"),
      ),
      body: GetBuilder<HistoriquePaiementLoyerPageVctl>(
          init: HistoriquePaiementLoyerPageVctl(habitatId),
          builder: (ctl) {
            return WrapperBodyListView(
              onRefresh: ctl.fetchPaiements,
              loading: ctl.loading,
              children: ctl.paiements
                  .map(
                    (e) => ListTile(
                      leading: Image.asset(
                        "assets/images/icons/icons8-paiement-96.png",
                        height: 40,
                      ),
                      title: Text(e.montant.toAmount()),
                      subtitle: Row(
                        children: [
                          Expanded(
                            child: Text(
                              e.date.toDateTime().toFrenchDateTime,
                            ),
                          ),
                          Text("${e.mois}/${e.annee}")
                        ],
                      ),
                    ),
                  )
                  .toList(),
            );
          }),
    );
  }
}
