import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:tools_flutter_project/tools/types/double.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/models/loyer/abstracts/bloc_appartement.dart';
import 'package:wan_mobile/models/loyer/appartement.dart';

import 'package:wan_mobile/views/controllers/loyer/detail_bloc_appartement_page_vctl.dart';
import 'package:wan_mobile/views/static/loyer/proprio/form_edition_appartement.dart';
import 'package:wan_mobile/views/static/loyer/proprio/historique_paiement_loyer_page.dart';

class DetailBlocAppartementPage extends StatelessWidget {
  final BlocAppartement blocAppartement;
  const DetailBlocAppartementPage(this.blocAppartement, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailBlocAppartementPageVctl>(
        init: DetailBlocAppartementPageVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: Text(blocAppartement.libelle.value),
            ),
            body: (blocAppartement.appartements.isEmpty)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/icons/empty_folder.png",
                          height: 200,
                        ),
                        const SizedBox(height: 20),
                        const Text("Aucun appartement"),
                      ],
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        separatorBuilder: (context, i) => const Divider(),
                        itemCount: blocAppartement.appartements.length,
                        itemBuilder: (context, i) {
                          var appart = blocAppartement.appartements[i];
                          return MaterialButton(
                            padding: const EdgeInsets.all(5),
                            onPressed: () => Get.to(() =>
                                FormEditionAppartement(
                                    item: appart,
                                    bloc: blocAppartement))?.then((value) {
                              if (value is Appartement) {
                                appart = value;
                                ctl.update();
                              }
                            }),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: Image.asset(
                                    "assets/images/icons/immeuble.png",
                                    width: 45,
                                    height: 65,
                                  ),
                                  title: Text(
                                    "Appartement ${appart.numeroAppartement.value}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${appart.typeAppartement?.libelle.value}(${appart.loyer.toAmount()})",
                                    style: const TextStyle(
                                      color: Color.fromRGBO(123, 131, 160, 1),
                                      fontSize: 13,
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  ),
                                ),
                                MaterialButton(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  color: Colors.blue.shade100,
                                  onPressed: () => Get.to(() =>
                                      HistoriquePaiementLoyerPage(appart.id!)),
                                  child: const Text(
                                    "Voir l'historique des paiements",
                                    style: TextStyle(
                                      color: AssetColors.blueButton,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [

                      //     const Divider(),
                      //     MaterialButton(
                      //       padding: const EdgeInsets.all(5),
                      //       onPressed: () {},
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           ListTile(
                      //             leading: Image.asset(
                      //               "assets/images/icons/immeuble.png",
                      //               width: 45,
                      //               height: 65,
                      //             ),
                      //             title: const Text(
                      //               "Appartement A11",
                      //               style: TextStyle(
                      //                 fontSize: 18,
                      //               ),
                      //             ),
                      //             subtitle: const Text(
                      //               "Studio(80 000 FCFA)",
                      //               style: TextStyle(
                      //                 color: Color.fromRGBO(123, 131, 160, 1),
                      //                 fontSize: 13,
                      //               ),
                      //             ),
                      //             trailing: const Icon(
                      //               Icons.arrow_forward_ios,
                      //               size: 15,
                      //             ),
                      //           ),
                      //           Container(
                      //             padding: const EdgeInsets.all(10),
                      //             decoration: BoxDecoration(
                      //               color: const Color.fromRGBO(226, 220, 255, 1),
                      //               borderRadius: BorderRadius.circular(7),
                      //             ),
                      //             child: const Text(
                      //               "Paiement dû le 5 Mai 2023",
                      //               style: TextStyle(
                      //                 color: AssetColors.blueButton,
                      //                 fontSize: 12,
                      //               ),
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //     const Divider(),
                      //     MaterialButton(
                      //       padding: const EdgeInsets.all(5),
                      //       onPressed: () {},
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           ListTile(
                      //             leading: Image.asset(
                      //               "assets/images/icons/immeuble.png",
                      //               width: 45,
                      //               height: 65,
                      //             ),
                      //             title: const Text(
                      //               "Appartement A11",
                      //               style: TextStyle(
                      //                 fontSize: 18,
                      //               ),
                      //             ),
                      //             subtitle: const Text(
                      //               "Studio(80 000 FCFA)",
                      //               style: TextStyle(
                      //                 color: Color.fromRGBO(123, 131, 160, 1),
                      //                 fontSize: 13,
                      //               ),
                      //             ),
                      //             trailing: const Icon(
                      //               Icons.arrow_forward_ios,
                      //               size: 15,
                      //             ),
                      //           ),
                      //           Container(
                      //             padding: const EdgeInsets.all(10),
                      //             decoration: BoxDecoration(
                      //               color: const Color.fromRGBO(20, 181, 58, 0.28),
                      //               borderRadius: BorderRadius.circular(7),
                      //             ),
                      //             child: const Text(
                      //               "Loyer Payé",
                      //               style: TextStyle(
                      //                 color: Color.fromRGBO(0, 133, 63, 1),
                      //                 fontSize: 12,
                      //               ),
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
          );
        });
  }
}
