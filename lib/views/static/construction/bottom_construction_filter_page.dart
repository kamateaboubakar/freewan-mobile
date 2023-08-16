import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:module_master/module_master.dart';
import 'package:module_master/module_master.dart';

class BottomConstructionFilterPage extends StatelessWidget {
  const BottomConstructionFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            ListTile(
              title: const Text(
                "Filtrer & Trier",
              ),
              trailing: CloseButton(
                onPressed: () => Get.back(),
              ),
            ),
            const TabBar(
              labelColor: AssetColors.blueButton,
              indicatorColor: AssetColors.blueButton,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(text: "Filtre"),
                Tab(text: "Tri"),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(children: [
                      ListView(
                        children: [
                          const Gap(10),
                          const ListTile(title: Text("Intervalle de prix")),
                          RangeSlider(
                            labels: const RangeLabels("5000", "20000"),
                            inactiveColor: AssetColors.blueButton,
                            activeColor: AssetColors.blueButton,
                            max: 100000,
                            min: 5000,
                            divisions: 100,
                            values: const RangeValues(5000, 20000),
                            onChanged: (value) {},
                          ),
                          const Divider(),
                          ...List.generate(
                            5,
                            (index) => CheckboxListTile(
                              value: false,
                              title: Text("Element $index"),
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        children: [
                          "Nom (A-Z)",
                          "Prix (Du plus élevé au plu petit)",
                          "Price (Du plus petit au plus élevé)"
                        ]
                            .map(
                              (e) => CheckboxListTile(
                                title: Text(e),
                                value: false,
                                onChanged: (value) {},
                              ),
                            )
                            .toList(),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: COutlinedButton(
                            onPressed: () => Get.back(),
                            height: 50,
                            textColor: AssetColors.blueButton,
                            child: const Text("Annuler"),
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: CButton(
                            onPressed: () => Get.back(),
                            height: 50,
                            child: const Text("Appliquer"),
                          ),
                        )
                      ],
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
