import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/views/controllers/donation/organisation/organisation_page_vctl.dart';
import 'package:wan_mobile/views/static/donation/organisation/edition_organisation_page.dart';

class OrganisationPage extends StatelessWidget {
  const OrganisationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes organisations"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const EditionOrganisationPage()),
        backgroundColor: AssetColors.blueButton,
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<OrgnisationPageVctl>(
          init: OrgnisationPageVctl(),
          builder: (ctl) {
            return WrapperBodyListView(
              loading: ctl.loading,
              onRefresh: ctl.fetchOrganisations,
              children: ctl.organisations
                  .map(
                    (e) => ListTile(
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(e.logoUrl!)),
                      title: Text(e.name.value),
                      subtitle: Text(e.description.value, maxLines: 2),
                      onTap: () => Get.to(
                          () => EditionOrganisationPage(organisation: e)),
                    ),
                  )
                  .toList(),
            );
          }),
    );
  }
}
