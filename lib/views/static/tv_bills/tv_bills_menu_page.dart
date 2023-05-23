import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/views/static/paiement/paiement_mode_paiement.dart';
import 'package:wan_mobile/views/static/tv_bills/tv_bills_account_number_page.dart';
import 'package:wan_mobile/views/static/tv_bills/tv_bills_account_selection_page.dart';

import '../../../../tools/utils/asset_colors.dart';
import '../../../../tools/widgets/c_button.dart';

class TvBillsMenuPage extends StatefulWidget {
  @override
  State<TvBillsMenuPage> createState() => _TvBillsMenuPageState();
}

class _TvBillsMenuPageState extends State<TvBillsMenuPage> {
  List<String> options = [
    "Me réabonner",
    "Changer de formule",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Canal +"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (index == 0) {
                  Get.to(TvBillsAccountNumberPage());
                } else {
                  Get.to(TvBillsAccountSelectionPage());
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AssetColors.lightGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/canal+2.png",
                      width: 50,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        options[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 14,
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
          itemCount: options.length,
        ),
      ),
    );
  }
}
