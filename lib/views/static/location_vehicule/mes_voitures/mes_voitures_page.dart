import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/location_vehicule/card_vehicule.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body_gridview.dart';
import 'package:wan_mobile/views/controllers/location_vehicule/location_vehicule_vctl.dart';
import 'package:wan_mobile/views/static/location_vehicule/mes_voitures/edition_location/edition_location_vehicule.dart';

class MesVoituresPage extends StatelessWidget {
  final LocationVehiculeVclt ctl;
  const MesVoituresPage(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Get.to(() => const EditionLocationVehicule())?.then((value) {
          if (value is bool) {
            ctl.update();
          }
        }),
        backgroundColor: AssetColors.blueButton,
        child: const Icon(Icons.add),
      ),
      body: WrapperBodyGridView(
        childAspectRatio: .8,
        emptyText: "Aucun véhicule enregistré",
        error: ctl.userCarsError,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        emptyWidget: Image.asset("assets/images/empty_content.png"),
        onRefresh: ctl.fecthUserCars,
        loading: ctl.loadUserCars,
        children: ctl.userCars.map((e) => CardVehicule(e)).toList(),
      ),
    );
  }
}
