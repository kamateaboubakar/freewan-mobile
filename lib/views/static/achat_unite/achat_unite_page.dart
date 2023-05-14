import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/achat_unite/achat_unite_page_vctl.dart';

class AchatUnitePage extends StatelessWidget {
  const AchatUnitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AchatUnitePageVctl>(
        init: AchatUnitePageVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Achat Unités"),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20),
              child: CButton(
                onPressed: () {},
                height: 50,
                color: const Color.fromRGBO(13, 51, 159, 1),
                child: const Text(
                  "Confirmer",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 30),
                  child: Text(
                    "Sélectionner votre réseau",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    padding: const EdgeInsets.all(10),
                    childAspectRatio: 1,
                    children: [
                      "assets/images/Orange_logo.png",
                      "assets/images/Moov_Africa_logo.png",
                      "assets/images/Mtn-log.png",
                    ]
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              ctl.selectedReseau = e;
                              ctl.update();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  e,
                                  fit: BoxFit.cover,
                                  colorBlendMode: (ctl.selectedReseau == e)
                                      ? null
                                      : BlendMode.saturation,
                                  color: (ctl.selectedReseau == e)
                                      ? null
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: Column(
                      children: const [
                        CTextFormField(
                          labelText: "Numéro de téléphone",
                          require: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
