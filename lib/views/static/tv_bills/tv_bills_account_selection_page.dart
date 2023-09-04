import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/views/static/tv_bills/tv_bills_forumla_list_page.dart';

import '../../../tools/widgets/account_selection_item.dart';
import '../bills/widgets/add_account_button.dart';

class TvBillsAccountSelectionPage extends StatelessWidget {
  final String route;
  const TvBillsAccountSelectionPage({required this.route, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Choix du compte"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AccountSelectionItem(
              title: "144545266",
              image: "assets/images/Canal+1.png",
              imageWidth: 25,
              onTap: () {
                Get.to(() => TvBillsFormulaListPage(route: route));
              },
            ),
            AddAccountButton(
              title: "Payer pour un autre compte",
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
