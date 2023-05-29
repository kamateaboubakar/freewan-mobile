import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/donation/don_list_title.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/views/controllers/donation/donation_page_vctl.dart';
import 'package:wan_mobile/views/static/donation/detail_donation_page.dart';

class DonationListPage extends StatelessWidget {
  final DonationPageVctl ctl;
  const DonationListPage(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Visibility(
              visible: ctl.categories.isNotEmpty,
              child: GridView.count(
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                crossAxisCount: 4,
                childAspectRatio: .75,
                children: ctl.categories
                    .map(
                      (e) => Column(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: AssetColors.grey6,
                              elevation: 0,
                              hoverElevation: 0,
                              highlightElevation: 0,
                              onPressed: () {},
                              child: (!e.isAllOption)
                                  ? Image.network(e.iconUrl!)
                                  : Image.asset(e.iconUrl!,
                                      width: 25, height: 25),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              e.label.value,
                              style: const TextStyle(
                                color: AssetColors.grey3,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: WrapperBodyListView(
                loading: ctl.loadAllCampagne,
                onRefresh: ctl.fetchCampagnes,
                emptyText: "Aucune campagne",
                emptyWidget: Image.asset("assets/images/empty_content.png"),
                children:
                    ctl.campagnes.map((e) => CampagneListTile(e)).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
