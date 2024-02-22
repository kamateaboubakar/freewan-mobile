import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/routes/groupe_route.dart';
import 'package:wan_mobile/routes/tools/actions/go_to_more_page_action.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:wan_mobile/tools/widgets/card_menu.dart';
import 'package:wan_mobile/tools/widgets/grid_menu.dart';
import 'package:wan_mobile/views/controllers/home/home_page_vctl.dart';
import 'package:wan_mobile/views/static/home/sub_pages/transaction_recurrente_section.dart';
import 'package:wan_mobile/views/static/mall/mall_page.dart';
import 'package:lebedoo_assets/const/feature_dictionnary.dart';

class HomeBody extends StatelessWidget {
  final HomePageVctl ctl;
  const HomeBody(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          SizedBox(
            height: (Get.height * 0.4).sp,
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
                              title: GroupeRoute.transactions,
                              children: ctl.routes
                                  .routesByList(menus: {
                                    // FeatureDictionnary.retraitArgent,
                                    FeatureDictionnary.paiementsAchats,
                                    FeatureDictionnary.depotArgent,
                                    FeatureDictionnary.transfertArgent,
                                    FeatureDictionnary.historiqueTransactions,
                                  })
                                  .map((e) => e.button)
                                  .toList(),
                            ),
                            const Gap(20),
                            TransactionRecurrenteSection(ctl.routes),
                            GridMenu(
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: .95,
                              crossAxisCount: 3,
                              padding: const EdgeInsets.all(3),
                              backgroundColor: Colors.blue.shade100,
                              title: GroupeRoute.cartesEtComptes,
                              listController: scrollController,
                              menus: ctl.routes
                                  .routesByList(menus: {
                                    FeatureDictionnary.comptesBancaires,
                                    FeatureDictionnary.cartesBancaires,
                                    FeatureDictionnary.commanderCarteCredit,
                                    FeatureDictionnary.cartesVirtuelles,
                                    FeatureDictionnary.rechargeCartePrepayee,
                                    FeatureDictionnary.banks,
                                    FeatureDictionnary.microfinances,
                                    FeatureDictionnary.avanceSurSalaire,
                                  })
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
                              title: GroupeRoute.centresInterets,
                              children: ctl.routes
                                  .routesByList(sorted: false, menus: {
                                    FeatureDictionnary.assurances,
                                    FeatureDictionnary.gabAProximite,
                                    FeatureDictionnary.restaurant,
                                    FeatureDictionnary.gaz,
                                    FeatureDictionnary.pressing,
                                    FeatureDictionnary.materiauxConstruction,
                                    FeatureDictionnary.loyer,
                                    FeatureDictionnary.numerosUtils,
                                    FeatureDictionnary.jobs,
                                    FeatureDictionnary.brasserie,
                                    FeatureDictionnary.caves,
                                  })
                                  .map((e) => e.button)
                                  .toList()
                                ..add(
                                  const ButtonMenu(
                                    title: "Voir plus",
                                    icon: CircleAvatar(
                                        child: Icon(Icons.arrow_forward)),
                                    action: GoToMorePageAction(
                                      groupeTitle: GroupeRoute.centresInterets,
                                      menus: {
                                        FeatureDictionnary.fraisScolarite,
                                        FeatureDictionnary.pharmacie,
                                        FeatureDictionnary.achatPass,
                                        FeatureDictionnary.achatUnite,
                                        FeatureDictionnary.locationVehicules,
                                      },
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
                              title: "Gagnez de l'argent avec",
                              trailing: Image.asset(
                                "assets/images/42ba0891133d09b46e2edd0537c2f2265350876d-1.png",
                                width: 90,
                              ),
                              listController: scrollController,
                              crossAxisCount: 3,
                              menus: ctl.routes
                                  .routesByList(menus: {
                                    FeatureDictionnary.oneXBet,
                                    FeatureDictionnary.premierBet,
                                    FeatureDictionnary.betclic,
                                    FeatureDictionnary.pmu,
                                    FeatureDictionnary.sportCash,
                                    FeatureDictionnary.lotoBonheur,
                                    FeatureDictionnary.casinoCash,
                                    FeatureDictionnary.virtualGames,
                                    FeatureDictionnary.tirageGhana,
                                  }, sorted: false)
                                  .map(
                                    (e) => e.button.copyWith(
                                      displayName: false,
                                    ),
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
                              title: GroupeRoute.serviceInnovant,
                              children: ctl.routes
                                  .routesByList(menus: {
                                    FeatureDictionnary.tontine,
                                    FeatureDictionnary.dons,
                                    FeatureDictionnary.cadeaux,
                                    FeatureDictionnary.vouchers,
                                    FeatureDictionnary.guideUrbain,
                                  })
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
                                  .routesByList(menus: {
                                    FeatureDictionnary.coursesChevauxLebedoo,
                                    FeatureDictionnary.casinoLebedoo,
                                    FeatureDictionnary.parisFootBallLebedoo,
                                    FeatureDictionnary.rouletteLebedoo,
                                  })
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
                              title: GroupeRoute.eGov,
                              children: ctl.routes
                                  .routesByList(menus: {
                                    FeatureDictionnary.paiementTimbres,
                                    FeatureDictionnary.paimenentTaxes,
                                    FeatureDictionnary.paiementContravention,
                                  })
                                  .map((e) => e.button)
                                  .toList(),
                            ),
                            const Gap(20),
                            CardMenu(
                              title: "Factures et abonnements",
                              children: ctl.routes
                                  .routesByList(menus: {
                                    FeatureDictionnary.factureElectricite,
                                    FeatureDictionnary.factureEau,
                                    FeatureDictionnary.abonnementTele,
                                    FeatureDictionnary.abonnementFibre,
                                    FeatureDictionnary.abonnementPeage,
                                  })
                                  .map((e) => e.button)
                                  .toList(),
                            ),
                            const Gap(20),
                            GridMenu(
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              padding: const EdgeInsets.all(3),
                              backgroundColor: Colors.blue.shade100,
                              title: GroupeRoute.divertissement,
                              listController: scrollController,
                              menus: ctl.routes
                                  .routesByList(menus: {
                                    FeatureDictionnary.tickets,
                                    FeatureDictionnary.evenements,
                                  })
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
                                title: GroupeRoute.voyages,
                                crossAxisCount: 3,
                                width: 350,
                                listController: scrollController,
                                menus: ctl.routes
                                    .routesByList(
                                      menus: {
                                        FeatureDictionnary.ticketBus,
                                        FeatureDictionnary.ticketBateauBus,
                                        FeatureDictionnary.billetAvion,
                                        FeatureDictionnary.ticketCar,
                                        FeatureDictionnary.hotels,
                                        FeatureDictionnary.taxi,
                                      },
                                    )
                                    .map((e) => e.button)
                                    .toList(),
                                children: ctl.ads
                                    .where((e) =>
                                        e.categorie == "reservation_billet")
                                    .map(
                                      (e) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: ImageBanner(image: e),
                                      ),
                                    )
                                    .toList()),
                            const Gap(20),
                            ImageSlideBanner(
                              images: ctl.ads
                                  .where((e) => e.categorie == "image_bas")
                                  .toList(),
                            ),
                            GestureDetector(
                              onTap: () => Get.to(() => const MallPage()),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "assets/images/lebedoo_mall.jpeg",
                                  // height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => ctl.shareAppText(
                                  codeParrain: ctl.appCtl.user.ownerCode.value),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          const AutoSizeText(
                                            "🚀 Profitez de tous les avantages "
                                            "de ${AppConst.appName} avec vos amis 🎉✨.",
                                            textAlign: TextAlign.center,
                                            maxLines: 4,
                                            minFontSize: 10,
                                            maxFontSize: 20,
                                          ),
                                          const Gap(10),
                                          CButton(
                                            borderRadius: 20,
                                            color: AssetColors.blue,
                                            onPressed: () => ctl.shareAppText(
                                                codeParrain: ctl.appCtl.user
                                                    .ownerCode.value),
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
                                      "assets/lotties/animation_lmw1phml.json",
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const ListTile(
                              title: Text(
                                "${AppConst.appName} © 2024 - V${Const.appVersion}",
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
