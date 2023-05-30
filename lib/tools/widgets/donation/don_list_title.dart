import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/don/campagne.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/static/donation/detail_campagne_page.dart';

class CampagneListTile extends StatelessWidget {
  final Campagne campagne;
  final bool forDisplay;
  final void Function()? onTap;
  const CampagneListTile(this.campagne,
      {this.onTap, this.forDisplay = false, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                  (forDisplay)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(10),
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
                            const Gap(10),
                            Text(
                              "${campagne.collectedAmount.toAmount(withDevise: false)}"
                              " sur ${campagne.amount.toAmount(withDevise: false)}",
                            ),
                            const Gap(10),
                          ],
                        )
                      : ListTile(
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
                            onPressed: () =>
                                Get.to(() => DetailDonationPage(campagne)),
                            child: const Text("Donner"),
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
