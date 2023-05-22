import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/gas_purchase_action.dart';
import 'package:wan_mobile/models/shop.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/account_selection_item.dart';
import 'package:wan_mobile/views/controllers/gaz/gas_format_vctl.dart';
import 'package:wan_mobile/views/controllers/gaz/gas_shop_vctl.dart';
import 'package:wan_mobile/views/controllers/gaz/gas_vctl.dart';
import 'package:wan_mobile/views/static/gaz/pages/gaz_delivery_map_page.dart';
import 'package:wan_mobile/views/static/gaz/pages/gaz_payment_recap_page.dart';

import '../../../../tools/utils/brands_item.dart';
import '../../../../tools/widgets/c_button.dart';
import '../../../../tools/widgets/payment_account_selection_item.dart';
import '../widgets/brand_list_view.dart';

class GazPosInfoPage extends StatefulWidget {
  const GazPosInfoPage({Key? key}) : super(key: key);

  @override
  State<GazPosInfoPage> createState() => _GazPosInfoPageState();
}

class _GazPosInfoPageState extends State<GazPosInfoPage> {
  GasController _gasController = Get.put(GasController());
  GasShopController _gasShopController = Get.put(GasShopController());
  GasFormatController _gasFormatController = Get.put(GasFormatController());

  late Shop _shop;

  @override
  void initState() {
    _shop = _gasController.shop!;
    _gasShopController.reset();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getShopInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                            _shop.name!,
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
                                  _shop.address ?? '',
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
                        color: (_shop.isOpen ? AssetColors.green : Colors.red)
                            .withOpacity(0.15),
                      ),
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Text(
                        _shop.isOpen ? 'Ouvert' : 'Fermé',
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
                        _shop.description ?? "Aucune description",
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
                GetBuilder(
                  init: _gasShopController,
                  builder: (controller) {
                    _gasShopController = controller;
                    var response = _gasShopController.shopInfoResponse;
                    return BrandList(
                      response: response,
                      retry: () {
                        _getShopInfo();
                      },
                    );
                  },
                ),
                SizedBox(height: 20),
                GetBuilder(
                    init: _gasShopController,
                    builder: (controller) {
                      _gasShopController = controller;
                      var brands = _gasShopController.brands;
                      if (brands.isEmpty) {
                        return Container();
                      }
                      return Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _gasShopController.updatePurchaseAction(
                                  GasPurchaseAction.recharger,
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _gasShopController
                                          .isPurchaseActionSelected(
                                              GasPurchaseAction.recharger)
                                      ? AssetColors.blueButton
                                      : AssetColors.lightGrey2,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                padding: EdgeInsets.all(8),
                                alignment: Alignment.center,
                                child: Text(
                                  'Recharger',
                                  style: TextStyle(
                                      color: _gasShopController
                                              .isPurchaseActionSelected(
                                                  GasPurchaseAction.recharger)
                                          ? Colors.white
                                          : AssetColors.grey3),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _gasShopController.updatePurchaseAction(
                                    GasPurchaseAction.acheter);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _gasShopController
                                          .isPurchaseActionSelected(
                                              GasPurchaseAction.acheter)
                                      ? AssetColors.blueButton
                                      : AssetColors.lightGrey2,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'Acheter',
                                  style: TextStyle(
                                    color: _gasShopController
                                            .isPurchaseActionSelected(
                                                GasPurchaseAction.acheter)
                                        ? Colors.white
                                        : AssetColors.grey3,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                SizedBox(height: 15),
                GetBuilder(
                    init: _gasShopController,
                    builder: (controller) {
                      _gasShopController = controller;
                      var isPurchaseActionSelected =
                          _gasShopController.hasPurchaseActionSelected;
                      if (!isPurchaseActionSelected) {
                        return Container();
                      }
                      var brands = _gasShopController.brands;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Marques',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 10),
                          GridView.builder(
                            itemCount: brands.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 1.4),
                            itemBuilder: (context, index) {
                              var brand = brands[index];
                              var selected =
                                  brand.id == _gasShopController.brand?.id;
                              return InkWell(
                                onTap: () {
                                  if (!selected) {
                                    _gasShopController
                                        .updateSelectedBrand(brand);
                                    _getGasFormat();
                                  }
                                },
                                child: BrandsItem(
                                  image:
                                      'assets/images/${brand.pictureName}.png',
                                  selected: selected,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Format de gaz',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 10),
                          GetBuilder(
                              init: _gasFormatController,
                              builder: (controller) {
                                _gasFormatController = controller;
                                var brand = _gasShopController.brand;
                                var response = _gasFormatController.response;

                                if (brand == null) {
                                  return Container();
                                }

                                if (response == null) {
                                  return Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }

                                if (!response.status) {
                                  return InkWell(
                                    onTap: () {
                                      _getGasFormat();
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          response.message,
                                          style: TextStyle(fontSize: 12),
                                          textAlign: TextAlign.center,
                                        ),
                                        Icon(Icons.refresh),
                                      ],
                                    ),
                                  );
                                }

                                var formats = response.data!;

                                return GridView.builder(
                                  itemCount: formats.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                          childAspectRatio: 2 / 2.5),
                                  itemBuilder: (context, index) {
                                    var format = formats[index];
                                    var selected =
                                        _gasShopController.gasSize?.id ==
                                            format.id!;
                                    format.id!;
                                    return InkWell(
                                      onTap: () {
                                        if (!selected) {
                                          _gasShopController
                                              .updateGasSize(format);
                                        }
                                      },
                                      child: BrandsItem(
                                        image:
                                            'assets/images/${format.pictureName}.png',
                                        label: format.name!,
                                        selected: selected,
                                      ),
                                    );
                                  },
                                );
                              }),
                          SizedBox(height: 15),
                          Text(
                            'Localisation',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 10),
                          GetBuilder(
                              init: _gasController,
                              builder: (controller) {
                                _gasController = controller;
                                String deliveryLocationName =
                                    _gasController.deliveryLocationName;
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => GazDeliveryMapPage());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AssetColors.blueButton
                                            .withOpacity(0.15),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 18),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Utiliser cette localisation',
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                      'assets/images/pin.png',
                                                      width: 10),
                                                  SizedBox(width: 5),
                                                  Expanded(
                                                    child: Text(
                                                      deliveryLocationName,
                                                      style: TextStyle(
                                                          color: AssetColors
                                                              .blueButton),
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
                                );
                              }),
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
                              if (_gasShopController.isFormValid) {
                                Get.to(() => GazPaymentRecapPage());
                              }
                            },
                            color: _gasShopController.isFormValid
                                ? AssetColors.blueButton
                                : Color(0xffEDF2F9),
                            child: Text(
                              "Payer",
                              style: TextStyle(
                                color: _gasShopController.isFormValid
                                    ? Colors.white
                                    : Color(0xffB5C4D8),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getShopInfo() {
    _gasShopController.getShopInfo(_shop.id!);
  }

  void _getGasFormat() {
    var brandId = _gasShopController.brand!.id!;
    var shopId = _shop.id!;
    _gasFormatController.getGasSize(shopId: shopId, brandId: brandId);
  }
}
