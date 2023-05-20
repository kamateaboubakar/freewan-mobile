import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:wan_mobile/models/don/categorie_don.dart';
import 'package:wan_mobile/models/don/don.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/don/don_list_title.dart';
import 'package:wan_mobile/views/controllers/don/don_page_vctl.dart';
import 'package:wan_mobile/views/static/don/detail_don_page.dart';

class DonListPage extends StatelessWidget {
  final DonPageVctl ctl;
  const DonListPage(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              crossAxisCount: 4,
              childAspectRatio: .75,
              children: [
                CategorieDon(
                  libelle: "Santé",
                  image: "assets/images/don/sante.png",
                ),
                CategorieDon(
                  libelle: "Education",
                  image: "assets/images/don/education.png",
                ),
                CategorieDon(
                  libelle: "Animaux",
                  image: "assets/images/don/animaux.png",
                ),
                CategorieDon(
                  libelle: "voir tout",
                  image: "assets/images/don/tout.png",
                ),
              ]
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
                            child: Image.asset(e.image!, width: 18, height: 19),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            e.libelle.value,
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
            Column(
              children: [
                Don(
                  image: "assets/images/don/unsplash_GVg-x4MiriM.png",
                  title: "Donner aux orphelins",
                  receiver: "Orphelinat Bingerville",
                ),
                Don(
                  image: "assets/images/don/unsplash_M74Pihi2vz8.png",
                  title: "Sauvons la vie de Donnie",
                  receiver: "Donnie",
                ),
              ]
                  .map(
                    (e) => DonListTile(
                      e,
                      onPressed: () => Get.to(() => DetailDonPage(e)),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
