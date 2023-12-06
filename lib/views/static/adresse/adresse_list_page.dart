import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:wan_mobile/views/controllers/adresse/adresse_list_page_vctl.dart';
import 'package:wan_mobile/views/static/adresse/edition_adresse.dart';

class AdresseListPage extends StatelessWidget {
  const AdresseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdresseListPageVctl>(
      init: AdresseListPageVctl(),
      builder: (ctl) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Mes adresses"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Get.to(() => const EditionAdresse()),
            backgroundColor: AssetColors.blueButton,
            child: const Icon(Icons.add),
          ),
          body: WrapperBodyListView(
            loading: ctl.loading,
            onRefresh: ctl.getAdresses,
            children: ctl.adresses
                .map(
                  (e) => ListTile(
                    leading: CircleAvatar(
                      child: Image.asset(
                        "assets/images/icons/emplacement.png",
                        height: 30,
                      ),
                    ),
                    title: Text(e.libelle.value),
                    subtitle: Text(e.locationLabel.value),
                    onTap: () =>
                        Get.to(() => EditionAdresse(adresse: e))?.then((value) {
                      if (value != null) {
                        ctl.getAdresses();
                      }
                    }),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
