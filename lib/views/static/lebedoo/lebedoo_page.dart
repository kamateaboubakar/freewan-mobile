import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';

class LebedooPage extends StatelessWidget {
  const LebedooPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 45,
        backgroundColor: Colors.transparent,
        title: const Text("Lebedoo"),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            color: AssetColors.blueButton,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text(
                      50000.toAmount(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      "Total",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(
                              20000.toAmount(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: const Text(
                              "Mobile money",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const VerticalDivider(color: Colors.white),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              30000.toAmount(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: const Text(
                              "Carte bancaire",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    labelColor: AssetColors.blueButton,
                    tabs: [
                      Tab(
                        child: Text(
                          "Mobile money",
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Carte bancaire",
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ListView(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.wallet),
                              title: const Text("Moov money"),
                              subtitle: Text(12000.toAmount()),
                            ),
                            ListTile(
                              leading: const Icon(Icons.wallet),
                              title: const Text("Orange money"),
                              subtitle: Text(5000.toAmount()),
                            ),
                            ListTile(
                              leading: const Icon(Icons.wallet),
                              title: const Text("MTN money"),
                              subtitle: Text(3000.toAmount()),
                            ),
                          ],
                        ),
                        ListView(
                          children: [
                            ListTile(
                              leading:
                                  const Icon(Icons.card_membership_outlined),
                              title: const Text("Compte BNI"),
                              subtitle: Text(20000.toAmount()),
                            ),
                            ListTile(
                              leading:
                                  const Icon(Icons.card_membership_outlined),
                              title: const Text("Compte Société Générale"),
                              subtitle: Text(30000.toAmount()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
