import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/widgets/construction/materiau_construction_card.dart';
import 'package:wan_mobile/views/controllers/construction/construction_page_vctl.dart';
import 'package:wan_mobile/views/static/construction/detail_categorie_materiau_construction_page.dart';
import 'package:wan_mobile/views/static/construction/panier_materiau_construction_page.dart';

class ConstructionPage extends StatelessWidget {
  const ConstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConstructionPageVctl>(
        init: ConstructionPageVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Trouvez vos matériaux"),
              actions: [
                IconButton(
                  onPressed: () =>
                      Get.to(() => const PanierMateriauConstructionPage()),
                  icon: const Icon(Icons.shopping_cart),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CTextFormField(
                    hintText: "Chercher un produit",
                    suffixIcon: const Icon(Icons.search),
                    onTap: () {},
                  ),
                  const Gap(20),
                  ImageSlideshow(
                    isLoop: true,
                    autoPlayInterval: 6000,
                    height: 148,
                    children: [
                      "https://img.freepik.com/photos-gratuite/construction-nouvelles-maisons-beton_1398-3932.jpg?w=1800&t=st=1686561919~exp=1686562519~hmac=40cc2b0496fdb2b58675abb79229c8bd304943bc785c7196660bfd704b62b3df",
                      "https://img.freepik.com/photos-gratuite/travailleurs-qui-examinent-travail_1122-970.jpg?1&w=1800&t=st=1686562024~exp=1686562624~hmac=d6b71c4f709b886072e438120e0afeaffb1ea8c78ee6ce3a3d73f30f4ce7888a"
                    ]
                        .map(
                          (e) => ClipRRect(
                            borderRadius: BorderRadius.circular(13),
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
                  const Gap(53),
                  SizedBox(
                    height: 125,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Gap(10),
                      scrollDirection: Axis.horizontal,
                      itemCount: ctl.categories.length,
                      itemBuilder: (context, i) => GestureDetector(
                        onTap: () => Get.to(() =>
                            DetailCategorieMateriauConstructionPage(
                                ctl.categories[i])),
                        child: Container(
                          width: 78,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AssetColors.blueButton.withOpacity(.3),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(
                                      5,
                                    )),
                                    child: Image.network(
                                      ctl.categories[i].imageUrl.value,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    ctl.categories[i].label.value,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AssetColors.grey3,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(34),
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Offres Spéciales",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AssetColors.blueButton,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 310,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Gap(16),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, i) =>
                          const MateriauConstructionCard(),
                    ),
                  ),
                  const Gap(34),
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Les mieux notés",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AssetColors.blueButton,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 310,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Gap(16),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, i) =>
                          const MateriauConstructionCard(),
                    ),
                  ),
                  const Gap(34),
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Nouveaux",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AssetColors.blueButton,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 310,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Gap(16),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, i) =>
                          const MateriauConstructionCard(),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
