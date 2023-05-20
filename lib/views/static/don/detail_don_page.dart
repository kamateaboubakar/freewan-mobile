import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/don/don.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/static/don/finalise_don_page.dart';

class DetailDonPage extends StatelessWidget {
  final Don don;
  const DetailDonPage(this.don, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cause'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CButton(
          onPressed: () => Get.to(() => FinaliseDonPage(don)),
          height: 50,
          child: const Text("Donner"),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 283,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(don.image.value, fit: BoxFit.cover)),
            ),
            ListTile(
              title: Text(don.title.value),
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
                title: Text(don.receiver.value),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("We accomplish this through "
                  "our unique network of health professionals "
                  "and orga nization committed to improving health "
                  "policies and practices, Isha Foundation is a nonprofit "
                  "providing life saving medical care to children aims at "
                  "creating a long and +plus"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Expanded(child: Text("345 600 sur 500 000")),
                      Text(
                        "2 jours restants",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const LinearProgressIndicator(
                      minHeight: 8,
                      value: .65,
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
                            const Text(
                              "2000+ ont donné",
                              style: TextStyle(
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
                          children: const [
                            Text(
                              "Total Donation",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: AssetColors.grey4,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "F 345600",
                              textAlign: TextAlign.end,
                              style: TextStyle(
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
