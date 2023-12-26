import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';

import 'package:wan_mobile/views/controllers/home/categorized_home_vctl.dart';
import 'package:wan_mobile/views/tools/routes.dart';

class CategorizedHome extends StatefulWidget {
  const CategorizedHome({super.key});

  @override
  State<CategorizedHome> createState() => _CategorizedHomeState();
}

class _CategorizedHomeState extends State<CategorizedHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Fonctionnalités")),
      body: GetBuilder<CategorizedHomeVctl>(
        init: CategorizedHomeVctl(),
        builder: (ctl) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CTextFormField(
                  hintText: "Rechercher un service",
                  prefixIcon: const Icon(Icons.search),
                  onChanged: (value) {
                    ctl.search = value;
                    ctl.update();
                  },
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
                                ctl.routes.groupes[index],
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 5),
                            title: Text(
                              Routes().groupes[index],
                              textAlign: TextAlign.center,
                            ),
                            onTap: () {
                              ctl.selectedCategorie = ctl.routes.groupes[index];
                              ctl.update();
                            },
                          ),
                          itemCount: ctl.routes.groupes.length,
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
                            crossAxisCount: 3,
                          ),
                          children: ((ctl.search.isEmpty)
                                  ? ctl.routes.routesByGroup(
                                      groupe: ctl.selectedCategorie)
                                  : ctl.routes.search(value: ctl.search.value))
                              .map((e) => e.button)
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
