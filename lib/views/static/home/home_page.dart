import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:wan_mobile/tools/widgets/card_menu.dart';
import 'package:wan_mobile/tools/widgets/container_menu.dart';
import 'package:wan_mobile/tools/widgets/grid_menu.dart';
import 'package:wan_mobile/tools/widgets/pageable_menu.dart';
import 'package:wan_mobile/views/controllers/home/home_page_vctl.dart';
import 'package:wan_mobile/views/static/home/sub_home_page/categorized_home.dart';
import 'package:wan_mobile/views/static/home/home_drawer.dart';
import 'package:wan_mobile/views/static/home/sub_home_page/more_option_home_page.dart';
import 'package:wan_mobile/views/static/mall/mall_page.dart';
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
        return Scaffold(
          backgroundColor: Colors.blue.shade50,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leadingWidth: 45,
            // backgroundColor: AssetColors.blue,
            // foregroundColor: Colors.white,
            foregroundColor: AssetColors.blue,
            backgroundColor: Colors.transparent,
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
              width: 130,
              height: 110,
              // color: Colors.white,
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
                    onPressed: () => Get.to(() => const NotificationListPage()),
                    icon: const Icon(IcoFontIcons.notification),
                  ),
                ),
              )
            ],
          ),
          drawer: HomeDrawer(ctl),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 77,
                  margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade50,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.grey.shade50,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.grey.shade100,
                        spreadRadius: .3,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Row(
                          children: ctl.routes
                              .routesByList(menus: [
                                MenuButtonEnum.cartesBancaires,
                                MenuButtonEnum.transfertArgent,
                              ])
                              .map(
                                (e) => Expanded(
                                  child: e.button.copyWith(
                                    iconBackgroundColor: Colors.transparent,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const Gap(85),
                      Expanded(
                        child: Row(
                          children: ctl.routes
                              .routesByList(menus: [
                                MenuButtonEnum.ticketBus,
                                MenuButtonEnum.retraitArgent,
                              ])
                              .map(
                                (e) => Expanded(
                                  child: Center(
                                    child: e.button.copyWith(
                                      iconBackgroundColor: Colors.transparent,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, 1),
                child: SizedBox(
                  width: 85,
                  height: 85,
                  child: FittedBox(
                    child: FloatingActionButton(
                      shape: const CircleBorder(
                        side: BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
                      elevation: 0,
                      backgroundColor: AssetColors.blue,
                      onPressed: () {
                        var page = Get.currentRoute;
                        Get.to(() => ScanPayCamera(page));
                      },
                      child: Image.asset(
                        "assets/images/icons/scan_float_button.png",
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SizedBox.expand(
            child: Stack(
              children: [
                SizedBox(
                  height: Get.height * 0.4,
                  child: Image.asset(
                    "assets/images/pub_lbd.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                DraggableScrollableSheet(
                  snap: true,
                  initialChildSize: 0.645,
                  minChildSize: 0.645,
                  maxChildSize: .88,
                  builder: (context, scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
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
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                                bottom: 130,
                              ),
                              controller: scrollController,
                              child: Column(
                                children: [
                                  ImageSlideBanner(
                                    height: 130,
                                    images: ctl.ads
                                        .where((e) => e.categorie == "main")
                                        .toList(),
                                  ),
                                  const Gap(20),
                                  CardMenu(
                                    title: "Transactions",
                                    children: ctl.routes
                                        .routesByList(menus: [
                                          MenuButtonEnum.retraitArgent,
                                          MenuButtonEnum.paiementsAchats,
                                          MenuButtonEnum.depotArgent,
                                          MenuButtonEnum.transfertArgent,
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
                                  GridMenu(
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                    padding: const EdgeInsets.all(3),
                                    backgroundColor: Colors.blue.shade100,
                                    title: "Cartes & comptes",
                                    listController: scrollController,
                                    menus: ctl.routes
                                        .routesByList(menus: [
                                          MenuButtonEnum.comptesBancaires,
                                          MenuButtonEnum.cartesBancaires,
                                          MenuButtonEnum.commanderCarteCredit,
                                          MenuButtonEnum.cartesVirtuelles,
                                        ])
                                        .map((e) => e.button)
                                        .toList(),
                                    children: ctl.ads
                                        .where((e) => e.categorie == "pret")
                                        .map(
                                          (e) => ImageBanner(image: e),
                                        )
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
                                          MenuButtonEnum.materiauxConstruction,
                                          MenuButtonEnum.fraisScolarite,
                                          MenuButtonEnum.loyer,
                                        ])
                                        .map((e) => e.button)
                                        .toList()
                                      ..add(
                                        ButtonMenu(
                                          title: "Voir plus",
                                          icon: const CircleAvatar(
                                            child: Icon(Icons.arrow_forward),
                                          ),
                                          onPressed: () => Get.to(
                                            () => const MoreOptionHomePage(
                                              groupeTitle: "Centres d'intérêts",
                                              menus: {
                                                MenuButtonEnum.jobs,
                                                MenuButtonEnum.pharmacie,
                                                MenuButtonEnum.brasserie,
                                                MenuButtonEnum.caves,
                                                MenuButtonEnum.parisSportifs,
                                                MenuButtonEnum.achatPass,
                                                MenuButtonEnum.achatUnite,
                                                MenuButtonEnum
                                                    .locationVehicules,
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                  ),
                                  const Gap(10),
                                  GridMenu(
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                    padding: const EdgeInsets.all(3),
                                    backgroundColor: Colors.blue.shade100,
                                    title: "Gagnez de l'argent avec la Lonaci",
                                    trailing: Image.asset(
                                      "assets/images/42ba0891133d09b46e2edd0537c2f2265350876d-1.png",
                                      width: 120,
                                    ),
                                    listController: scrollController,
                                    menus: ctl.routes
                                        .routesByList(menus: [
                                          MenuButtonEnum.pmu,
                                          MenuButtonEnum.sportCash,
                                          MenuButtonEnum.lotoBonheur,
                                          MenuButtonEnum.casinoCash,
                                          MenuButtonEnum.virtualGames,
                                        ])
                                        .map(
                                          (e) => e.button
                                              .copyWith(displayName: false),
                                        )
                                        .toList(),
                                    children: ctl.ads
                                        .where((e) => e.categorie == "lonaci")
                                        .map(
                                          (e) => ImageBanner(image: e),
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
                                          MenuButtonEnum.guideUrbain,
                                        ])
                                        .map((e) => e.button)
                                        .toList(),
                                  ),
                                  const Gap(20),
                                  GridMenu(
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                    padding: const EdgeInsets.all(3),
                                    backgroundColor: Colors.blue.shade100,
                                    title: "Gagnez de l'argent avec Lebedoo",
                                    listController: scrollController,
                                    menus: ctl.routes
                                        .routesByList(menus: [
                                          MenuButtonEnum.oneXBet,
                                          MenuButtonEnum.premierBet,
                                          MenuButtonEnum.betclic,
                                        ])
                                        .map(
                                          (e) => e.button
                                              .copyWith(displayName: false),
                                        )
                                        .toList(),
                                    children: ctl.ads
                                        .where((e) =>
                                            e.categorie == "lebedoo-paris")
                                        .map(
                                          (e) => ImageBanner(image: e),
                                        )
                                        .toList(),
                                  ),
                                  const Gap(20),
                                  CardMenu(
                                    title: "E-Gov",
                                    children: ctl.routes
                                        .routesByList(menus: [
                                          MenuButtonEnum.paiementTimbres,
                                          MenuButtonEnum.paimenentTaxes,
                                          MenuButtonEnum.paiementContravention,
                                        ])
                                        .map((e) => e.button)
                                        .toList(),
                                  ),
                                  const Gap(20),
                                  CardMenu(
                                    title: "Factures et abonnements",
                                    children: ctl.routes
                                        .routesByList(menus: [
                                          MenuButtonEnum.factureElectricite,
                                          MenuButtonEnum.factureEau,
                                          MenuButtonEnum.abonnementTele,
                                          MenuButtonEnum.abonnementFibre,
                                          MenuButtonEnum.abonnementPeage,
                                          MenuButtonEnum.abonnementTele,
                                        ])
                                        .map((e) => e.button)
                                        .toList(),
                                  ),
                                  const Gap(20),
                                  GridMenu(
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                    padding: const EdgeInsets.all(3),
                                    backgroundColor: Colors.blue.shade100,
                                    title: "Divertissement",
                                    listController: scrollController,
                                    menus: ctl.routes
                                        .routesByList(menus: [
                                          MenuButtonEnum.tickets,
                                          MenuButtonEnum.evenements,
                                        ])
                                        .map((e) => e.button)
                                        .toList(),
                                    children: ctl.ads
                                        .where(
                                          (e) => e.categorie == "en_affiche",
                                        )
                                        .map(
                                          (e) => Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: ImageBanner(image: e),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  const Gap(20),
                                  GridMenu(
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      childAspectRatio: .9,
                                      padding: const EdgeInsets.all(3),
                                      backgroundColor: Colors.blue.shade100,
                                      title: "Voyages",
                                      crossAxisCount: 3,
                                      width: 350,
                                      listController: scrollController,
                                      menus: ctl.routes
                                          .routesByList(
                                            menus: [
                                              MenuButtonEnum.ticketBus,
                                              MenuButtonEnum.ticketBateauBus,
                                              MenuButtonEnum.billetAvion,
                                              MenuButtonEnum.ticketCar,
                                              MenuButtonEnum.hotels,
                                            ],
                                          )
                                          .map((e) => e.button)
                                          .toList(),
                                      children: ctl.ads
                                          .where((e) =>
                                              e.categorie ==
                                              "reservation_billet")
                                          .map((e) => Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: ImageBanner(image: e),
                                              ))
                                          .toList()),
                                  const Gap(20),
                                  ImageSlideBanner(
                                    images: ctl.ads
                                        .where(
                                            (e) => e.categorie == "image_bas")
                                        .toList(),
                                  ),
                                  ContainerMenu(
                                    padding: EdgeInsets.zero,
                                    externalTitle: "Lebedoo Mall",
                                    child: GestureDetector(
                                      onTap: () =>
                                          Get.to(() => const MallPage()),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          "assets/images/5594188.jpg",
                                          height: 200,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              const AutoSizeText(
                                                "Invitez vos amis sur ${Const.appName} "
                                                "et profitez de pleins de récompenses !",
                                                textAlign: TextAlign.center,
                                                maxLines: 4,
                                                minFontSize: 15,
                                                maxFontSize: 20,
                                              ),
                                              const Gap(10),
                                              CButton(
                                                borderRadius: 20,
                                                color: AssetColors.blue,
                                                onPressed: () =>
                                                    ctl.shareAppText(
                                                        codeParrain: ctl
                                                            .appCtl
                                                            .user
                                                            .ownerCode
                                                            .value),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.share),
                                                    Gap(10),
                                                    Text("Inviter un ami"),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Lottie.asset(
                                          "assets/lotties/animation_lmw1phml.json",
                                        ),
                                      )
                                    ],
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
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
