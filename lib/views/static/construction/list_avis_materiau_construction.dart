import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rating_summary/rating_summary.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/static/construction/panier_materiau_construction_page.dart';

class ListAvisMateriauConstruction extends StatelessWidget {
  const ListAvisMateriauConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Avis produit"),
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
            const RatingSummary(
              label: "Avis",
              counter: 13,
              average: 3.846,
              showAverage: true,
              counterFiveStars: 5,
              counterFourStars: 4,
              counterThreeStars: 2,
              counterTwoStars: 1,
              counterOneStars: 1,
            ),
            const Gap(20),
            ...List.generate(
              13,
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
          ],
        ),
      ),
    );
  }
}
