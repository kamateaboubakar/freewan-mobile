import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_master/module_master.dart';
import 'package:wan_mobile/tools/types/types.dart';

import 'package:wan_mobile/views/controllers/home/categorized_home_vctl.dart';

class CategorizedHome extends StatefulWidget {
  const CategorizedHome({super.key});

  @override
  State<CategorizedHome> createState() => _CategorizedHomeState();
}

class _CategorizedHomeState extends State<CategorizedHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CategorizedHomeVctl>(
          init: CategorizedHomeVctl(),
          builder: (ctl) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          IconButton(
                            splashRadius: 20,
                            onPressed: () => Get.back(),
                            icon: const Icon(Icons.close),
                          ),
                          Expanded(
                            child: CTextFormField(
                              hintText: "Rechercher un service",
                              prefixIcon: const Icon(Icons.search),
                              onChanged: (value) {
                                ctl.search = value;
                                ctl.update();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 0),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              border: const Border(
                                right: BorderSide(width: .1),
                              ),
                            ),
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(height: 0),
                              itemBuilder: (context, index) => ListTile(
                                selected: ctl.selectedCategorie ==
                                    ctl.categories[index],
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  ctl.categories[index],
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {
                                  ctl.selectedCategorie = ctl.categories[index];
                                  ctl.update();
                                },
                              ),
                              itemCount: ctl.categories.length,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              children: (ctl.search.isNotEmpty)
                                  ? ctl.menuItems
                                      .where((e) => e.title.value
                                          .toLowerCase()
                                          .contains(ctl.search.toLowerCase()))
                                      .toList()
                                  : ctl.menuItems
                                      .where((e) =>
                                          e.categorie == ctl.selectedCategorie)
                                      .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
