import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:wan_mobile/tools/widgets/card_menu.dart';
import 'package:wan_mobile/tools/widgets/pageable_menu.dart';
import 'package:wan_mobile/tools/widgets/single_child_card_menu.dart';
import 'package:wan_mobile/tools/widgets/toggle_button_widget/listable_menu.dart';
import 'package:wan_mobile/views/controllers/home/home_page_vctl.dart';
import 'package:wan_mobile/views/static/achat_unite/achat_unite_page.dart';
import 'package:wan_mobile/views/static/boutique/boutique_page.dart';
import 'package:wan_mobile/views/static/construction/construction_page.dart';
import 'package:wan_mobile/views/static/donation/campagne_page.dart';
import 'package:wan_mobile/views/static/envoyer_vers_mobile/envoyer_vers_mobile.dart';
import 'package:wan_mobile/views/static/home/categorized_home.dart';
import 'package:wan_mobile/views/static/home/home_drawer.dart';
import 'package:wan_mobile/views/static/home/messagerie/messagerie_page.dart';
import 'package:wan_mobile/views/static/home/more_option_home_page.dart';
import 'package:wan_mobile/views/static/home/page_recherche.dart';
import 'package:wan_mobile/views/static/lebedoo/lebedoo_page.dart';
import 'package:wan_mobile/views/static/location_vehicule/location_vehicule.dart';
import 'package:wan_mobile/views/static/loyer/loyer_bottom_sheet.dart';
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
                    onPressed: () => Get.to(() => const PageRecherche()),
                    color: AssetColors.blueButton,
                    icon: const Icon(IcoFontIcons.search),
                  ),
                  IconButton(
                    iconSize: 20,
                    splashRadius: 20,
                    onPressed: () => ctl.pageViewCtl.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease),
                    color: AssetColors.blueButton,
                    icon: const Icon(IcoFontIcons.uiMessaging),
                  ),
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
                      onPressed: () => Get.to(() => const ScanPayCamera()),
                      child: Image.asset(
                        "assets/images/icons/scan_float_button.png",
                        width: 20,
                        height: 20,
                      ),
                    );
                  } else {
                    return FloatingActionButton.extended(
                      backgroundColor: AssetColors.blueButton,
                      onPressed: () => Get.to(() => const ScanPayCamera()),
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
                                        Container(
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
                                                .map(
                                                  (e) => ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: [
                                                        Shimmer.fromColors(
                                                          baseColor:
                                                              Colors.grey[300]!,
                                                          highlightColor:
                                                              Colors.grey[100]!,
                                                          child: Container(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        CachedNetworkImage(
                                                            imageUrl: e,
                                                            fit: BoxFit.cover),
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
                                              onPressed: () => Get.to(() =>
                                                  EnvoyerVersMobilePage(ctl)),
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
                                              title: "Transfert bancaire",
                                              onPressed: () {},
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                "assets/images/icons/mon_bedoo.png",
                                              ),
                                              title: "Lebedoo",
                                              onPressed: () => Get.to(
                                                  () => LebedooPage(ctl)),
                                            ),
                                          ],
                                        ),
                                        PageableMenu(
                                          children: [
                                            ButtonMenu(
                                              icon: Image.asset(
                                                "assets/images/icons/historique_transaction.png",
                                              ),
                                              title: "Solde et historique",
                                              onPressed: () => Get.to(() =>
                                                  SoldeHistoriquePage(ctl)),
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
                                                  "assets/images/icons/boutique.png"),
                                              title: "Boutique",
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
                                                subtitle:
                                                    "Récompenses garanties",
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
                                                subtitle:
                                                    "Achetez sur sites ecommerce",
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
                                                  () => const AchatUnitePage()),
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
                                              onPressed: () =>
                                                  Tools.openBottomSheet(
                                                const BillsCompanySelectionDialog(),
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
                                                  child: Text(
                                                    "Pariez et Gagnez avec la LONACI",
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
                                                            title: "Betclic",
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                              "assets/images/5b28ce4349be5-"
                                                              "pmu-lonaci-cote-ivoire.png",
                                                              height: 40,
                                                            ),
                                                            title: "PMU",
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                              "assets/images/1xbet.png",
                                                              height: 40,
                                                            ),
                                                            title: "1xBet",
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                              "assets/images/premier_bet.webp",
                                                              height: 40,
                                                            ),
                                                            title:
                                                                "Premier Bet",
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                              "assets/images/sportcash.png",
                                                              height: 40,
                                                            ),
                                                            title: "Sport cash",
                                                            onPressed: () {},
                                                          ),
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                              "assets/images/casinocash.png",
                                                              width: 100,
                                                            ),
                                                            title: "Casinocash",
                                                            onPressed: () {},
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Container(
                                                    height: double.infinity,
                                                    width: 290,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            "https://www.pigroup360.com/wp-content/uploads/2021/06/4X3-3.jpg",
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Container(
                                                    height: double.infinity,
                                                    width: 300,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            "https://www.goafricaonline.com/media/cache/resolve/w800/uploads/media/company_media/0001/38/5b27743f77795-mur-packing-pmu-lonaci-cote-ivoire.jpg",
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  SizedBox(
                                                    width: 250,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            "https://kanjulien.files.wordpress.com/2013/10/megajackpot.jpg",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
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
                                                  Container(
                                                    height: double.infinity,
                                                    width: 300,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            "https://www.lepoint.fr/images/2016/12"
                                                            "/15/6476009lpw-6476232-article-horse-racing-on"
                                                            "-the-hippodrome-of-cagnes-sur-mer-france-jpg_3968108_1250x625.jpg",
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            "https://burkina24.com/wp-content/uploads/2023/06/1XBeta-scaled.jpg",
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
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  "https://i.ytimg.com/vi/eO4q6KXQlU8/mqdefault.jpg",
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Expanded(
                                                        child: SizedBox(
                                                          width: 250,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  "https://bonus-malin.info/wp-content/uploads/2018/11/turf-unibet-bonus-47.jpg",
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
                                                  Container(
                                                    height: double.infinity,
                                                    width: 400,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            "https://www.ladn.eu/wp-content/"
                                                            "uploads/2020/01/TUI-campagne-communication-vacances"
                                                            "-revees-francais.jpg",
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Container(
                                                    height: double.infinity,
                                                    width: Get.width,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            "https://cofeb.bceao.int/sites/default/files/2022-08/Visuel-Formation_A_LA_CARTE_ONLINE.jpg",
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
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  "https://www.nsiabanque.ci/wp-content/uploads/2023/06/Campagne_GIM-UEMOA_SLIDER_Site-web.jpg",
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Expanded(
                                                        child: SizedBox(
                                                          width: 250,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  "https://www.bankobserver-wavestone.com/wp-content/uploads/2021/12/online_banking_fr.png",
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
                                        ListableMenu(
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
                                              icon: Image.asset(
                                                "assets/images/icons/historique_transaction.png",
                                              ),
                                              title: "Solde et\nhistorique",
                                              onPressed: () => Get.to(() =>
                                                  SoldeHistoriquePage(ctl)),
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                "assets/images/icons/paiement_loyer.png",
                                              ),
                                              title: "Paiement\nLoyer",
                                              onPressed: () =>
                                                  Tools.openBottomSheet(
                                                      const LoyerBottomSheet()),
                                            ),
                                            ButtonMenu(
                                              icon: Image.asset(
                                                  "assets/images/icons/icons8-arrêt-de-bus-64.png"),
                                              title: "Bus et Car",
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
                                                "assets/images/icons/icons8-events-64.png",
                                              ),
                                              title: "Evénements",
                                              onPressed: () {},
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
                                                                "assets/images/icons/icons8-arrêt-de-bus-64.png"),
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
                                                          ButtonMenu(
                                                            icon: Image.asset(
                                                                "assets/images/icons8-train-64.png"),
                                                            title: "Métro",
                                                            onPressed: () {},
                                                          ),
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
                                                  Container(
                                                    height: double.infinity,
                                                    width: 400,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            "https://i.ytimg.com/vi/on0zd4LUWQI/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLAcryAHlDWPgBPToz1c1Y78_k2NIA",
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            "https://www.goafricaonline.com/media/cache/resolve/w800/uploads/media/company_media/0001/37/5b06a7658ff50-visuel-destination-rev-cote-ivoire.jpg",
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
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
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
                                                      const SizedBox(
                                                          height: 10),
                                                      Expanded(
                                                        child: SizedBox(
                                                          width: 250,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
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
                                                  Container(
                                                    height: double.infinity,
                                                    width: 400,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            "https://www.bourseensemble.com/wp-content/uploads/2022/06/tout-savoir-sur-le-fractionnement-actions.jpg",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Container(
                                                    height: double.infinity,
                                                    width: 300,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            "https://www.paricilargent.com/wp-content/uploads/2021/04/Investir-dans-l-immobilier-ou-en-bourse-850x500.jpg",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
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
                                          child: ImageSlideshow(
                                            isLoop: true,
                                            autoPlayInterval: 6000,
                                            children: ctl.ads2
                                                .map(
                                                  (e) => ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: [
                                                        Shimmer.fromColors(
                                                          baseColor:
                                                              Colors.grey[300]!,
                                                          highlightColor:
                                                              Colors.grey[100]!,
                                                          child: Container(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        CachedNetworkImage(
                                                          imageUrl: e,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                        const Gap(10),
                                        ListableMenu(
                                          height: 180,
                                          title: "Shopping - Jumia",
                                          children: [
                                            ButtonMenu(
                                              height: 150,
                                              icon: CachedNetworkImage(
                                                  imageUrl:
                                                      "https://ci.jumia.is/unsafe/fit-in/300x300/filters:fill(white)/product/47/059442/1.jpg?0223"),
                                              onPressed: () => launchUrl(
                                                Uri.parse(
                                                    "https://www.jumia.ci/win-tv-led-24-pouces-acdc-12-volt-energie-solaire-usb-hdmi-noir-garantie-12-mois-24495074.html"),
                                              ),
                                            ),
                                            ButtonMenu(
                                              height: 150,
                                              icon: CachedNetworkImage(
                                                imageUrl:
                                                    "https://ci.jumia.is/unsafe/fit-in/500x500/filters:fill(white)/product/73/794891/1.jpg?4285",
                                                fit: BoxFit.cover,
                                              ),
                                              onPressed: () => launchUrl(
                                                Uri.parse(
                                                    "https://www.jumia.ci/xper-tv-led-32ln4100d-32-pouces-hd-decodeur-integre-noir-19849737.html"),
                                              ),
                                            ),
                                            ButtonMenu(
                                              height: 150,
                                              icon: CachedNetworkImage(
                                                imageUrl:
                                                    "https://ci.jumia.is/unsafe/fit-in/300x300/filters:fill(white)/product/00/548311/1.jpg?8307",
                                                fit: BoxFit.cover,
                                              ),
                                              onPressed: () => launchUrl(
                                                Uri.parse(
                                                  "https://www.jumia.ci/smart-technology-refrigerateur-2-battants-str-99h-85-l-gris-12-mois-de-garantie-11384500.html",
                                                ),
                                              ),
                                            ),
                                            ButtonMenu(
                                              height: 150,
                                              icon: CachedNetworkImage(
                                                imageUrl:
                                                    "https://ci.jumia.is/unsafe/fit-in/500x500/filters:fill(white)/product/50/723791/1.jpg?8443",
                                                fit: BoxFit.cover,
                                              ),
                                              onPressed: () => launchUrl(
                                                Uri.parse(
                                                    "https://www.jumia.ci/rocco-petits-pois-boite-400g-19732705.html"),
                                              ),
                                            ),
                                            ButtonMenu(
                                              height: 150,
                                              icon: CachedNetworkImage(
                                                imageUrl:
                                                    "https://ci.jumia.is/unsafe/fit-in/500x500/filters:fill(white)/product/72/350241/1.jpg?5791",
                                                fit: BoxFit.cover,
                                              ),
                                              onPressed: () => launchUrl(
                                                Uri.parse(
                                                    "https://www.jumia.ci/fashion-t-shirt-short-pour-homme-bleu-14205327.html"),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Gap(20),
                                        ImageSlideshow(
                                          children: [
                                            "https://blog.easyflyer.fr/wp-content/uploads/2018/03/supports-communication-promotion-sac-tissu-drapeau-voile.jpg",
                                            "https://www.rayon-boissons.com/var/site/storage/images/_aliases/large/1/9/5/1/1921591-2-fre-FR/import_file_Auchan-promo-100-volvic.png",
                                            "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/product-promotion-flyer-poster-instagram-design-template-c47a97e2c5053e78a059e718077e639a_screen.jpg?ts=1618104409"
                                          ]
                                              .map(
                                                (e) => CachedNetworkImage(
                                                  imageUrl: e,
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
