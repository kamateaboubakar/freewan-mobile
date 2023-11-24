import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/models/construction/categorie_materiau_construction.dart';
import 'package:wan_mobile/tools/widgets/c_outlined_button.dart';
import 'package:wan_mobile/tools/widgets/construction/materiau_construction_card.dart';
import 'package:wan_mobile/views/static/construction/bottom_construction_filter_page.dart';
import 'package:wan_mobile/views/static/construction/panier_materiau_construction_page.dart';

class DetailCategorieMateriauConstructionPage extends StatelessWidget {
  final CategorieMateriauConstruction categorie;
  const DetailCategorieMateriauConstructionPage(this.categorie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catégorie"),
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
        child: COutlinedButton(
          height: 50,
          onPressed: () =>
              Tools.openBottomSheet(const BottomConstructionFilterPage()),
          textColor: AssetColors.blueButton,
          child: const Text("Filtrer & Trier"),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                categorie.label.value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AssetColors.blueButton,
                ),
              ),
            ),
            const Gap(20),
            const CTextFormField(
              hintText: "Chercher un produit",
              suffixIcon: Icon(Icons.search),
            ),
            const Gap(20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: .55,
              crossAxisSpacing: 6,
              mainAxisSpacing: 11,
              children: List.generate(
                10,
                (index) => const MateriauConstructionCard(),
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
