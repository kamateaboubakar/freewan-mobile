import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/don/campagne.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/static/donation/detail_donation_page.dart';

class CampagneListTile extends StatelessWidget {
  final Campagne campagne;
  const CampagneListTile(this.campagne, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 13, right: 13),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: AssetColors.grey5, borderRadius: BorderRadius.circular(20)),
      height: 258,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:
                    Image.network(campagne.imageUrl.value, fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: true,
                  minVerticalPadding: 0,
                  minLeadingWidth: 0,
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(
                    campagne.label.value,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 0,
                  dense: true,
                  minLeadingWidth: 0,
                  leading: Image.asset(
                    "assets/images/don/Vector.png",
                    width: 24,
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(campagne.organization!.name.value),
                  trailing: CButton(
                    onPressed: () => Get.to(() => DetailDonationPage(campagne)),
                    child: const Text("Donner"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
