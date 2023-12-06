import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:wan_mobile/tools/widgets/card_menu.dart';
import 'package:wan_mobile/tools/widgets/pageable_menu.dart';
import 'package:wan_mobile/tools/widgets/pub_banner.dart';
import 'package:wan_mobile/tools/widgets/wallet_card.dart';
import 'package:wan_mobile/views/controllers/home/home_page_vctl.dart';
import 'package:wan_mobile/views/controllers/recevoir_paiement/code_qr_generator_vctl.dart';
import 'package:wan_mobile/views/static/home/categorized_home.dart';
import 'package:wan_mobile/views/static/home/home_drawer.dart';
import 'package:wan_mobile/views/static/home/messagerie/messagerie_page.dart';
import 'package:wan_mobile/views/static/notification/notification_list_page.dart';
import 'package:wan_mobile/views/static/scan_pay/scan_pay_camera.dart';
import 'package:wan_mobile/views/tools/menu_button_enum.dart';

class HomePage extends StatelessWidget {
  final bool displayWelcome;

  const HomePage({this.displayWelcome = false, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageVctl>(
      init: HomePageVctl(displayWelcome),
      builder: (ctl) {
        return PageView(
          physics: const BouncingScrollPhysics(),
          controller: ctl.pageViewCtl,
          children: [
            Scaffold(
              backgroundColor: AssetColors.blue,
              appBar: AppBar(
                leadingWidth: 45,
                backgroundColor: AssetColors.blue,
                foregroundColor: Colors.white,
                leading: Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: const Icon(IcoFontIcons.navigationMenu),
                    ),
                  );
                }),
                title: Image.asset(
                  Const.inLineAppLogo,
                  width: 100,
                  height: 80,
                  color: Colors.white,
                ),
                actions: [
                  IconButton(
                    iconSize: 20,
                    splashRadius: 20,
                    onPressed: () => Get.to(() => const CategorizedHome()),
                    icon: const Icon(IcoFontIcons.search1),
                  ),
                  Obx(
                    () => Badge(
                      isLabelVisible: ctl.appCtl.notifAccount.value > 0,
                      label: Text(ctl.appCtl.notifAccount.value.toString()),
                      offset: const Offset(-5, 5),
                      child: IconButton(
                        splashRadius: 20,
                        onPressed: () =>
                            Get.to(() => const NotificationListPage()),
                        icon: const Icon(IcoFontIcons.notification),
                      ),
                    ),
                  )
                ],
              ),
              drawer: HomeDrawer(ctl),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: AnimatedContainer(
                height: 60,
                duration: const Duration(milliseconds: 100),
                child: Obx(() {
                  if (ctl.isScrolling.value) {
                    return FloatingActionButton(
                      backgroundColor: AssetColors.blue,
                      isExtended: true,
                      onPressed: () {
                        var page = Get.currentRoute;
                        Get.to(() => ScanPayCamera(page));
                      },
                      child: Image.asset(
                        "assets/images/icons/scan_float_button.png",
                        width: 20,
                        height: 20,
                      ),
                    );
                  } else {
                    return FloatingActionButton.extended(
                      backgroundColor: AssetColors.blue,
                      onPressed: () {
                        var page = Get.currentRoute;
                        Get.to(() => ScanPayCamera(page));
                      },
                      label: const Text(
                        "Scan Any QR",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      icon: Image.asset(
                        "assets/images/icons/scan_float_button.png",
                        width: 20,
                        height: 20,
                      ),
                    );
                  }
                }),
              ),
              body: SizedBox.expand(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification.metrics.axis == Axis.vertical) {
                      if (notification is UserScrollNotification) {
                        if (!ctl.isScrolling.value) {
                          ctl.isScrolling.value = true;
                        }
                      } else if (notification is ScrollEndNotification) {
                        if (ctl.isScrolling.value) {
                          Future.delayed(const Duration(seconds: 1))
                              .then((value) {
                            ctl.isScrolling.value = false;
                          });
                        }
                      }
                    }
                    return true;
                  },
                  child: Stack(
                    children: [
                      GetBuilder<CodeQRGeneratorVctl>(
                          init: CodeQRGeneratorVctl(),
                          builder: (rCtl) {
                            return WalletCard(
                              qrData: rCtl.qrData.value,
                              hideAmount: ctl.hideAmount,
                              onHideAmount: () {
                                ctl.hideAmount = !ctl.hideAmount;
                                ctl.update();
                              },
                            );
                          }),
                      DraggableScrollableSheet(
                        snap: true,
                        initialChildSize: 0.60,
                        minChildSize: 0.60,
                        maxChildSize: 1,
                        builder: (context, scrollController) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 4,
                                    top: 14,
                                  ),
                                  height: 8,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: RefreshIndicator(
                                    onRefresh: ctl.getPubs,
                                    child: SingleChildScrollView(
                                      padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 130,
                                      ),
                                      controller: scrollController,
                                      child: Column(
                                        children: [
                                          Visibility(
                                            visible: ctl.ads
                                                .where((e) =>
                                                    e.categorie == "main")
                                                .isNotEmpty,
                                            child: Container(
                                              height: 160,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  width: .1,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              child: PubBanner(
                                                pubs: ctl.ads
                                                    .where((e) =>
                                                        e.categorie == "main")
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                          const Gap(20),
                                          CardMenu(
                                            title: "Transactions",
                                            children: ctl.routes
                                                .routesByList(menus: [
                                                  MenuButtonEnum.retraitArgent,
                                                  MenuButtonEnum
                                                      .paiementsAchats,
                                                  MenuButtonEnum.depotArgent,
                                                  MenuButtonEnum
                                                      .transfertArgent,
                                                ])
                                                .map((e) => e.button)
                                                .toList(),
                                          ),
                                          const Gap(20),
                                          PageableMenu(
                                            title: "Transactions reccurentes",
                                            children: [
                                              ButtonMenu(
                                                icon: Image.asset(
                                                    "assets/images/icons/tv.png"),
                                                title: "Abonnement\ntélé",
                                                onPressed: () {},
                                              ),
                                              ButtonMenu(
                                                icon: Image.asset(
                                                    "assets/images/icons/gain.png"),
                                                title: "Retraits d'argent",
                                                onPressed: () {},
                                              ),
                                              ButtonMenu(
                                                icon: Image.asset(
                                                    "assets/images/icons/depense.png"),
                                                title: "Paiements",
                                                onPressed: () {},
                                              ),
                                              ButtonMenu(
                                                icon: Image.asset(
                                                    "assets/images/icons/Canal.png"),
                                                title: "Canal+",
                                                onPressed: () {},
                                              ),
                                              ButtonMenu(
                                                icon: Image.asset(
                                                    "assets/images/icons/wallet_to_bank.png"),
                                                title: "Wallet To Bank",
                                                onPressed: () {},
                                              ),
                                            ],
                                          ),
                                          const Gap(20),
                                          CardMenu(
                                            title: "Cartes & comptes",
                                            children: ctl.routes
                                                .routesByList(menus: [
                                                  MenuButtonEnum
                                                      .comptesBancaires,
                                                  MenuButtonEnum
                                                      .cartesBancaires,
                                                ])
                                                .map((e) => e.button)
                                                .toList(),
                                          ),
                                          const Gap(20),
                                          CardMenu(
                                            title: "Centres d’intérêts",
                                            children: ctl.routes
                                                .routesByList(menus: [
                                                  MenuButtonEnum.gabAProximite,
                                                  MenuButtonEnum.restaurant,
                                                  MenuButtonEnum.gaz,
                                                  MenuButtonEnum.pressing,
                                                  MenuButtonEnum
                                                      .materiauxConstruction,
                                                  MenuButtonEnum.fraisScolarite,
                                                  MenuButtonEnum.loyer,
                                                  MenuButtonEnum.jobs,
                                                  MenuButtonEnum.pharmacie,
                                                  MenuButtonEnum.brasserie,
                                                  MenuButtonEnum.caves,
                                                  MenuButtonEnum.parisSportifs,
                                                  MenuButtonEnum.achatPass,
                                                  MenuButtonEnum.achatUnite,
                                                  MenuButtonEnum
                                                      .locationVehicules,
                                                ])
                                                .map((e) => e.button)
                                                .toList(),
                                          ),
                                          const Gap(20),
                                          PubBanner(
                                            pubs: ctl.ads
                                                .where(
                                                  (e) =>
                                                      e.categorie == "lonaci",
                                                )
                                                .toList(),
                                          ),
                                          const Gap(20),
                                          CardMenu(
                                            title: "Services innovants",
                                            children: ctl.routes
                                                .routesByList(menus: [
                                                  MenuButtonEnum.tontine,
                                                  MenuButtonEnum.dons,
                                                  MenuButtonEnum.cadeaux,
                                                  MenuButtonEnum.vouchers,
                                                  MenuButtonEnum.nounous,
                                                ])
                                                .map((e) => e.button)
                                                .toList(),
                                          ),
                                          const Gap(20),
                                          CardMenu(
                                            title: "E-Gov",
                                            children: ctl.routes
                                                .routesByList(menus: [
                                                  MenuButtonEnum
                                                      .paiementTimbres,
                                                  MenuButtonEnum.paimenentTaxes,
                                                  MenuButtonEnum
                                                      .paiementContravention,
                                                ])
                                                .map((e) => e.button)
                                                .toList(),
                                          ),
                                          const Gap(20),
                                          CardMenu(
                                            title: "Factures et abonnements",
                                            children: ctl.routes
                                                .routesByList(menus: [
                                                  MenuButtonEnum
                                                      .factureElectricite,
                                                  MenuButtonEnum.factureEau,
                                                  MenuButtonEnum.abonnementTele,
                                                  MenuButtonEnum
                                                      .abonnementFibre,
                                                  MenuButtonEnum
                                                      .abonnementPeage,
                                                  MenuButtonEnum.abonnementTele,
                                                ])
                                                .map((e) => e.button)
                                                .toList(),
                                          ),
                                          const Gap(20),
                                          CardMenu(
                                            title: "Divertissement",
                                            children: ctl.routes
                                                .routesByList(menus: [
                                                  MenuButtonEnum.tickets,
                                                  MenuButtonEnum.evenements,
                                                ])
                                                .map((e) => e.button)
                                                .toList(),
                                          ),
                                          const Gap(20),
                                          PubBanner(
                                            pubs: ctl.ads
                                                .where(
                                                  (e) =>
                                                      e.categorie ==
                                                      "en_affiche",
                                                )
                                                .toList(),
                                          ),
                                          const Gap(20),
                                          CardMenu(
                                            title: "Voyage",
                                            children: ctl.routes
                                                .routesByList(
                                                  menus: [
                                                    MenuButtonEnum.ticketBus,
                                                    MenuButtonEnum.ticketTrain,
                                                    MenuButtonEnum.billetAvion,
                                                    MenuButtonEnum.hotels,
                                                  ],
                                                )
                                                .map((e) => e.button)
                                                .toList(),
                                          ),
                                          const Gap(20),
                                          PubBanner(
                                            pubs: ctl.ads
                                                .where((e) =>
                                                    e.categorie == "pub_bas")
                                                .toList(),
                                          ),
                                          const ListTile(
                                            title: Text(
                                              "${Const.appName} © 2023 - V${Const.appVersion}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black26,
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
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            MessageriePages(ctl.pageViewCtl),
          ],
        );
      },
    );
  }
}
