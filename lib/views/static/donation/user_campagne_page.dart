import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_outlined_button.dart';
import 'package:wan_mobile/tools/widgets/donation/don_list_title.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/views/controllers/donation/donation_page_vctl.dart';
import 'package:wan_mobile/views/static/donation/detail_donation_page.dart';
import 'package:wan_mobile/views/static/donation/edition_campagne/edition_campagne_page.dart';

class UserCampagnePage extends StatelessWidget {
  final DonationPageVctl ctl;
  const UserCampagnePage(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperBodyListView(
        listPadding: const EdgeInsets.all(10),
        loading: ctl.loadUserCampagne,
        refreshButton: Column(
          children: [
            COutlinedButton(
              icon: const Icon(Icons.add),
              onPressed: () =>
                  Get.to(() => EditionCampagnePage(ctl.categories)),
              textColor: AssetColors.blue,
              child: const Text("Créer une campagne"),
            ),
            const SizedBox(height: 10),
            CButton(
              onPressed: () => ctl.fetchUserCampagnes(),
              child: const Text("Actualiser la page"),
            )
          ],
        ),
        emptyText: "Aucune campagne",
        emptyWidget: Image.asset("assets/images/empty_content.png"),
        children: ctl.userCampagne.map((e) => CampagneListTile(e)).toList(),
      ),
    );
  }
}
