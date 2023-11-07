import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
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
                            selected:
                                ctl.selectedCategorie == Routes.groupes[index],
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              Routes.groupes[index],
                              textAlign: TextAlign.center,
                            ),
                            onTap: () {
                              ctl.selectedCategorie = Routes.groupes[index];
                              ctl.update();
                            },
                          ),
                          itemCount: Routes.groupes.length,
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
                                  ? Routes.routesByGroup(
                                      groupe: ctl.selectedCategorie)
                                  : Routes.search(value: ctl.search.value))
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
