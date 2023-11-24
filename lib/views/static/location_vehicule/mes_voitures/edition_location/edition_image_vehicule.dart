import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/widgets/c_outlined_button.dart';
import 'package:wan_mobile/views/controllers/location_vehicule/edition_location_vehicule_vctl.dart';

class EditionImageVehicule extends StatelessWidget {
  final EditionLocationVehiculeVctl ctl;
  const EditionImageVehicule(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Column(
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            tooltip: "Ouvrir l'appareil photo",
            backgroundColor: AssetColors.blueButton,
            onPressed: () async {
              var image = await Tools.pickImage();
              if (image != null) {
                ctl.images.add(image.path);
                ctl.update();
              }
            },
            child: const Icon(Icons.camera_alt_rounded),
          ),
          const Gap(20),
          FloatingActionButton(
            heroTag: "btn2",
            tooltip: "Ouvrir la galérie",
            onPressed: () async {
              // var images = await Tools.pickMultipleImage();
              // if (ctl.images.isNotEmpty) {
              //   ctl.images.addAll(images.map((e) => e.path).toList());
              // } else {
              //   ctl.images = images.map((e) => e.path).toList();
              // }
              // ctl.update();
            },
            backgroundColor: AssetColors.blueButton,
            child: const Icon(Icons.add_to_photos_rounded),
          ),
          const Gap(20),
          Visibility(
            visible: ctl.images.length > 1,
            child: FloatingActionButton(
              tooltip: "Ouvrir la galérie",
              onPressed: () async {
                var rep = await Tools.showChoiceMessage(
                    message: "Voulez-vous supprimer toutes  les images ?");
                if (rep == true) {
                  ctl.images.clear();
                  ctl.update();
                }
              },
              backgroundColor: AssetColors.blueButton,
              child: const Icon(Icons.delete),
            ),
          ),
        ],
      ),
      body: Form(
        child: Column(
          children: [
            Expanded(
              child: GridView(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 5,
                ),
                children: ctl.images
                    .map(
                      (e) => Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(
                            File(e),
                            fit: BoxFit.cover,
                          ),
                          Align(
                            alignment: const Alignment(-1.1, -1.1),
                            child: MaterialButton(
                              height: 20,
                              minWidth: 20,
                              color: AssetColors.blueButton,
                              shape: const CircleBorder(),
                              textColor: Colors.white,
                              onPressed: () async {
                                var rep = await Tools.showChoiceMessage(
                                    message: "Voulez-vous supprimer l'image ?");
                                if (rep == true) {
                                  ctl.images.remove(e);
                                  ctl.update();
                                }
                              },
                              child: const Icon(
                                Icons.close,
                                size: 13,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  COutlinedButton(
                    height: 50,
                    child: const Icon(Icons.arrow_back),
                    onPressed: () => ctl.pageController.jumpToPage(1),
                  ),
                  const Gap(10),
                  Expanded(
                    child: CButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: ctl.submit,
                      child: const Text("Lister la voiture"),
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
