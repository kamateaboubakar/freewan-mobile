import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';
import 'package:get/get.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:wan_mobile/tools/widgets/card_menu.dart';
import 'package:wan_mobile/tools/widgets/single_child_card_menu.dart';
import 'package:wan_mobile/views/controllers/home/home_page_vctl.dart';
import 'package:wan_mobile/views/static/achat_unite/achat_unite_page.dart';
import 'package:wan_mobile/views/static/donation/donation_page.dart';
import 'package:wan_mobile/views/static/home/home_drawer.dart';
import 'package:wan_mobile/views/static/loyer/loyer_bottom_sheet.dart';
import 'package:wan_mobile/views/static/scan_pay/scan_pay_camera.dart';
import 'package:wan_mobile/views/static/tontine/tontine_page.dart';
import 'package:wan_mobile/views/static/tv_bills/tv_bills_selection_dialog.dart';

import '../bills/bills_views.dart';
import '../gaz/pages/gaz_map_page.dart';
import '../job/job_views.dart';

class HomePage extends StatelessWidget {
  final bool displayWelcome;

  const HomePage({this.displayWelcome = false, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageVctl>(
        init: HomePageVctl(displayWelcome),
        builder: (ctl) {
          return Scaffold(
            drawer: HomeDrawer(ctl),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: ScrollingFabAnimated(
              icon: Image.asset(
                "assets/images/icons/scan_float_button.png",
                width: 15,
                height: 15,
              ),
              color: AssetColors.blueButton,
              width: 180,
              height: 50,
              radius: 25,
              onPress: () => Get.to(() => const ScanPayCamera()),
              scrollController: ctl.scrollController,
              text: const Text(
                "Scanner & payer",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            body: CustomScrollView(
              controller: ctl.scrollController,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.white,
                  systemOverlayStyle: SystemUiOverlayStyle.light,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      "assets/images/pub_lbd.jpeg",
                      //"https://cdn.mos.cms.futurecdn.net/V6LCHNxfSPT2Sxpr4bAzD.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  leading: Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                      ),
                    );
                  }),
                  leadingWidth: 45,
                  foregroundColor: AssetColors.blue,
                  expandedHeight: 240,
                  title: Image.asset(
                    Const.inLineAppLogo,
                    width: 100,
                    height: 50,
                  ),
                  actions: [
                    IconButton(
                      iconSize: 20,
                      splashRadius: 20,
                      onPressed: () {},
                      icon: const Icon(IcoFontIcons.search),
                    ),
                    IconButton(
                      iconSize: 20,
                      splashRadius: 20,
                      onPressed: () {},
                      icon: const Icon(IcoFontIcons.uiMessaging),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: .1,
                              color: Colors.grey,
                            ),
                          ),
                          child: ImageSlideshow(
                            isLoop: true,
                            autoPlayInterval: 6000,
                            children: ctl.ads
                                .map(
                                  (e) => ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Image.network(e, fit: BoxFit.cover),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CardMenu(
                          title: "Hub Financier",
                          children: [
                            ButtonMenu(
                              icon: Image.asset(
                                "assets/images/icons8-envoyé.gif",
                                // "assets/images/icons/envoyer_mobile.png",
                              ),
                              title: "Envoyer vers mobile",
                              onPressed: () {},
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                "assets/images/icons8-tirelire.gif",
                                // "assets/images/icons/recevoir_argent.png",
                              ),
                              title: "Recevoir argent",
                              onPressed: () {},
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-échange-de-cartes.gif"
                                  // "assets/images/icons/transfert_banquaire.png",

                                  ),
                              title: "Transfert bancaire",
                              onPressed: () {},
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                "assets/images/icons/mon_bedoo.png",
                              ),
                              title: "Lebedoo",
                              onPressed: () {},
                            ),
                          ],
                        ),
                        CardMenu(
                          children: [
                            ButtonMenu(
                              icon: Image.asset(
                                "assets/images/icons/historique_transaction.png",
                              ),
                              title: "Solde et historique",
                              onPressed: () {},
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                "assets/images/icons/paiement_loyer.png",
                              ),
                              title: "Paiement Loyer",
                              onPressed: () => Tools.openBottomSheet(
                                  const LoyerBottomSheet()),
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                "assets/images/icons/paiement_assurance.png",
                              ),
                              title: "Paiement Assurances",
                              onPressed: () {},
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                "assets/images/icons8-mallette.gif",
                              ),
                              title: "Job",
                              onPressed: () {
                                Tools.openBottomSheet(
                                    const JobProfileSelectionDialog());
                              },
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                "assets/images/icons8-exchange-money-64.png",
                              ),
                              title: "Tontine",
                              onPressed: () =>
                                  Get.to(() => const TontinePage()),
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                "assets/images/icons8-confiance.gif",
                              ),
                              title: "Don",
                              onPressed: () =>
                                  Get.to(() => const DonationPage()),
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                "assets/images/icons8-durabilite.gif",
                              ),
                              title: "Gaz",
                              onPressed: () => Get.to(() => const GazMapPage()),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SingleChildCardMenu(
                                onTap: () {},
                                icon: Image.asset(
                                  "assets/images/icons/box_cadeau.png",
                                  height: 18,
                                  width: 18,
                                ),
                                title: "Partager et Gagner",
                                subtitle: "Récompenses garanties",
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: SingleChildCardMenu(
                                onTap: () {},
                                icon: Image.asset(
                                  "assets/images/icons/carte_virtuelle.png",
                                  height: 18,
                                  width: 18,
                                ),
                                title: "Carte Virtuelle",
                                subtitle: "Achetez sur sites ecommerce",
                              ),
                            ),
                          ],
                        ),
                        CardMenu(
                          title: "Recharges et Factures",
                          children: [
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons/achat_unite.png"),
                              title: "Achat d’unités",
                              onPressed: () =>
                                  Get.to(() => const AchatUnitePage()),
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons/acaht_data.png"),
                              title: "Achat de pass",
                              onPressed: () {},
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons/facture_electricite.png"),
                              title: "Facture d’électricité",
                              onPressed: () => Tools.openBottomSheet(
                                BillsCompanySelectionDialog(),
                              ),
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-entrepot-96.png"),
                              title: "CIE Prépayé",
                              onPressed: () {},
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons/abonnement_tele.png"),
                              title: "Abonnement\nTélé",
                              onPressed: () {
                                Tools.openBottomSheet(
                                    const TvBillsSelectionDialog());
                              },
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons/abonnement_payage.png"),
                              title: "Abonnement\nPéage",
                              onPressed: () {},
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons/abonnement_fibre.png"),
                              title: "Abonnement\nFibre",
                              onPressed: () {},
                            ),
                            ButtonMenu(
                              icon: const CircleAvatar(
                                backgroundColor:
                                    Color.fromRGBO(50, 132, 229, 0.16),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Color.fromRGBO(7, 21, 60, 1),
                                ),
                              ),
                              title: "Voir Plus",
                              onPressed: () {
                                //Tools.openBottomSheet(JobProfileSelectionDialog());
                              },
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Voyage • Allez où le vent vous emporte",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              height: 220,
                              margin:
                                  const EdgeInsets.only(bottom: 20, top: 10),
                              child: ListView(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    width: Get.width / 2,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: GridView.count(
                                        padding: const EdgeInsets.all(10),
                                        crossAxisCount: 2,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        children: [
                                          ButtonMenu(
                                            icon: Image.asset(
                                                "assets/images/icons8-cadeau.gif"),
                                            title: "Cadeau",
                                            onPressed: () {},
                                          ),
                                          ButtonMenu(
                                            icon: Image.asset(
                                                "assets/images/icons8-hôtel-5-étoiles-48.png"),
                                            title: "Hotels",
                                            onPressed: () {},
                                          ),
                                          ButtonMenu(
                                            icon: Image.asset(
                                                "assets/images/icons8-train-64.png"),
                                            title: "Billet de train",
                                            onPressed: () {},
                                          ),
                                          ButtonMenu(
                                            icon: Image.asset(
                                                "assets/images/icons8-avion-vue-de-face-64.png"),
                                            title: "Billet d'avion",
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    height: double.infinity,
                                    width: Get.width / 2,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "https://img.freepik.com/psd-premium/"
                                        "modele-publication-instagram-vacances-"
                                        "vacances-voyage-banniere-medias-sociaux_597327-466.jpg?w=1060",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    height: double.infinity,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "https://img.freepik.com/psd-gratuit/"
                                        "modele-facebook-journee-mondiale-du-"
                                        "tourisme-geometrique_23-2149558429.jpg"
                                        "?w=2000&t=st=1685113012~exp=1685113612~"
                                        "hmac=21b853d605686ae1bc072a02faa079e81d2"
                                        "adfa502e9b14add136e1f309ad5d6",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: 250,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              "https://img.freepik.com/vecteurs"
                                              "-libre/banniere-hotel-degrade-photo_23"
                                              "-2148918442.jpg?w=2000&t=st=1685113784~exp="
                                              "1685114384~hmac=46e4192837faef30051c4995031ae671"
                                              "c5620a08a9a50e1f5dc66bccb747ae8e",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Expanded(
                                        child: SizedBox(
                                          width: 250,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              "https://img.freepik.com/vecteurs"
                                              "-libre/banniere-hotel-design-plat-photo"
                                              "_23-2148924625.jpg?w=2000&t=st=1685114108~exp="
                                              "1685114708~hmac=e242529b9ce89cb11d3943609"
                                              "19049b396a44f3f40f18a1701bcedb802de0317",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        CardMenu(
                          children: [
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-cadeau.gif"),
                              title: "Cadeau",
                              onPressed: () {},
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-ticket.gif"),
                              title: "Ticket de cinéma",
                              onPressed: () {},
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-liquor-shelf-64.png"),
                              title: "Brasserie",
                              onPressed: () {},
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-assurance-64.png"),
                              title: "Assurance",
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
          // return Scaffold(
          //   drawer: HomeDrawer(ctl),
          //   backgroundColor: const Color.fromRGBO(182, 214, 232, 1.0),
          //   extendBodyBehindAppBar: true,
          //   appBar: AppBar(
          //     backgroundColor: Colors.transparent,
          //     leadingWidth: 50,
          //     toolbarHeight: 60,
          //     title: Image.asset(
          //       Const.inLineAppLogo,
          //       width: 120,
          //       height: 63,
          //     ),
          //     leading: Builder(builder: (context) {
          //       return GestureDetector(
          //         onTap: () => Scaffold.of(context).openDrawer(),
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: badges.Badge(
          //             position:
          //                 badges.BadgePosition.bottomEnd(bottom: 4, end: -2),
          //             badgeStyle: badges.BadgeStyle(
          //               badgeColor: Colors.grey.shade200,
          //             ),
          //             badgeContent:
          //                 const Icon(Icons.menu, color: Colors.black, size: 7),
          //             child: CircleAvatar(
          //               // radius: 30,
          //               backgroundColor: const Color.fromRGBO(219, 219, 219, 1),
          //               child: IconButton(
          //                 color: Colors.white,
          //                 splashRadius: 20,
          //                 icon: const Center(
          //                   child: Icon(Icons.person, size: 16),
          //                 ),
          //                 onPressed: () => Scaffold.of(context).openDrawer(),
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     }),
          //     actions: [
          //       IconButton(
          //         splashRadius: 20,
          //         onPressed: () {},
          //         icon: Image.asset(
          //           "assets/images/loupe.png",
          //           width: 25,
          //         ),
          //       ),
          //       IconButton(
          //         splashRadius: 20,
          //         onPressed: () {},
          //         icon: Image.asset(
          //           "assets/images/message.png",
          //           width: 25,
          //         ),
          //       ),
          //     ],
          //   ),
          //   floatingActionButtonLocation:
          //       FloatingActionButtonLocation.centerFloat,
          //   floatingActionButton: AnimatedContainer(
          //     duration: const Duration(milliseconds: 100),
          //     child: ctl.smallButton
          //         ? FloatingActionButton(
          //             backgroundColor: AssetColors.blueButton,
          //             isExtended: true,
          //             onPressed: () => Get.to(() => const ScanPayCamera()),
          //             child: Image.asset(
          //               "assets/images/icons/scan_float_button.png",
          //               width: 20,
          //               height: 20,
          //             ),
          //           )
          //         : FloatingActionButton.extended(
          //             backgroundColor: AssetColors.blueButton,
          //             onPressed: () => Get.to(() => const ScanPayCamera()),
          //             label: Image.asset(
          //               "assets/images/icons/scan_float_button.png",
          //               width: 20,
          //               height: 20,
          //             ),
          //             icon: const Text(
          //               "Scanner & payer",
          //               style: TextStyle(
          //                 fontWeight: FontWeight.w600,
          //               ),
          //             ),
          //           ),
          //   ),
          //   body: Stack(
          //     fit: StackFit.expand,
          //     children: [
          //       Shimmer.fromColors(
          //         baseColor: Colors.grey[300]!,
          //         highlightColor: Colors.grey[100]!,
          //         child: Container(
          //           color: Colors.white,
          //         ),
          //       ),
          //       SizedBox(
          //         height: 250,
          //         width: double.infinity,
          //         child: Stack(
          //           children: [
          //             Image.network(
          //               'https://cdn.mos.cms.futurecdn.net/V6LCHNxfSPT2Sxpr4bAzD.jpg',
          //               fit: BoxFit.fill,
          //             ),
          //           ],
          //         ),
          //       ),
          //       SlidingUpPanel(
          //         color: Colors.blue.shade50.withOpacity(.95),
          //         borderRadius:
          //             const BorderRadius.vertical(top: Radius.circular(10)),
          //         controller: ctl.panelController,
          //         maxHeight: Get.height,
          //         minHeight: Get.height / 1.5,
          //         panelBuilder: (scrollController) => Column(
          //           children: [
          //             Container(
          //               height: 5,
          //               width: 50,
          //               margin: const EdgeInsets.only(top: 10, bottom: 5),
          //               decoration: BoxDecoration(
          //                 color: Colors.grey,
          //                 borderRadius: BorderRadius.circular(10),
          //               ),
          //             ),
          //             Expanded(
          //               child: ListView(
          //                 padding: const EdgeInsets.all(10),
          //                 controller: scrollController,
          //                 children: [
          //                   Container(
          //                     height: 130,
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(10),
          //                       border: Border.all(
          //                         width: .1,
          //                         color: Colors.grey,
          //                       ),
          //                     ),
          //                     child: ImageSlideshow(
          //                       children: ctl.ads
          //                           .map(
          //                             (e) => ClipRRect(
          //                               borderRadius: BorderRadius.circular(10),
          //                               child: Stack(
          //                                 fit: StackFit.expand,
          //                                 children: [
          //                                   Shimmer.fromColors(
          //                                     baseColor: Colors.grey[300]!,
          //                                     highlightColor: Colors.grey[100]!,
          //                                     child: Container(
          //                                       color: Colors.white,
          //                                     ),
          //                                   ),
          //                                   Image.network(e, fit: BoxFit.cover),
          //                                 ],
          //                               ),
          //                             ),
          //                           )
          //                           .toList(),
          //                     ),
          //                   ),
          //                   const SizedBox(height: 20),
          //                   CardMenu(
          //                     title: "Hub Financier",
          //                     children: [
          //                       ButtonMenu(
          //                         icon: CircleAvatar(
          //                           backgroundColor: const Color.fromRGBO(
          //                               50, 132, 229, 0.16),
          //                           child: Image.asset(
          //                             "assets/images/icons/scan_pay.png",
          //                             height: 20,
          //                             width: 20,
          //                           ),
          //                         ),
          //                         title: "Scanner et payer",
          //                         onPressed: () =>
          //                             Get.to(() => const ScanPayCamera()),
          //                       ),
          //                       ButtonMenu(
          //                         icon: CircleAvatar(
          //                           backgroundColor: const Color.fromRGBO(
          //                               50, 132, 229, 0.16),
          //                           child: Image.asset(
          //                             "assets/images/icons/envoyer_mobile.png",
          //                             height: 20,
          //                             width: 20,
          //                           ),
          //                         ),
          //                         title: "Envoyer mobile",
          //                         onPressed: () {},
          //                       ),
          //                       ButtonMenu(
          //                         icon: CircleAvatar(
          //                           backgroundColor: const Color.fromRGBO(
          //                               50, 132, 229, 0.16),
          //                           child: Image.asset(
          //                               "assets/images/icons/recevoir_argent.png",
          //                               height: 20,
          //                               width: 20),
          //                         ),
          //                         title: "Recevoir argent",
          //                         onPressed: () {},
          //                       ),
          //                       ButtonMenu(
          //                         icon: Image.asset(
          //                           "assets/images/icons/transfert_banquaire.png",
          //                           height: 20,
          //                           width: 20,
          //                         ),
          //                         title: "Transfert bancaire",
          //                         onPressed: () {},
          //                       ),
          //                     ],
          //                   ),
          //                   CardMenu(
          //                     children: [
          //                       ButtonMenu(
          //                         icon: Image.asset(
          //                           "assets/images/icons/historique_transaction.png",
          //                         ),
          //                         title: "Historique Transactions",
          //                         onPressed: () {},
          //                       ),
          //                       ButtonMenu(
          //                         icon: Image.asset(
          //                           "assets/images/icons/mon_bedoo.png",
          //                         ),
          //                         title: "Mon Bédou",
          //                         onPressed: () {},
          //                       ),
          //                       ButtonMenu(
          //                         icon: Image.asset(
          //                           "assets/images/icons/paiement_loyer.png",
          //                         ),
          //                         title: "Paiement Loyer",
          //                         onPressed: () => Tools.openBottomSheet(
          //                             const LoyerBottomSheet()),
          //                       ),
          //                       ButtonMenu(
          //                         icon: Image.asset(
          //                           "assets/images/icons/paiement_assurance.png",
          //                         ),
          //                         title: "Paiement Assurances",
          //                         onPressed: () {},
          //                       ),
          //                       ButtonMenu(
          //                         icon: Image.asset(
          //                           "assets/images/icons8-mallette.gif",
          //                         ),
          //                         title: "Job",
          //                         onPressed: () {
          //                           Tools.openBottomSheet(
          //                               const JobProfileSelectionDialog());
          //                         },
          //                       ),
          //                       ButtonMenu(
          //                         icon: Image.asset(
          //                           "assets/images/icons8-exchange-money-64.png",
          //                         ),
          //                         title: "Tontine",
          //                         onPressed: () =>
          //                             Get.to(() => const TontinePage()),
          //                       ),
          //                       ButtonMenu(
          //                         icon: Image.asset(
          //                           "assets/images/icons8-confiance.gif",
          //                         ),
          //                         title: "Don",
          //                         onPressed: () =>
          //                             Get.to(() => const DonPage()),
          //                       ),
          //                       ButtonMenu(
          //                         icon: Image.asset(
          //                           "assets/images/icons8-durabilite.gif",
          //                         ),
          //                         title: "Gaz",
          //                         onPressed: () =>
          //                             Get.to(() => const GazMapPage()),
          //                       ),
          //                     ],
          //                   ),
          //                   Row(
          //                     children: [
          //                       Expanded(
          //                         child: SingleChildCardMenu(
          //                           onTap: () {},
          //                           icon: Image.asset(
          //                             "assets/images/icons/box_cadeau.png",
          //                             height: 18,
          //                             width: 18,
          //                           ),
          //                           title: "Partager et Gagner",
          //                           subtitle: "Récompenses garanties",
          //                         ),
          //                       ),
          //                       const SizedBox(width: 8),
          //                       Expanded(
          //                         child: SingleChildCardMenu(
          //                           onTap: () {},
          //                           icon: Image.asset(
          //                             "assets/images/icons/carte_virtuelle.png",
          //                             height: 18,
          //                             width: 18,
          //                           ),
          //                           title: "Carte Virtuelle",
          //                           subtitle: "Achetez sur sites ecommerce",
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                   CardMenu(
          //                     title: "Recharges et Factures",
          //                     children: [
          //                       ButtonMenu(
          //                         icon: Image.asset(
          //                             "assets/images/icons/achat_unite.png"),
          //                         title: "Achat d’unités",
          //                         onPressed: () =>
          //                             Get.to(() => const AchatUnitePage()),
          //                       ),
          //                       ButtonMenu(
          //                         icon: Image.asset(
          //                             "assets/images/icons/acaht_data.png"),
          //                         title: "Achat de pass",
          //                         onPressed: () {},
          //                       ),
          //                       ButtonMenu(
          //                         icon: Image.asset(
          //                             "assets/images/icons/facture_electricite.png"),
          //                         title: "Facture d’électricité",
          //                         onPressed: () => Tools.openBottomSheet(
          //                           BillsCompanySelectionDialog(),
          //                         ),
          //                       ),
          //                       ButtonMenu(
          //                         icon: Image.asset(
          //                             "assets/images/icons8-entrepot-96.png"),
          //                         title: "CIE Prépayé",
          //                         onPressed: () {},
          //                       ),
          //                       ButtonMenu(
          //                         icon: Image.asset(
          //                             "assets/images/icons/abonnement_tele.png"),
          //                         title: "Abonnement\nTélé",
          //                         onPressed: () {
          //                           Tools.openBottomSheet(
          //                               const TvBillsSelectionDialog());
          //                         },
          //                       ),
          //                       ButtonMenu(
          //                         icon: Image.asset(
          //                             "assets/images/icons/abonnement_payage.png"),
          //                         title: "Abonnement\nPéage",
          //                         onPressed: () {},
          //                       ),
          //                       ButtonMenu(
          //                         icon: Image.asset(
          //                             "assets/images/icons/abonnement_fibre.png"),
          //                         title: "Abonnement\nFibre",
          //                         onPressed: () {},
          //                       ),
          //                       ButtonMenu(
          //                         icon: const CircleAvatar(
          //                           backgroundColor:
          //                               Color.fromRGBO(50, 132, 229, 0.16),
          //                           child: Icon(
          //                             Icons.arrow_forward,
          //                             color: Color.fromRGBO(7, 21, 60, 1),
          //                           ),
          //                         ),
          //                         title: "Voir Plus",
          //                         onPressed: () {
          //                           //Tools.openBottomSheet(JobProfileSelectionDialog());
          //                         },
          //                       ),
          //                     ],
          //                   ),
          //                   const SizedBox(height: 100),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       )
          //       // DraggableScrollableSheet(
          //       //   controller: ctl.scrollController,
          //       //   initialChildSize: .75,
          //       //   minChildSize: .75,
          //       //   builder: (context, scrollController) => Container(
          //       //     decoration: const BoxDecoration(
          //       //       color: Colors.white,
          //       //       borderRadius: BorderRadius.only(
          //       //         topLeft: Radius.circular(20),
          //       //         topRight: Radius.circular(20),
          //       //       ),
          //       //     ),
          //       //     child: Column(
          //       //       children: [
          //       //         Container(
          //       //           height: 5,
          //       //           width: 50,
          //       //           margin: const EdgeInsets.only(top: 10, bottom: 5),
          //       //           decoration: BoxDecoration(
          //       //             color: Colors.grey,
          //       //             borderRadius: BorderRadius.circular(10),
          //       //           ),
          //       //         ),
          //       //         Expanded(
          //       //           child: ListView(
          //       //             padding: const EdgeInsets.all(10),
          //       //             physics: const BouncingScrollPhysics(),
          //       //             controller: scrollController,
          //       //             children: [
          //       //               CarouselSlider(
          //       //                 options: CarouselOptions(
          //       //                   height: 150,
          //       //                   onPageChanged:
          //       //                       (index, carouselPageChangedReason) {
          //       //                     ctl.currentAds = index;
          //       //                     ctl.update();
          //       //                   },
          //       //                 ),
          //       //                 items: ctl.ads.map((e) {
          //       //                   return Builder(
          //       //                     builder: (BuildContext context) {
          //       //                       return Container(
          //       //                         width:
          //       //                             MediaQuery.of(context).size.width,
          //       //                         margin: const EdgeInsets.symmetric(
          //       //                             horizontal: 5.0),
          //       //                         decoration: BoxDecoration(
          //       //                           borderRadius:
          //       //                               BorderRadius.circular(10),
          //       //                           border: Border.all(
          //       //                             width: .1,
          //       //                             color: Colors.grey,
          //       //                           ),
          //       //                         ),
          //       //                         child: ClipRRect(
          //       //                           borderRadius:
          //       //                               BorderRadius.circular(10),
          //       //                           child: Stack(
          //       //                             fit: StackFit.expand,
          //       //                             children: [
          //       //                               Shimmer.fromColors(
          //       //                                 baseColor: Colors.grey[300]!,
          //       //                                 highlightColor:
          //       //                                     Colors.grey[100]!,
          //       //                                 child: Container(
          //       //                                   color: Colors.white,
          //       //                                 ),
          //       //                               ),
          //       //                               Image.network(
          //       //                                 e,
          //       //                                 fit: BoxFit.fill,
          //       //                                 errorBuilder:
          //       //                                     (context, error, stack) =>
          //       //                                         Container(),
          //       //                               ),
          //       //                             ],
          //       //                           ),
          //       //                         ),
          //       //                       );
          //       //                     },
          //       //                   );
          //       //                 }).toList(),
          //       //               ),
          //       //               SizedBox(
          //       //                 height: 50,
          //       //                 child: Center(
          //       //                   child: AnimatedSmoothIndicator(
          //       //                     activeIndex: ctl.currentAds,
          //       //                     count: ctl.ads.length,
          //       //                     effect: const WormEffect(
          //       //                       activeDotColor: Const.primaryColor,
          //       //                       dotWidth: 10,
          //       //                       dotHeight: 10,
          //       //                     ),
          //       //                   ),
          //       //                 ),
          //       //               ),
          //       //               CardMenu(
          //       //                 title: "Hub Financier",
          //       //                 children: [
          //       //                   ButtonMenu(
          //       //                     icon: CircleAvatar(
          //       //                       backgroundColor: const Color.fromRGBO(
          //       //                           50, 132, 229, 0.16),
          //       //                       child: Image.asset(
          //       //                         "assets/images/icons/scan_pay.png",
          //       //                         height: 20,
          //       //                         width: 20,
          //       //                       ),
          //       //                     ),
          //       //                     title: "Scanner et payer",
          //       //                     onPressed: () =>
          //       //                         Get.to(() => const ScanPayCamera()),
          //       //                   ),
          //       //                   ButtonMenu(
          //       //                     icon: CircleAvatar(
          //       //                       backgroundColor: const Color.fromRGBO(
          //       //                           50, 132, 229, 0.16),
          //       //                       child: Image.asset(
          //       //                         "assets/images/icons/envoyer_mobile.png",
          //       //                         height: 20,
          //       //                         width: 20,
          //       //                       ),
          //       //                     ),
          //       //                     title: "Envoyer mobile",
          //       //                     onPressed: () {},
          //       //                   ),
          //       //                   ButtonMenu(
          //       //                     icon: CircleAvatar(
          //       //                       backgroundColor: const Color.fromRGBO(
          //       //                           50, 132, 229, 0.16),
          //       //                       child: Image.asset(
          //       //                           "assets/images/icons/recevoir_argent.png",
          //       //                           height: 20,
          //       //                           width: 20),
          //       //                     ),
          //       //                     title: "Recevoir argent",
          //       //                     onPressed: () {},
          //       //                   ),
          //       //                   ButtonMenu(
          //       //                     icon: Image.asset(
          //       //                       "assets/images/icons/transfert_banquaire.png",
          //       //                       height: 20,
          //       //                       width: 20,
          //       //                     ),
          //       //                     title: "Transfert bancaire",
          //       //                     onPressed: () {},
          //       //                   ),
          //       //                 ],
          //       //               ),
          //       //               CardMenu(
          //       //                 children: [
          //       //                   ButtonMenu(
          //       //                     icon: Image.asset(
          //       //                       "assets/images/icons/historique_transaction.png",
          //       //                     ),
          //       //                     title: "Historique Transactions",
          //       //                     onPressed: () {},
          //       //                   ),
          //       //                   ButtonMenu(
          //       //                     icon: Image.asset(
          //       //                       "assets/images/icons/mon_bedoo.png",
          //       //                     ),
          //       //                     title: "Mon Bédou",
          //       //                     onPressed: () {},
          //       //                   ),
          //       //                   ButtonMenu(
          //       //                     icon: Image.asset(
          //       //                       "assets/images/icons/paiement_loyer.png",
          //       //                     ),
          //       //                     title: "Paiement Loyer",
          //       //                     onPressed: () => Tools.openBottomSheet(
          //       //                         const LoyerBottomSheet()),
          //       //                   ),
          //       //                   ButtonMenu(
          //       //                     icon: Image.asset(
          //       //                       "assets/images/icons/paiement_assurance.png",
          //       //                     ),
          //       //                     title: "Paiement Assurances",
          //       //                     onPressed: () {},
          //       //                   ),
          //       //                   ButtonMenu(
          //       //                     icon: Image.asset(
          //       //                       "assets/images/icons8-mallette.gif",
          //       //                     ),
          //       //                     title: "Job",
          //       //                     onPressed: () {
          //       //                       Tools.openBottomSheet(
          //       //                           const JobProfileSelectionDialog());
          //       //                     },
          //       //                   ),
          //       //                   ButtonMenu(
          //       //                     icon: Image.asset(
          //       //                       "assets/images/icons8-exchange-money-64.png",
          //       //                     ),
          //       //                     title: "Tontine",
          //       //                     onPressed: () =>
          //       //                         Get.to(() => const TontinePage()),
          //       //                   ),
          //       //                   ButtonMenu(
          //       //                     icon: Image.asset(
          //       //                       "assets/images/icons8-confiance.gif",
          //       //                     ),
          //       //                     title: "Don",
          //       //                     onPressed: () =>
          //       //                         Get.to(() => const DonPage()),
          //       //                   ),
          //       //                   ButtonMenu(
          //       //                     icon: Image.asset(
          //       //                       "assets/images/icons8-durabilite.gif",
          //       //                     ),
          //       //                     title: "Gaz",
          //       //                     onPressed: () =>
          //       //                         Get.to(() => const GazMapPage()),
          //       //                   ),
          //       //                 ],
          //       //               ),
          //       //               Row(
          //       //                 children: [
          //       //                   Expanded(
          //       //                     child: SingleChildCardMenu(
          //       //                       onTap: () {},
          //       //                       icon: Image.asset(
          //       //                         "assets/images/icons/box_cadeau.png",
          //       //                         height: 18,
          //       //                         width: 18,
          //       //                       ),
          //       //                       title: "Partager et Gagner",
          //       //                       subtitle: "Récompenses garanties",
          //       //                     ),
          //       //                   ),
          //       //                   const SizedBox(width: 8),
          //       //                   Expanded(
          //       //                     child: SingleChildCardMenu(
          //       //                       onTap: () {},
          //       //                       icon: Image.asset(
          //       //                         "assets/images/icons/carte_virtuelle.png",
          //       //                         height: 18,
          //       //                         width: 18,
          //       //                       ),
          //       //                       title: "Carte Virtuelle",
          //       //                       subtitle: "Achetez sur sites ecommerce",
          //       //                     ),
          //       //                   ),
          //       //                 ],
          //       //               ),
          //       //               CardMenu(
          //       //                 title: "Recharges et Factures",
          //       //                 children: [
          //       //                   ButtonMenu(
          //       //                     icon: Image.asset(
          //       //                         "assets/images/icons/achat_unite.png"),
          //       //                     title: "Achat d’unités",
          //       //                     onPressed: () =>
          //       //                         Get.to(() => const AchatUnitePage()),
          //       //                   ),
          //       //                   ButtonMenu(
          //       //                     icon: Image.asset(
          //       //                         "assets/images/icons/acaht_data.png"),
          //       //                     title: "Achat de pass",
          //       //                     onPressed: () {},
          //       //                   ),
          //       //                   ButtonMenu(
          //       //                     icon: Image.asset(
          //       //                         "assets/images/icons/facture_electricite.png"),
          //       //                     title: "Facture d’électricité",
          //       //                     onPressed: () => Tools.openBottomSheet(
          //       //                       BillsCompanySelectionDialog(),
          //       //                     ),
          //       //                   ),
          //       //                   ButtonMenu(
          //       //                     icon: Image.asset(
          //       //                         "assets/images/icons8-entrepot-96.png"),
          //       //                     title: "CIE Prépayé",
          //       //                     onPressed: () {},
          //       //                   ),
          //       //                   ButtonMenu(
          //       //                     icon: Image.asset(
          //       //                         "assets/images/icons/abonnement_tele.png"),
          //       //                     title: "Abonnement\nTélé",
          //       //                     onPressed: () {
          //       //                       Tools.openBottomSheet(
          //       //                           const TvBillsSelectionDialog());
          //       //                     },
          //       //                   ),
          //       //                   ButtonMenu(
          //       //                     icon: Image.asset(
          //       //                         "assets/images/icons/abonnement_payage.png"),
          //       //                     title: "Abonnement\nPéage",
          //       //                     onPressed: () {},
          //       //                   ),
          //       //                   ButtonMenu(
          //       //                     icon: Image.asset(
          //       //                         "assets/images/icons/abonnement_fibre.png"),
          //       //                     title: "Abonnement\nFibre",
          //       //                     onPressed: () {},
          //       //                   ),
          //       //                   ButtonMenu(
          //       //                     icon: const CircleAvatar(
          //       //                       backgroundColor:
          //       //                           Color.fromRGBO(50, 132, 229, 0.16),
          //       //                       child: Icon(
          //       //                         Icons.arrow_forward,
          //       //                         color: Color.fromRGBO(7, 21, 60, 1),
          //       //                       ),
          //       //                     ),
          //       //                     title: "Voir Plus",
          //       //                     onPressed: () {
          //       //                       //Tools.openBottomSheet(JobProfileSelectionDialog());
          //       //                     },
          //       //                   ),
          //       //                 ],
          //       //               ),
          //       //             ],
          //       //           ),
          //       //         ),
          //       //       ],
          //       //     ),
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // );
        });
  }
}
