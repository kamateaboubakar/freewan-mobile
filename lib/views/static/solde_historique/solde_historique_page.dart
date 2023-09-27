import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/views/controllers/solde_historique/solde_historique_page_vctl.dart';

class SoldeHistoriquePage extends StatelessWidget {
  const SoldeHistoriquePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SoldeHistoriquePageVctl>(
        init: SoldeHistoriquePageVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 45,
              backgroundColor: Colors.transparent,
              title: const Text("Solde & historique"),
            ),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 210,
                  color: AssetColors.blue,
                  child: ImageSlideshow(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/icons/depense.png",
                                      width: 35,
                                    ),
                                    const Gap(15),
                                    const Text(
                                      "Total",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Gap(10),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        ctl.totalDepense.toAmount(),
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset("assets/images/icons/gain.png",
                                        width: 35),
                                    const Gap(15),
                                    const Text(
                                      "Mois en cours",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Gap(10),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        ctl.getTotalUserCurrentMonth(),
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/icons/depense.png",
                                      width: 35,
                                    ),
                                    const Gap(15),
                                    const Text(
                                      "Total par Carte Bancaire",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Gap(10),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        ctl.getTotalUserCB(),
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset("assets/images/icons/gain.png",
                                        width: 35),
                                    const Gap(15),
                                    const Text(
                                      "Total par Mobile Money",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Gap(10),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        ctl.getTotalUserMM(),
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const ListTile(
                  title: Text(
                    "Historique des transactions",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 4,
                    child: Column(
                      children: [
                        const TabBar(
                            isScrollable: true,
                            labelColor: AssetColors.blueButton,
                            tabs: [
                              Tab(child: Text("Récents")),
                              Tab(child: Text("Mensuel")),
                              Tab(child: Text("Par service")),
                              Tab(child: Text("Par mode paiement")),
                            ]),
                        Expanded(
                          child: TabBarView(
                            children: [
                              WrapperBodyListView(
                                listPadding: const EdgeInsets.all(10),
                                loading: ctl.loading,
                                onRefresh: ctl.getData,
                                children: ctl.transactions
                                    .map(
                                      (e) => ListTile(
                                        leading: Image.asset(
                                          "assets/images/icons/historique_transaction.png",
                                          width: 20,
                                        ),
                                        title: Text(
                                          e.libele.value,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                e.amount.value.toAmount(),
                                              ),
                                            ),
                                            Text(e.createdAt.value
                                                .toDateTime()
                                                .toFrenchDateTime),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              WrapperBodyListView(
                                listPadding: const EdgeInsets.all(10),
                                loading: ctl.mthloading,
                                onRefresh: ctl.getUserPerMonth,
                                children: ctl.statPerMonth
                                    .map(
                                      (e) => ListTile(
                                        leading: Image.asset(
                                          "assets/images/icons/historique_transaction.png",
                                          width: 20,
                                        ),
                                        title: Text(
                                          e.getPeriodLabel,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        subtitle:
                                            Text(e.totalAmount.toAmount()),
                                      ),
                                    )
                                    .toList(),
                              ),
                              WrapperBodyListView(
                                listPadding: const EdgeInsets.all(10),
                                loading: ctl.serviceloading,
                                onRefresh: ctl.getUserPerService,
                                children: ctl.statPerService
                                    .map(
                                      (e) => ListTile(
                                        leading: Image.asset(
                                          "assets/images/icons/historique_transaction.png",
                                          width: 20,
                                        ),
                                        title: Text(
                                          e.service.value,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        subtitle:
                                            Text(e.totalAmount.toAmount()),
                                      ),
                                    )
                                    .toList(),
                              ),
                              WrapperBodyListView(
                                listPadding: const EdgeInsets.all(10),
                                loading: ctl.modePaiementLoading,
                                onRefresh: ctl.getUserPerModePaiement,
                                children: ctl.statPerModePaiement
                                    .map(
                                      (e) => ListTile(
                                        leading: Image.asset(
                                          "assets/images/icons/historique_transaction.png",
                                          width: 20,
                                        ),
                                        title: Text(
                                          e.getModeLabel,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        subtitle:
                                            Text(e.totalAmount.toAmount()),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
