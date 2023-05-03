import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:wan_mobile/tools/widgets/card_menu.dart';
import 'package:wan_mobile/tools/widgets/single_child_card_menu.dart';
import 'package:wan_mobile/views/controllers/home/home_page_vctl.dart';
import 'package:wan_mobile/views/static/home/home_drawer.dart';
import 'package:badges/badges.dart' as badges;
import 'package:wan_mobile/views/static/loyer/locataire/formulaire_code_maison_loyer.dart';
import 'package:wan_mobile/views/static/loyer/loyer_bottom_sheet.dart';
import 'package:wan_mobile/views/static/loyer/proprio/bien_immobilier_page.dart';
import 'package:wan_mobile/views/static/scan_pay/scan_pay_camera.dart';

class HomePage extends StatelessWidget {
  final bool displayWelcome;
  const HomePage({this.displayWelcome = false, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageVctl>(
        init: HomePageVctl(displayWelcome),
        builder: (ctl) {
          return Scaffold(
            drawer: const HomeDrawer(),
            backgroundColor: const Color.fromRGBO(182, 214, 232, 1.0),
            appBar: AppBar(
              leadingWidth: 50,
              toolbarHeight: 60,
              title: Image.asset(
                "assets/images/logo_bedoo.png",
                width: 67,
                height: 30,
              ),
              leading: Builder(builder: (context) {
                return GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: badges.Badge(
                      position:
                          badges.BadgePosition.bottomEnd(bottom: 4, end: -2),
                      badgeStyle: badges.BadgeStyle(
                        badgeColor: Colors.grey.shade200,
                      ),
                      badgeContent:
                          const Icon(Icons.menu, color: Colors.black, size: 7),
                      child: CircleAvatar(
                        // radius: 30,
                        backgroundColor: Colors.grey,
                        child: IconButton(
                          color: Colors.white,
                          splashRadius: 20,
                          icon: const Center(
                            child: Icon(Icons.person, size: 16),
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                    ),
                  ),
                );
              }),
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  splashRadius: 20,
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/images/icons8-chercher-96.png",
                    width: 25,
                  ),
                ),
                IconButton(
                  splashRadius: 20,
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/images/icons8-message-48.png",
                    width: 25,
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              child: ctl.smallButton
                  ? FloatingActionButton(
                      backgroundColor: const Color.fromRGBO(13, 51, 159, 1),
                      isExtended: true,
                      onPressed: () => Get.to(() => const ScanPayCamera()),
                      child: Image.asset(
                        "assets/images/icons/scan_float_button.png",
                        width: 20,
                        height: 20,
                      ),
                    )
                  : FloatingActionButton.extended(
                      backgroundColor: const Color.fromRGBO(13, 51, 159, 1),
                      onPressed: () => Get.to(() => const ScanPayCamera()),
                      label: const Text(
                        "Scanner un qr code",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      icon: Image.asset(
                        "assets/images/icons/scan_float_button.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 210,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Image.network(
                        'https://cdn.mos.cms.futurecdn.net/V6LCHNxfSPT2Sxpr4bAzD.jpg',
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
                DraggableScrollableSheet(
                  controller: ctl.scrollController,
                  initialChildSize: .75,
                  minChildSize: .75,
                  builder: (context, scrollController) => Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: 50,
                          margin: const EdgeInsets.only(top: 10, bottom: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.all(10),
                            physics: const BouncingScrollPhysics(),
                            controller: scrollController,
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                  height: 150,
                                  onPageChanged:
                                      (index, carouselPageChangedReason) {
                                    ctl.currentAds = index;
                                    ctl.update();
                                  },
                                ),
                                items: ctl.ads.map((e) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: .1,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey[300]!,
                                                highlightColor:
                                                    Colors.grey[100]!,
                                                child: Container(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Image.network(
                                                e,
                                                fit: BoxFit.fill,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: 50,
                                child: Center(
                                  child: AnimatedSmoothIndicator(
                                    activeIndex: ctl.currentAds,
                                    count: ctl.ads.length,
                                    effect: const WormEffect(
                                      activeDotColor: Const.primaryColor,
                                      dotWidth: 10,
                                      dotHeight: 10,
                                    ),
                                  ),
                                ),
                              ),
                              CardMenu(
                                title: "Hub Financier",
                                children: [
                                  ButtonMenu(
                                    icon: CircleAvatar(
                                      backgroundColor: const Color.fromRGBO(
                                          50, 132, 229, 0.16),
                                      child: Image.asset(
                                        "assets/images/icons/scan_pay.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                    title: "Scanner et payer",
                                    onPressed: () =>
                                        Get.to(() => const ScanPayCamera()),
                                  ),
                                  ButtonMenu(
                                    icon: CircleAvatar(
                                      backgroundColor: const Color.fromRGBO(
                                          50, 132, 229, 0.16),
                                      child: Image.asset(
                                        "assets/images/icons/envoyer_mobile.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                    title: "Envoyer mobile",
                                    onPressed: () {},
                                  ),
                                  ButtonMenu(
                                    icon: CircleAvatar(
                                      backgroundColor: const Color.fromRGBO(
                                          50, 132, 229, 0.16),
                                      child: Image.asset(
                                          "assets/images/icons/recevoir_argent.png",
                                          height: 20,
                                          width: 20),
                                    ),
                                    title: "Recevoir argent",
                                    onPressed: () {},
                                  ),
                                  ButtonMenu(
                                    icon: Image.asset(
                                      "assets/images/icons/transfert_banquaire.png",
                                      height: 20,
                                      width: 20,
                                    ),
                                    title: "Transfert bancaire",
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
                                    title: "Historique Transactions",
                                    onPressed: () {},
                                  ),
                                  ButtonMenu(
                                    icon: Image.asset(
                                      "assets/images/icons/mon_bedoo.png",
                                    ),
                                    title: "Mon Bédou",
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
                                    onPressed: () {},
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
                                    onPressed: () {},
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
                                    onPressed: () {},
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
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
