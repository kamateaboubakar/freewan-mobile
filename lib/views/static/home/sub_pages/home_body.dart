import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:wan_mobile/tools/widgets/card_menu.dart';
import 'package:wan_mobile/tools/widgets/container_menu.dart';
import 'package:wan_mobile/tools/widgets/grid_menu.dart';
import 'package:wan_mobile/tools/widgets/pageable_menu.dart';
import 'package:wan_mobile/views/controllers/home/home_page_vctl.dart';
import 'package:wan_mobile/views/static/home/cross_home_page/more_option_home_page.dart';
import 'package:wan_mobile/views/static/mall/mall_page.dart';
import 'package:wan_mobile/views/routes/menu_button_enum.dart';

class HomeBody extends StatelessWidget {
  final HomePageVctl ctl;
  const HomeBody(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
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
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
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
                                  icon:
                                      Image.asset("assets/images/icons/tv.png"),
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
                                          MenuButtonEnum.locationVehicules,
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
                              crossAxisCount: 3,
                              menus: ctl.routes
                                  .routesByList(menus: [
                                    MenuButtonEnum.pmu,
                                    MenuButtonEnum.sportCash,
                                    MenuButtonEnum.lotoBonheur,
                                    MenuButtonEnum.casinoCash,
                                    MenuButtonEnum.virtualGames,
                                    MenuButtonEnum.oneXBet,
                                    MenuButtonEnum.premierBet,
                                    MenuButtonEnum.betclic,
                                  ])
                                  .map(
                                    (e) =>
                                        e.button.copyWith(displayName: false),
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
                                    MenuButtonEnum.coursesChevauxLebedoo,
                                    MenuButtonEnum.casinoLebedoo,
                                    MenuButtonEnum.parisFootBallLebedoo,
                                    MenuButtonEnum.rouletteLebedoo,
                                  ])
                                  .map((e) => e.button)
                                  .toList(),
                              children: ctl.ads
                                  .where((e) => e.categorie == "lebedoo-paris")
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
                                      padding: const EdgeInsets.only(right: 20),
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
                                        e.categorie == "reservation_billet")
                                    .map((e) => Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: ImageBanner(image: e),
                                        ))
                                    .toList()),
                            const Gap(20),
                            ImageSlideBanner(
                              images: ctl.ads
                                  .where((e) => e.categorie == "image_bas")
                                  .toList(),
                            ),
                            ContainerMenu(
                              padding: EdgeInsets.zero,
                              child: GestureDetector(
                                onTap: () => Get.to(() => const MallPage()),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    "assets/images/lebedoo_mall.jpeg",
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.contain,
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
                                          "🚀 Profitez de tous les avantages "
                                          "de ${Const.appName} avec vos amis 🎉✨.",
                                          textAlign: TextAlign.center,
                                          maxLines: 4,
                                          minFontSize: 15,
                                          maxFontSize: 20,
                                        ),
                                        const Gap(10),
                                        CButton(
                                          borderRadius: 20,
                                          color: AssetColors.blue,
                                          onPressed: () => ctl.shareAppText(
                                              codeParrain: ctl
                                                  .appCtl.user.ownerCode.value),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/icons/partager.png",
                                                width: 20,
                                                color: Colors.white,
                                              ),
                                              // Icon(Icons.share),
                                              const Gap(10),
                                              const Text("Inviter un ami"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Lottie.asset(
                                      "assets/lotties/animation_lmw1phml.json"),
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
    );
  }
}
