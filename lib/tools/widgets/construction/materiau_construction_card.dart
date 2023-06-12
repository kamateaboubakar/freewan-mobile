import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/views/static/construction/detail_materiau_construction_page.dart';

class MateriauConstructionCard extends StatelessWidget {
  const MateriauConstructionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 156,
      decoration: BoxDecoration(
        border: Border.all(color: AssetColors.grey4, width: .5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => Get.to(() => const DetailMateriauConstructionPage()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 11),
                      child: Chip(
                        backgroundColor: AssetColors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        label: const Text(
                          "-30%",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                    "assets/images/empty-sea-beach-background-PhotoRoom 1.png",
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Sable de mer"),
                        Text(
                          "À partir de",
                          style: TextStyle(
                            color: AssetColors.blue2,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "15 000 F",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AssetColors.blueButton,
                          ),
                        ),
                        Text(
                          "18 000 F",
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: AssetColors.blue2,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
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
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuButton(
                          splashRadius: 12,
                          itemBuilder: (context) => [],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
