import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools/types/double.dart';
import 'package:wan_mobile/models/don/campagne.dart';

import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:wan_mobile/views/static/donation/finalise_donation_page.dart';

class DetailDonationPage extends StatelessWidget {
  final Campagne campagne;
  const DetailDonationPage(this.campagne, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cause'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CButton(
          onPressed: () => Get.to(() => FinaliseDonPage(campagne)),
          height: 50,
          child: const Text("Donner"),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 283,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Center(
                  child: Image.network(
                    campagne.imageUrl.value,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(campagne.label.value),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: ListTile(
                dense: true,
                minLeadingWidth: 0,
                leading: Image.asset(
                  "assets/images/don/Vector.png",
                  width: 24,
                ),
                contentPadding: EdgeInsets.zero,
                title: Text(campagne.organization!.name.value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(campagne.description.value),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                              "${campagne.collectedAmount.toAmount(withDevise: false)}"
                              " sur ${campagne.amount.toAmount(withDevise: false)}")),
                      Text(
                        "${campagne.nbJourRestant} jours restants",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      minHeight: 8,
                      value: (campagne.amount == 0)
                          ? 0
                          : (campagne.collectedAmount.value /
                              campagne.amount.value),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * .4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${campagne.donorCount} ont donné",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: AssetColors.grey4,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Stack(
                              children: List.generate(
                                5,
                                (index) => Container(
                                  margin: EdgeInsets.only(
                                      left: (index * 20).toDouble()),
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundImage: AssetImage(
                                        "assets/images/don/Ellipse_$index.png"),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Get.width * .4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "Total Donation",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: AssetColors.grey4,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "F ${campagne.collectedAmount.toAmount(withDevise: false)}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
