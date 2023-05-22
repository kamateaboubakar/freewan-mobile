import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/account_selection_item.dart';
import 'package:wan_mobile/views/static/gaz/gaz_delivery_map_page.dart';
import 'package:wan_mobile/views/static/gaz/gaz_payment_recap_page.dart';

import '../../../tools/utils/brands_item.dart';
import '../../../tools/widgets/c_button.dart';
import '../../../tools/widgets/payment_account_selection_item.dart';

class GazPosInfoPage extends StatefulWidget {
  const GazPosInfoPage({Key? key}) : super(key: key);

  @override
  State<GazPosInfoPage> createState() => _GazPosInfoPageState();
}

class _GazPosInfoPageState extends State<GazPosInfoPage> {
  List<String> brands = [
    'assets/images/Logo-300-Blue-Full 1.png',
    'assets/images/oryx.png',
    'assets/images/oilibya 1.png',
    'assets/images/269_shell 1.png',
    'assets/images/Petroivoire 1.png',
    'assets/images/Logotype_Petroci 1.png',
  ];

  @override
  Widget build(BuildContext context) {
    List<String> formats = [
      'assets/images/b6.png',
      'assets/images/B12 1.png',
      'assets/images/b28.png',
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dépot de gaz',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset('assets/images/pin.png', width: 10),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  'Angré 22eme',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AssetColors.green.withOpacity(0.15),
                      ),
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Text(
                        'Ouvert',
                        style:
                            TextStyle(color: Color(0xff00853F), fontSize: 12),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/gaz_info_image.png",
                      width: 100,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Lorem ipsum dolor sit amet consectetur. Mi maecenas posuere malesuada eget. Id enim diam tortor venenatis aliquam varius libero tortor.",
                        style: TextStyle(
                            color: AssetColors.blueGrey, fontSize: 10),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Marques vendues',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 30,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: brands.length,
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      return Image.asset(
                        brands[index],
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AssetColors.lightGrey2,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: Text(
                          'Recharger',
                          style: TextStyle(color: AssetColors.grey3),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AssetColors.lightGrey2,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Acheter',
                          style: TextStyle(color: AssetColors.grey3),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  'Marques',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10),
                GridView.builder(
                  itemCount: brands.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.4),
                  itemBuilder: (context, index) {
                    return BrandsItem(
                      image: brands[index],
                      selected: index == 0,
                    );
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Format de gaz',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10),
                GridView.builder(
                  itemCount: formats.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 2 / 2.5),
                  itemBuilder: (context, index) {
                    return BrandsItem(
                      image: formats[index],
                      label: "B12",
                      selected: index == 2,
                    );
                  },
                ),
                SizedBox(height: 15),
                Text(
                  'Localisation',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Get.to(() => GazDeliveryMapPage());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AssetColors.blueButton.withOpacity(0.15),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Utiliser cette localisation',
                              ),
                              Row(
                                children: [
                                  Image.asset('assets/images/pin.png',
                                      width: 10),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      'Rue M66',
                                      style: TextStyle(
                                          color: AssetColors.blueButton),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Paiement',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10),
                PaiementAccountSelectionItem(
                  title: "**** **** **** **02",
                  onTap: () {},
                  image: 'assets/images/master_card.png',
                  imageWidth: 25,
                ),
                SizedBox(height: 25),
                CButton(
                  height: 50,
                  onPressed: () {
                    Get.to(() => GazPaymentRecapPage());
                  },
                  minWidth: double.infinity,
                  child: const Text("Payer"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
