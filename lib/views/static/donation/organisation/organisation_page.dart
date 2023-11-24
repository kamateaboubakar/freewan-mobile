import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/controllers/donation/organisation/organisation_page_vctl.dart';
import 'package:wan_mobile/views/static/donation/organisation/edition_organisation_page.dart';

class OrganisationPage extends StatelessWidget {
  const OrganisationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrgnisationPageVctl>(
        init: OrgnisationPageVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Mes organisations"),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () =>
                  Get.to(() => const EditionOrganisationPage())?.then((value) {
                if (value is bool) {
                  ctl.fetchOrganisations();
                }
              }),
              backgroundColor: AssetColors.blueButton,
              child: const Icon(Icons.add),
            ),
            body: WrapperBodyListView(
              loading: ctl.loading,
              onRefresh: ctl.fetchOrganisations,
              children: ctl.organisations
                  .map(
                    (e) => ListTile(
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(e.logoUrl!)),
                      title: Text(e.name.value),
                      subtitle: Text(e.description.value, maxLines: 2),
                      onTap: () =>
                          Get.to(() => EditionOrganisationPage(organisation: e))
                              ?.then((value) {
                        if (value is bool) {
                          ctl.fetchOrganisations();
                        }
                      }),
                    ),
                  )
                  .toList(),
            ),
          );
        });
  }
}
