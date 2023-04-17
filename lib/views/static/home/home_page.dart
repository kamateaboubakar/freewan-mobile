import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:wan_mobile/tools/widgets/card_menu.dart';
import 'package:wan_mobile/views/controllers/home/home_page_vctl.dart';
import 'package:wan_mobile/views/static/home/home_drawer.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageVctl>(
        init: HomePageVctl(),
        builder: (ctl) {
          return Scaffold(
            drawer: const HomeDrawer(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: ctl.fabSize,
              child: ctl.fabSize == 40.0
                  ? FloatingActionButton(
                      isExtended: true,
                      onPressed: () {},
                      child: const Icon(Icons.qr_code),
                    )
                  : FloatingActionButton.extended(
                      onPressed: () {},
                      label: const Text("Scanner un code"),
                      icon: const Icon(Icons.qr_code),
                    ),
            ),
            body: CustomScrollView(
              controller: ctl.scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  title: const Text(
                    'WAN Logo',
                  ),
                  leading: Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: badges.Badge(
                        position:
                            badges.BadgePosition.bottomEnd(bottom: -6, end: -3),
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: Colors.grey.shade200,
                        ),
                        badgeContent: const Icon(Icons.menu,
                            color: Colors.black, size: 10),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            color: Colors.white,
                            splashRadius: 20,
                            icon: const Center(child: Icon(Icons.person)),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                        ),
                      ),
                    );
                  }),
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
                  pinned: true,
                  elevation: 0,
                  expandedHeight: 220.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        Image.network(
                          'https://cdn.mos.cms.futurecdn.net/V6LCHNxfSPT2Sxpr4bAzD.jpg',
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(10),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 150,
                            onPageChanged: (index, carouselPageChangedReason) {
                              ctl.currentAds = index;
                              ctl.update();
                            },
                          ),
                          items: ctl.ads.map((e) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
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
                        const SizedBox(height: 20),
                        CardMenu(
                          height: 160,
                          title: "UPI Money Transfer",
                          children: [
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-plein-ecran-96.png"),
                              title: "Scan & pay",
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-carte-contact-96.png"),
                              title: "To Mobile or Contact",
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-facture-payee-96.png"),
                              title: "Factures",
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-entrepot-96.png"),
                              title: "Paiement loyer",
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CardMenu(
                          height: 160,
                          title: "UPI Money Transfer",
                          children: [
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-plein-ecran-96.png"),
                              title: "Scan & pay",
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-carte-contact-96.png"),
                              title: "To Mobile or Contact",
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-facture-payee-96.png"),
                              title: "Factures",
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-entrepot-96.png"),
                              title: "Paiement loyer",
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CardMenu(
                          height: 160,
                          title: "UPI Money Transfer",
                          children: [
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-plein-ecran-96.png"),
                              title: "Scan & pay",
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-carte-contact-96.png"),
                              title: "To Mobile or Contact",
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-facture-payee-96.png"),
                              title: "Factures",
                            ),
                            ButtonMenu(
                              icon: Image.asset(
                                  "assets/images/icons8-entrepot-96.png"),
                              title: "Paiement loyer",
                            ),
                          ],
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
