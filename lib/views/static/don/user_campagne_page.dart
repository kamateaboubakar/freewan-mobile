import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/don/don.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_outlined_button.dart';
import 'package:wan_mobile/tools/widgets/don/campagne_list_title.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/views/controllers/don/don_page_vctl.dart';
import 'package:wan_mobile/views/static/don/edition_campagne/edition_campagne_page.dart';

class UserCampagnePage extends StatelessWidget {
  final DonPageVctl ctl;
  const UserCampagnePage(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperBodyListView(
        listPadding: const EdgeInsets.all(10),
        loading: false,
        refreshButton: COutlinedButton(
          icon: const Icon(Icons.add),
          onPressed: () =>
              Get.to(() => const EditionCampagnePage())?.then((value) {
            ctl.userCampagne.add(
              Don(
                  title: "Campagne Projet",
                  nbDonationEnCours: 0,
                  nbDonationAttendu: 5000,
                  image: "assets/images/don/unsplash_GVg-x4MiriM.png"),
            );
            ctl.update();
          }),
          textColor: AssetColors.blue,
          child: const Text("Créer une campagne"),
        ),
        emptyText: "Aucune campagne",
        emptyWidget: Image.asset("assets/images/empty_content.png"),
        children: ctl.userCampagne.map((e) => CampagneListTile(e)).toList(),
      ),
    );
  }
}
