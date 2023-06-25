import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/loyer/abstracts/bloc_appartement.dart';
import 'package:wan_mobile/models/loyer/maison.dart';
import 'package:wan_mobile/tools/widgets/loyer/bloc_appart_list_tile.dart';
import 'package:wan_mobile/tools/widgets/loyer/maison_list_tile.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/views/controllers/loyer/bien_immobilier_page_vctl.dart';
import 'package:wan_mobile/views/static/loyer/proprio/detail_bloc_appartement_page.dart';
import 'package:wan_mobile/views/static/loyer/proprio/edition_maison_form.dart';
import 'package:wan_mobile/views/static/loyer/proprio/form_edition_appartement.dart';
import 'package:wan_mobile/views/static/loyer/proprio/form_edition_bien_immobilier.dart';

import '../../../../tools/utils/asset_colors.dart';

class BienImmobilierPage extends StatelessWidget {
  const BienImmobilierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BienImmobilierPageVctl>(
        init: BienImmobilierPageVctl(),
        builder: (ctl) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  title: const Text("Bien Immobilier"),
                  bottom: const TabBar(
                    labelColor: AssetColors.blueButton,
                    indicatorColor: AssetColors.blueButton,
                    tabs: [
                      Tab(text: "Maisons"),
                      Tab(text: "Blocs d'apparts"),
                    ],
                  ),
                ),
                floatingActionButton: SpeedDial(
                  backgroundColor: AssetColors.blueButton,
                  elevation: 0,
                  children: [
                    SpeedDialChild(
                      label: "Appartement",
                      onTap: () => Get.to(() => const FormEditionAppartement()),
                      child: const Icon(Icons.add),
                    ),
                    SpeedDialChild(
                      label: "Maison",
                      onTap: () => Get.to(
                        () => const FormEditionBienImmobilier(isMaison: true),
                      )?.then((value) {
                        if (value is Maison) {
                          ctl.maisons.add(value);
                          ctl.update();
                        }
                      }),
                      child: const Icon(Icons.add),
                    ),
                    SpeedDialChild(
                      label: "Bloc d’apparts",
                      onTap: () => Get.to(
                        () => const FormEditionBienImmobilier(isMaison: false),
                      )?.then((value) {
                        if (value is BlocAppartement) {
                          ctl.blocAppartements.add(value);
                          ctl.update();
                        }
                      }),
                      child: const Icon(Icons.add),
                    ),
                  ],
                  child: const Icon(Icons.add),
                ),
                body: TabBarView(
                  children: [
                    WrapperBodyListView(
                      listPadding: const EdgeInsets.all(10),
                      onRefresh: ctl.fetchMaisons,
                      emptyWidget: Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Image.asset(
                          "assets/images/icons/empty_folder.png",
                          width: 200,
                        ),
                      ),
                      loading: ctl.loadMaisons,
                      children: ctl.maisons
                          .map(
                            (e) => MaisonListTile(
                              e,
                              onPressed: () =>
                                  Get.to(() => EditionMaisonForm(e))
                                      ?.then((value) {
                                if (value is Maison) {
                                  e = value;
                                  ctl.update();
                                }
                              }),
                            ),
                          )
                          .toList(),
                    ),
                    WrapperBodyListView(
                      listPadding: const EdgeInsets.all(10),
                      loading: ctl.loadBloc,
                      onRefresh: ctl.fetchBlockApparts,
                      emptyWidget: Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Image.asset(
                          "assets/images/icons/empty_folder.png",
                          width: 200,
                        ),
                      ),
                      children: ctl.blocAppartements
                          .map(
                            (e) => BlocAppartementListTile(
                              e,
                              onPressed: () =>
                                  Get.to(() => DetailBlocAppartementPage(e)),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                )
                // (ctl.immobiliers.isNotEmpty)
                //     ? RefreshIndicator(
                //         onRefresh: ctl.fetchBiens,
                //         child: ListView(
                //           padding: const EdgeInsets.all(10),
                //           children: ctl.immobiliers
                //               .map(
                //                 (e) =>
                // MaterialButton(
                //                   onPressed: () =>
                //                       Get.to(() => const DetailImmobilierPage()),
                //                   child: Row(
                //                     crossAxisAlignment: CrossAxisAlignment.center,
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       Image.asset(
                //                         (e.isMaison)
                //                             ? "assets/images/icons/maison.png"
                //                             : "assets/images/icons/immeuble.png",
                //                         width: 45,
                //                         height: 65,
                //                       ),
                //                       Expanded(
                //                         child: Padding(
                //                           padding: const EdgeInsets.symmetric(
                //                             horizontal: 12,
                //                             vertical: 10,
                //                           ),
                //                           child: Column(
                //                             crossAxisAlignment:
                //                                 CrossAxisAlignment.start,
                //                             children: [
                //                               Text(
                //                                 e.libelle.value,
                //                                 style: const TextStyle(
                //                                   fontSize: 18,
                //                                 ),
                //                               ),
                //                               const SizedBox(height: 2),
                //                               Text(
                //                                 e.lieu.value,
                //                                 style: const TextStyle(
                //                                   fontSize: 12,
                //                                 ),
                //                               ),
                //                               const SizedBox(height: 5),
                //                               (e.isMaison)
                //                                   ? const SizedBox.shrink()
                //                                   : Text(
                //                                       "${e.appartements!.length} appartements",
                //                                       style: const TextStyle(
                //                                         fontSize: 15,
                //                                         color: Color.fromRGBO(
                //                                             71, 36, 251, 1),
                //                                       ),
                //                                     ),
                //                             ],
                //                           ),
                //                         ),
                //                       ),
                //                       const Center(
                //                         child: Icon(
                //                           Icons.arrow_forward_ios,
                //                           size: 15,
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               )
                //               .toList(),
                //         ),
                //       )
                //     : Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 90),
                //         child: Center(
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Image.asset("assets/images/icons/empty_folder.png"),
                //               const SizedBox(height: 11),
                //               const Text("Aucun bien ajouté",
                //                   style: TextStyle(fontSize: 20)),
                //               const SizedBox(height: 14),
                //               CButton(
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(9),
                //                   side: const BorderSide(
                //                     color: AssetColors.blueButton,
                //                   ),
                //                 ),
                //                 color: Colors.transparent,
                //                 textColor: AssetColors.blueButton,
                //                 onPressed: ctl.fetchBiens,
                //                 child: const Text("Actualiser"),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                ),
          );
        });
  }
}
