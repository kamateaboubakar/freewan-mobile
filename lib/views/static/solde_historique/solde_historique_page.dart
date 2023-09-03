import 'package:flutter/material.dart';
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
              title: const Text("Solde historique"),
            ),
            body: Column(
              children: [
                // Container(
                //   padding: const EdgeInsets.all(10),
                //   height: 250,
                //   color: AssetColors.blue,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Card(
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Image.asset(
                //                   "assets/images/icons/depense.png",
                //                   width: 35,
                //                 ),
                //                 const Gap(15),
                //                 const Text(
                //                   "Mes dépenses",
                //                   style: TextStyle(
                //                     fontSize: 25,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                 ),
                //                 const Gap(10),
                //                 ListTile(
                //                   contentPadding: EdgeInsets.zero,
                //                   title: Text(
                //                     1500.toAmount(),
                //                     style: const TextStyle(
                //                       fontSize: 25,
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.red,
                //                     ),
                //                   ),
                //                 ),
                //                 const Gap(10),
                //                 const Text(
                //                   "Transactions et achats",
                //                   style: TextStyle(
                //                     fontSize: 20,
                //                     color: Colors.black45,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //       const Gap(10),
                //       Expanded(
                //         child: Card(
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Image.asset("assets/images/icons/gain.png",
                //                     width: 35),
                //                 const Gap(15),
                //                 const Text(
                //                   "Mes gains",
                //                   style: TextStyle(
                //                     fontSize: 25,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                 ),
                //                 const Gap(10),
                //                 ListTile(
                //                   contentPadding: EdgeInsets.zero,
                //                   title: Text(
                //                     20000.toAmount(),
                //                     style: const TextStyle(
                //                       fontSize: 25,
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.green,
                //                     ),
                //                   ),
                //                 ),
                //                 const Gap(10),
                //                 const Text(
                //                   "Dépôts et ventes",
                //                   style: TextStyle(
                //                     fontSize: 20,
                //                     color: Colors.black45,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const ListTile(
                  title: Text(
                    "Transactions récentes",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: WrapperBodyListView(
                    loading: ctl.loading,
                    onRefresh: ctl.getTransactions,
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
                ),
              ],
            ),
          );
        });
  }
}
