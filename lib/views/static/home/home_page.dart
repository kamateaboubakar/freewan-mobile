import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/utils/functions.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/card_menu.dart';
import 'package:wan_mobile/tools/widgets/pageable_menu.dart';
import 'package:wan_mobile/tools/widgets/single_child_card_menu.dart';
import 'package:wan_mobile/tools/widgets/toggle_button_widget/listable_menu.dart';
import 'package:wan_mobile/views/controllers/home/home_page_vctl.dart';
import 'package:wan_mobile/views/static/achat_fibre/achat_fibre_page.dart';
import 'package:wan_mobile/views/static/achat_pass/achat_pass_page.dart';
import 'package:wan_mobile/views/static/achat_unite/achat_unite_page.dart';
import 'package:wan_mobile/views/static/boutique/boutique_page.dart';
import 'package:wan_mobile/views/static/construction/construction_page.dart';
import 'package:wan_mobile/views/static/donation/campagne_page.dart';
import 'package:wan_mobile/views/static/envoyer_vers_mobile/envoyer_vers_mobile.dart';
import 'package:wan_mobile/views/static/home/categorized_home.dart';
import 'package:wan_mobile/views/static/home/home_drawer.dart';
import 'package:wan_mobile/views/static/home/messagerie/messagerie_page.dart';
import 'package:wan_mobile/views/static/home/more_option_home_page.dart';
import 'package:wan_mobile/views/static/lebedoo/lebedoo_page.dart';
import 'package:wan_mobile/views/static/location_vehicule/location_vehicule.dart';
import 'package:wan_mobile/views/static/loyer/loyer_bottom_sheet.dart';
import 'package:wan_mobile/views/static/mall/mall_page.dart';
import 'package:wan_mobile/views/static/notification/notification_list_page.dart';
import 'package:wan_mobile/views/static/recevoir_paiement/recevoir_paiement.dart';
import 'package:wan_mobile/views/static/scan_pay/scan_pay_camera.dart';
import 'package:wan_mobile/views/static/solde_historique/solde_historique_page.dart';
import 'package:wan_mobile/views/static/tontine/tontine_page.dart';
import 'package:wan_mobile/views/static/tv_bills/tv_bills_selection_dialog.dart';
import '../bills/bills_views.dart';
import '../gaz/pages/gaz_map_page.dart';
import '../job/job_views.dart';
import '../pressing/pressing_view.dart';

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
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.blue.shade50,
              appBar: AppBar(
                leadingWidth: 45,
                backgroundColor: Colors.transparent,
                leading: Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: const CircleAvatar(
                        backgroundColor: AssetColors.blueButton,
                        foregroundColor: Colors.white,
                        child: Icon(Icons.person, size: 20),
                      ),
                    ),
                  );
                }),
                title: Image.asset(Const.inLineAppLogo, width: 100, height: 80),
                actions: [
                  IconButton(
                    iconSize: 20,
                    splashRadius: 20,
                    onPressed: () => Get.to(() => const CategorizedHome()),
                    color: AssetColors.blueButton,
                    icon: const Icon(IcoFontIcons.search),
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
                        color: AssetColors.blueButton,
                        icon: const Icon(Icons.notifications),
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
                      backgroundColor: AssetColors.blueButton,
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
                      backgroundColor: AssetColors.blueButton,
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
                      SizedBox(
                        height: Get.height * 0.4,
                        child: Image.asset(
                          "assets/images/pub_lbd.jpeg",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      DraggableScrollableSheet(
                        snap: true,
                        initialChildSize: 0.7,
                        minChildSize: 0.7,
                        maxChildSize: 0.9,
                        builder: (context, scrollController) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              children: [
                                const Gap(10),
                                Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 4,
                                    top: 3,
                                  ),
                                  height: 4,
                                  width: 30,
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
                                      bottom: 80,
                                    ),
                                    controller: scrollController,
                                    child: Column(
                                      children: [
                                        Visibility(
                                          visible: ctl.ads
                                              .where(
                                                  (e) => e.categorie == "main")
                                              .isNotEmpty,
                                          child: Container(
                                            height: 130,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                width: .1,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            child: ImageSlideshow(
                                              isLoop: true,
                                              autoPlayInterval: 6000,
                                              children: ctl.ads
                                                  .where((e) =>
                                                      e.categorie == "main")
                                                  .map(
                                                    (e) => ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Stack(
                                                        fit: StackFit.expand,
                                                        children: [
                                                          Shimmer.fromColors(
                                                            baseColor: Colors
                                                                .grey[300]!,
                                                            highlightColor:
                                                                Colors
                                                                    .grey[100]!,
                                                            child: Container(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          CachedNetworkImage(
                                                            imageUrl:
                                                                e.url.value,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
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
                                              onPressed: () => Get.to(() =>
                                                  const EnvoyerVersMobilePage()),
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                "assets/images/icons8-tirelire.gif",
                                                // "assets/images/icons/recevoir_argent.png",
                                              ),
                                              title: "Recevoir argent",
                                              onPressed: () => Get.to(() =>
                                                  const RecevoirPaiement()),
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                  "assets/images/icons8-échange-de-cartes.gif"
                                                  // "assets/images/icons/transfert_banquaire.png",

                                                  ),
                                              title: "Banks &\nmicrofinances",
                                              onPressed: () {},
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                "assets/images/icons/mon_bedoo.png",
                                              ),
                                              title: "Lebedoo",
                                              onPressed: () => Get.to(
                                                  () => const LebedooPage()),
                                            ),
                                          ],
                                        ),
                                        PageableMenu(
                                          children: [
                                            ButtonMenu(
                                              icon: Image.asset(
                                                "assets/images/icons/historique_transaction.png",
                                              ),
                                              title: "Solde & historique",
                                              onPressed: () => Get.to(() =>
                                                  const SoldeHistoriquePage()),
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                "assets/images/icons/paiement_loyer.png",
                                              ),
                                              title: "Paiement Loyer",
                                              onPressed: () =>
                                                  Tools.openBottomSheet(
                                                      const LoyerBottomSheet()),
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                "assets/images/icons/paiement_assurance.png",
                                              ),
                                              title: "Assurances",
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
                                              onPressed: () => Get.to(
                                                  () => const TontinePage()),
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                "assets/images/icons8-confiance.gif",
                                              ),
                                              title: "Don",
                                              onPressed: () => Get.to(
                                                  () => const DonationPage()),
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                "assets/images/icons/icons8-voiture-64.png",
                                              ),
                                              title: "Location de véhicule",
                                              onPressed: () => Get.to(() =>
                                                  const LocationVehicule()),
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                "assets/images/icons/icons8-construction-96.png",
                                              ),
                                              title: "Construction de maison",
                                              onPressed: () => Get.to(() =>
                                                  const ConstructionPage()),
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                  "assets/images/icons/pharmacie.png"),
                                              title: "Pharmacies",
                                              onPressed: () => Get.to(
                                                  () => const BoutiquePage()),
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                  "assets/images/restaurant.png"),
                                              title: "Restaurants",
                                              onPressed: () => Get.to(
                                                  () => const BoutiquePage()),
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                "assets/images/icons8-durabilite.gif",
                                              ),
                                              title: "Gaz",
                                              onPressed: () => Get.to(
                                                  () => const GazMapPage()),
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                "assets/images/icons/icons8-repassage-64.png",
                                              ),
                                              title: "Pressing",
                                              onPressed: () => Get.to(
                                                () => const PressingMapPage(),
                                              ),
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                  "assets/images/icons8-cadeau.gif"),
                                              title: "Cadeau",
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
                                                "assets/images/icons/caves.png",
                                              ),
                                              title: "Caves",
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: SingleChildCardMenu(
                                                onTap: () {},
                                                icon: Image.asset(
                                                  "assets/images/icons/carte-bancaire_lbd.png",
                                                  height: 18,
                                                  width: 18,
                                                ),
                                                title:
                                                    "Carte prépayée ${Const.appName}",
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
                                                title:
                                                    "Carte Virtuelle ${Const.appName}",
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
                                              onPressed: () => Get.to(
                                                  () => AchatUnitePage(ctl)),
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                  "assets/images/icons/acaht_data.png"),
                                              title: "Achat de pass",
                                              onPressed: () => Get.to(
                                                  () => AchatPassPage(ctl)),
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                  "assets/images/icons/facture_electricite.png"),
                                              title: "Facture d’électricité",
                                              onPressed: () =>
                                                  Tools.openBottomSheet(
                                                const BillsCompanySelectionDialog(),
                                              ),
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                  "assets/images/icons/facture_eau.png"),
                                              title: "Facture d'eau",
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
                                              onPressed: () => Get.to(
                                                  () => AchatFibrePage(ctl)),
                                            ),
                                            ButtonMenu(
                                              icon: const CircleAvatar(
                                                backgroundColor: Color.fromRGBO(
                                                    50, 132, 229, 0.16),
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  color: Color.fromRGBO(
                                                      7, 21, 60, 1),
                                                ),
                                              ),
                                              title: "Voir Plus",
                                              onPressed: () => Get.to(() =>
                                                  const MoreOptionHomePage()),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Gap(10),
                                            Row(
                                              children: [
                                                const Expanded(
                                                  child: AutoSizeText(
                                                    "Pariez et Gagnez avec la LONACI",
                                                    minFontSize: 10,
                                                    maxFontSize: 20,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Image.asset(
                                                  "assets/images/42ba0891133d09b46e2edd0537c2f2265350876d-1.png",
                                                  width: 80,
                                                )
                                              ],
                                            ),
                                            Container(
                                              height: 220,
                                              margin: const EdgeInsets.only(
                                                bottom: 20,
                                                top: 10,
                                              ),
                                              child: ListView(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: [
                                                  Container(
                                                    width: 300,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                      child: GridView.count(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        crossAxisCount: 3,
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        children: [
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                              "assets/images/betclic.svg.png",
                                                              height: 40,
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                              "assets/images/5b28ce4349be5-"
                                                              "pmu-lonaci-cote-ivoire.png",
                                                              height: 40,
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                              "assets/images/1xbet.png",
                                                              height: 40,
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                              "assets/images/premier_bet.jpg",
                                                              height: 40,
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                              "assets/images/sportcash.png",
                                                              height: 40,
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                              "assets/images/casinocash.png",
                                                              width: 100,
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Row(
                                                    children: ctl.ads
                                                        .where(
                                                          (e) =>
                                                              e.categorie ==
                                                              "lonaci",
                                                        )
                                                        .map(
                                                          (e) => Row(
                                                            children: [
                                                              Container(
                                                                height: double
                                                                    .infinity,
                                                                // width: 300,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl: e
                                                                        .url
                                                                        .value,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
                                                            ],
                                                          ),
                                                        )
                                                        .toList(),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Gap(20),
                                            const Text(
                                              "Gagnez de l'argent avec lebedoo",
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Container(
                                              height: 220,
                                              margin: const EdgeInsets.only(
                                                  bottom: 20, top: 10),
                                              child: ListView(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: [
                                                  Container(
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                      child: GridView.count(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        crossAxisCount: 2,
                                                        childAspectRatio: .95,
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        children: [
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                                "assets/images/icons/icons8-casino-48.png"),
                                                            title:
                                                                "Lebedoo Jackpot",
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                                "assets/images/icons/icons8-roulette-80.png"),
                                                            title:
                                                                "La roulette de Lebedoo",
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                                "assets/images/icons/icons8-bet-62.png"),
                                                            title:
                                                                "Paris sportifs",
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                                "assets/images/icons/icons8-horse-racing-96.png"),
                                                            title:
                                                                "Paris courses de chevaux",
                                                            onPressed: () {},
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Row(
                                                      children: ctl.ads
                                                          .where((e) =>
                                                              e.categorie ==
                                                              "paris_lebedoo")
                                                          .map(
                                                            (e) =>
                                                                (e.secondUrl ==
                                                                        null)
                                                                    ? Row(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                double.infinity,
                                                                            width:
                                                                                300,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: e.url.value,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 10),
                                                                        ],
                                                                      )
                                                                    : Row(
                                                                        children: [
                                                                          Column(
                                                                            children: [
                                                                              Expanded(
                                                                                child: SizedBox(
                                                                                  width: 250,
                                                                                  child: ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    child: CachedNetworkImage(
                                                                                      imageUrl: e.url.value,
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
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    child: CachedNetworkImage(
                                                                                      imageUrl: e.secondUrl.value,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 10),
                                                                        ],
                                                                      ),
                                                          )
                                                          .toList()),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Gap(10),
                                            const Text(
                                              "Prêts & Cartes de Crédit",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Container(
                                              height: 220,
                                              margin: const EdgeInsets.only(
                                                bottom: 20,
                                                top: 10,
                                              ),
                                              child: ListView(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: [
                                                  Container(
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                      child: GridView.count(
                                                        childAspectRatio: .95,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        crossAxisCount: 2,
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        children: [
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                                "assets/images/icons/icons8-google-play-store-96.png"),
                                                            title:
                                                                "Google Play Recharge",
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                                "assets/images/icons/pret.png"),
                                                            title:
                                                                "Payemenent prêts",
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                                "assets/images/icons/scolarite.png"),
                                                            title: "Scolarité",
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                                "assets/images/icons/bank_to_wallet.png"),
                                                            title:
                                                                "Bank to Wallet",
                                                            onPressed: () {},
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Row(
                                                      children: ctl.ads
                                                          .where((e) =>
                                                              e.categorie ==
                                                              "pret")
                                                          .map(
                                                            (e) =>
                                                                (e.secondUrl ==
                                                                        null)
                                                                    ? Row(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                double.infinity,
                                                                            width:
                                                                                300,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: e.url.value,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 10),
                                                                        ],
                                                                      )
                                                                    : Row(
                                                                        children: [
                                                                          Column(
                                                                            children: [
                                                                              Expanded(
                                                                                child: SizedBox(
                                                                                  width: 250,
                                                                                  child: ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    child: CachedNetworkImage(
                                                                                      imageUrl: e.url.value,
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
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    child: CachedNetworkImage(
                                                                                      imageUrl: e.secondUrl.value,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 10),
                                                                        ],
                                                                      ),
                                                          )
                                                          .toList()),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: CardMenu(
                                            title: "Vouchers",
                                            children: [
                                              ButtonMenu(
                                                icon: Image.asset(
                                                  "assets/images/playstation_store.png",
                                                ),
                                              ),
                                              ButtonMenu(
                                                icon: Image.asset(
                                                  "assets/images/Xbox_store.jpg",
                                                ),
                                              ),
                                              ButtonMenu(
                                                icon: Image.asset(
                                                  "assets/images/icons/icons8-google-play-store-96.png",
                                                ),
                                              ),
                                              ButtonMenu(
                                                icon: Image.asset(
                                                  "assets/images/Steam_icon.png",
                                                ),
                                              ),
                                              ButtonMenu(
                                                icon: Image.asset(
                                                  "assets/images/Logo_App_Store_Apple.png",
                                                ),
                                              ),
                                              ButtonMenu(
                                                icon: Image.asset(
                                                  "assets/images/Virgin-logo.png",
                                                ),
                                              ),
                                              ButtonMenu(
                                                icon: Image.asset(
                                                  "assets/images/Nintendo_logo.png",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CardMenu(
                                          title: "Fonctionnalités",
                                          children: [
                                            ButtonMenu(
                                              minWidth: 30,
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
                                              minWidth: 40,
                                              icon: Image.asset(
                                                "assets/images/icons8-exchange-money-64.png",
                                              ),
                                              title: "Tontine",
                                              onPressed: () => Get.to(
                                                  () => const TontinePage()),
                                            ),
                                            ButtonMenu(
                                              minWidth: 40,
                                              icon: Image.asset(
                                                "assets/images/icons8-confiance.gif",
                                              ),
                                              title: "Don",
                                              onPressed: () => Get.to(
                                                  () => const DonationPage()),
                                            ),
                                            ButtonMenu(
                                              icon: const CircleAvatar(
                                                backgroundColor: Color.fromRGBO(
                                                    50, 132, 229, 0.16),
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  color: Color.fromRGBO(
                                                      7, 21, 60, 1),
                                                ),
                                              ),
                                              title: "Voir Plus",
                                              onPressed: () => Get.to(() =>
                                                  const CategorizedHome()),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Gap(10),
                                            const Text(
                                              "Réservation de billets",
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Container(
                                              height: 220,
                                              margin: const EdgeInsets.only(
                                                bottom: 20,
                                                top: 10,
                                              ),
                                              child: ListView(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: [
                                                  Container(
                                                    width: 300,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                      child: GridView.count(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        crossAxisCount: 3,
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        children: [
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                                "assets/images/icons/bus_car.png"),
                                                            title: "Bus et Car",
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                                "assets/images/icons8-ticket.gif"),
                                                            title:
                                                                "Ticket de cinéma",
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                              "assets/images/icons/icons8-events-64.png",
                                                            ),
                                                            title: "Evènements",
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                                "assets/images/icons8-hôtel-5-étoiles-48.png"),
                                                            title: "Hotels",
                                                            onPressed: () {},
                                                          ),
                                                          // ButtonMenu(
                                                          //   icon: Image.asset(
                                                          //       "assets/images/icons8-train-64.png"),
                                                          //   title: "Métro",
                                                          //   onPressed: () {},
                                                          // ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                                "assets/images/icons8-avion-vue-de-face-64.png"),
                                                            title:
                                                                "Billet d'avion",
                                                            onPressed: () {},
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Row(
                                                      children: ctl.ads
                                                          .where((e) =>
                                                              e.categorie ==
                                                              "reservation_billet")
                                                          .map(
                                                            (e) =>
                                                                (e.secondUrl ==
                                                                        null)
                                                                    ? Row(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                double.infinity,
                                                                            width:
                                                                                300,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: e.url.value,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 10),
                                                                        ],
                                                                      )
                                                                    : Row(
                                                                        children: [
                                                                          Column(
                                                                            children: [
                                                                              Expanded(
                                                                                child: SizedBox(
                                                                                  width: 250,
                                                                                  child: ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    child: CachedNetworkImage(
                                                                                      imageUrl: e.url.value,
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
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    child: CachedNetworkImage(
                                                                                      imageUrl: e.secondUrl.value,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 10),
                                                                        ],
                                                                      ),
                                                          )
                                                          .toList()),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          color: Colors.white,
                                          child: ListTile(
                                            leading: const CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  "assets/images/icons8-argent-liquide-en-main-100.png"),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            title: const Text(
                                              "Inquiet du manque de liquidités ?",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: const Text(
                                              "Obtenez un prêt sans aucune paperasse",
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            trailing: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Postuler",
                                                  style: TextStyle(
                                                    color:
                                                        AssetColors.blueButton,
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Gap(20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Gap(10),
                                            const Text(
                                              "Trading",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Container(
                                              height: 220,
                                              margin: const EdgeInsets.only(
                                                bottom: 20,
                                                top: 10,
                                              ),
                                              child: ListView(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: [
                                                  Container(
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                      child: GridView.count(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        crossAxisCount: 2,
                                                        childAspectRatio: 1,
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        children: [
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                                "assets/images/icons/icons8-buffle-64.png"),
                                                            title: "Open Demat",
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                                "assets/images/icons/icons8-argent-64.png"),
                                                            title:
                                                                "Investir avec\n10K Fcfa",
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                              "assets/images/lebedoo_logo.png",
                                                            ),
                                                            title:
                                                                "Lebedoo Money",
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                                "assets/images/icons8-bourse-48.png"),
                                                            title:
                                                                "Bourse\nd'investissement",
                                                            onPressed: () {},
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Row(
                                                      children: ctl.ads
                                                          .where((e) =>
                                                              e.categorie ==
                                                              "trading")
                                                          .map(
                                                            (e) =>
                                                                (e.secondUrl ==
                                                                        null)
                                                                    ? Row(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                double.infinity,
                                                                            width:
                                                                                300,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: e.url.value,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 10),
                                                                        ],
                                                                      )
                                                                    : Row(
                                                                        children: [
                                                                          Column(
                                                                            children: [
                                                                              Expanded(
                                                                                child: SizedBox(
                                                                                  width: 250,
                                                                                  child: ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    child: CachedNetworkImage(
                                                                                      imageUrl: e.url.value,
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
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    child: CachedNetworkImage(
                                                                                      imageUrl: e.secondUrl.value,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 10),
                                                                        ],
                                                                      ),
                                                          )
                                                          .toList()),
                                                  const SizedBox(width: 10),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          color: Colors.white,
                                          margin:
                                              const EdgeInsets.only(bottom: 20),
                                          child: ListTile(
                                            leading: const CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  "assets/images/icons8-argent-liquide-en-main-100.png"),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            title: const Text(
                                              "Obtenir des récompenses assurées",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: const Text(
                                              "en invitant vos amis sur lebedoo",
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            trailing: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Apply",
                                                  style: TextStyle(
                                                    color:
                                                        AssetColors.blueButton,
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        ListableMenu(
                                          title: "Promotions",
                                          children: [
                                            ButtonMenu(
                                              minWidth: 30,
                                              icon: Image.asset(
                                                "assets/images/texas-grillz.jpg",
                                              ),
                                              onPressed: () {},
                                            ),
                                            ButtonMenu(
                                              minWidth: 30,
                                              icon: Image.asset(
                                                "assets/images/DABALI-EXPRESS-OK.png",
                                              ),
                                              onPressed: () {},
                                            ),
                                            ButtonMenu(
                                              minWidth: 30,
                                              icon: Image.asset(
                                                "assets/images/carrefour.png",
                                              ),
                                              onPressed: () {},
                                            ),
                                            ButtonMenu(
                                              minWidth: 40,
                                              icon: Image.asset(
                                                "assets/images/jumia_food.jpeg",
                                              ),
                                              onPressed: () {},
                                            ),
                                            ButtonMenu(
                                              minWidth: 40,
                                              icon: Image.asset(
                                                "assets/images/majestic.png",
                                              ),
                                              onPressed: () {},
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                "assets/images/yango.png",
                                              ),
                                              onPressed: () {},
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                "assets/images/uber.jpg",
                                              ),
                                              onPressed: () {},
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                  "assets/images/socofrais.png"),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                        const Gap(10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "En affiche",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Gap(10),
                                            Container(
                                              height: 220,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  width: .1,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              child: (ctl.ads.isEmpty)
                                                  ? const SizedBox.shrink()
                                                  : ImageSlideshow(
                                                      isLoop: true,
                                                      autoPlayInterval: 6000,
                                                      children: ctl.ads
                                                          .where((e) =>
                                                              e.categorie ==
                                                              "en_affiche")
                                                          .map(
                                                            (e) => ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child: Stack(
                                                                fit: StackFit
                                                                    .expand,
                                                                children: [
                                                                  Shimmer
                                                                      .fromColors(
                                                                    baseColor:
                                                                        Colors.grey[
                                                                            300]!,
                                                                    highlightColor:
                                                                        Colors.grey[
                                                                            100]!,
                                                                    child:
                                                                        Container(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  CachedNetworkImage(
                                                                    imageUrl: e
                                                                        .url
                                                                        .value,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                            ),
                                          ],
                                        ),
                                        const Gap(10),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 220,
                                          child: Column(
                                            children: [
                                              const ListTile(
                                                title: Text(
                                                  "Le Mall",
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => Get.to(
                                                    () => const MallPage()),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.asset(
                                                    "assets/images/mall.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // ListableMenu(
                                        //   height: 180,
                                        //   title: "Le Mall",
                                        //   children: [
                                        //     ButtonMenu(
                                        //       minWidth: 30,
                                        //       icon: Image.asset(
                                        //         "assets/images/logo_Galerie_Peyrissac_black.png",
                                        //       ),
                                        //       onPressed: () {},
                                        //     ),
                                        //     ButtonMenu(
                                        //       minWidth: 30,
                                        //       icon: Image.asset(
                                        //         "assets/images/carrefour.png",
                                        //       ),
                                        //       onPressed: () {},
                                        //     ),
                                        //     ButtonMenu(
                                        //       minWidth: 30,
                                        //       icon: Image.asset(
                                        //         "assets/images/Prosuma_logo_HD.png",
                                        //       ),
                                        //       onPressed: () {},
                                        //     ),
                                        //     ButtonMenu(
                                        //       minWidth: 30,
                                        //       icon: const Icon(
                                        //           Icons.arrow_forward),
                                        //       title: "Voir le Mall",
                                        //       onPressed: () {},
                                        //     ),
                                        //   ],
                                        // ),
                                        const Gap(20),
                                        ImageSlideshow(
                                          height: 200,
                                          children: <Object>[
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Text(
                                                          "Invitez vos amis "
                                                          "sur ${Const.appName} et gagnez des récompenses...",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        const Gap(10),
                                                        CButton(
                                                          onPressed: () => Functions
                                                              .shareAppText(
                                                                  codeParrain: ctl
                                                                      .appCtl
                                                                      .user
                                                                      .ownerCode
                                                                      .value),
                                                          child: const Text(
                                                              "Inviter"),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Lottie.asset(
                                                  "assets/lotties/animation_lmw1phml.json",
                                                  width: 200,
                                                )
                                              ],
                                            ),
                                            ...ctl.ads
                                                .where((e) =>
                                                    e.categorie == "pub_bas")
                                                .map((e) => e.url.value)
                                          ]
                                              .map(
                                                (e) => (e is Widget)
                                                    ? e
                                                    : CachedNetworkImage(
                                                        imageUrl: e as String,
                                                        fit: BoxFit.cover,
                                                      ),
                                              )
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
