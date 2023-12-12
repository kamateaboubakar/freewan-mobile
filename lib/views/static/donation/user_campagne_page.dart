import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/widgets/donation/don_list_title.dart';
import 'package:wan_mobile/views/controllers/donation/donation_page_vctl.dart';
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
        onRefresh: ctl.fetchUserCampagnes,
        // refreshButton: Column(
        //   children: [
        //     COutlinedButton(
        //       icon: const Icon(Icons.add),
        //       onPressed: () =>
        //           Get.to(() => const EditionCampagnePage())?.then((value) {
        //         if (value is bool) {
        //           ctl.fetchData();
        //         }
        //       }),
        //       textColor: AssetColors.blue,
        //       child: const Text("Créer une campagne"),
        //     ),
        //     const SizedBox(height: 10),
        //     CButton(
        //       onPressed: () => ctl.fetchUserCampagnes(),
        //       child: const Text("Actualiser la page"),
        //     )
        //   ],
        // ),
        // emptyText: "Aucune campagne",
        emptyWidget: Image.asset("assets/images/empty_content.png"),
        children: ctl.userCampagnes
            .map(
              (e) => CampagneListTile(
                e,
                forDisplay: true,
                onTap: () => Get.to(() => EditionCampagnePage(campagne: e))
                    ?.then((value) {
                  if (value is bool) {
                    ctl.fetchData();
                  }
                }),
              ),
            )
            .toList(),
      ),
    );
  }
}
