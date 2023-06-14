import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_outlined_button.dart';
import 'package:wan_mobile/tools/widgets/construction/materiau_construction_card.dart';
import 'package:wan_mobile/tools/widgets/quantity_field.dart';
import 'package:wan_mobile/views/static/construction/list_avis_materiau_construction.dart';
import 'package:wan_mobile/views/static/construction/panier_materiau_construction_page.dart';

class DetailMateriauConstructionPage extends StatelessWidget {
  const DetailMateriauConstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails du produit"),
        actions: [
          IconButton(
            onPressed: () =>
                Get.to(() => const PanierMateriauConstructionPage()),
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: COutlinedButton(
                height: 50,
                onPressed: () {},
                child: const Icon(
                  Icons.home_filled,
                  color: AssetColors.blueButton,
                  size: 22.8,
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: COutlinedButton(
                height: 50,
                onPressed: () {},
                child: const Icon(
                  Icons.file_download_outlined,
                  color: AssetColors.blueButton,
                  size: 22.8,
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              flex: 3,
              child: CButton(
                height: 50,
                onPressed: () => Tools.openBottomSheet(
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(children: [
                              const ListTile(
                                title: Text("Ajouter au panier"),
                                trailing: CloseButton(),
                              ),
                              const Divider(),
                              const ListTile(
                                title: Text("Quantité (Botte)"),
                                trailing: QuantityField(isPositive: true),
                              ),
                              const Divider(),
                              ListTile(
                                title: const Text("Total"),
                                subtitle: const Text(
                                  "15 000 F",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AssetColors.blueButton,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [],
                                ),
                              ),
                            ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: CButton(
                            height: 50,
                            minWidth: double.infinity,
                            onPressed: () {},
                            child: const Text("Ajouter au panier"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add_shopping_cart),
                    Gap(10),
                    Text("Acheter"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/empty-sea-beach-background-PhotoRoom 1.png",
              fit: BoxFit.cover,
              height: 280,
              width: double.infinity,
            ),
            const Gap(30),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Sable"),
            ),
            Wrap(
              spacing: 10,
              children: const [
                Text(
                  "F 15 000",
                ),
                Text(
                  "F 18 000",
                ),
                Text(
                  "-30%",
                ),
              ],
            ),
            const Gap(11),
            Row(
              children: const [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 10,
                ),
                Gap(5),
                Text(
                  "4.6 | 86 Avis",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Divider(),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Description du Produit",
              ),
            ),
            const ReadMoreText(
              "Lorem ipsum dolor sit amet consectetur. Tincidunt semper fames "
              "mollis nisi vitae orci ullamcorper. kjhoh kbkbk Sit non dolor "
              "rhoncus lorem aliquam ac varius curabitur condimentum",
              trimLines: 2,
              trimMode: TrimMode.Line,
              moreStyle: TextStyle(fontSize: 14, color: AssetColors.blueButton),
              lessStyle: TextStyle(fontSize: 14, color: AssetColors.blueButton),
              trimCollapsedText: "Voir plus",
              trimExpandedText: " Voir moins",
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Avis (86)"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 10,
                  ),
                  Gap(5),
                  Text(
                    "4.6",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ...List.generate(
              3,
              (index) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/Rectangle 318.png"),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Yelena Belova"),
                    RatingBarIndicator(
                      rating: 2.75,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 11.67,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
                subtitle: const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing"
                    " elit, sed do eiusmod tempor incididunt ut labore et dolore "
                    "magna aliqua."),
                trailing: const Text("15 Mai 2023"),
              ),
            ),
            const Gap(20),
            COutlinedButton(
              height: 50,
              minWidth: double.infinity,
              onPressed: () =>
                  Get.to(() => const ListAvisMateriauConstruction()),
              child: const Text(
                "Voir tous les avis",
                style: TextStyle(color: AssetColors.blueButton),
              ),
            ),
            const Gap(20),
            const Divider(),
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage(
                    "assets/images/c4416d79eef6dd018bcee3cd8b8ba561_M 1.png"),
              ),
              contentPadding: EdgeInsets.zero,
              title: const Text("SOTACI"),
              subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text("Boutique Officielle"),
                  Gap(5),
                  Icon(
                    Icons.assured_workload,
                    size: 14.17,
                    color: AssetColors.blueButton,
                  ),
                ],
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 12,
              ),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Produits similaires",
              ),
            ),
            SizedBox(
              height: 310,
              child: ListView.separated(
                separatorBuilder: (context, index) => const Gap(16),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, i) => const MateriauConstructionCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
