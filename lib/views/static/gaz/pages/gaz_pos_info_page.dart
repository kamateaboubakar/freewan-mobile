import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:tools_flutter_project/widgets/c_button.dart';
import 'package:wan_mobile/models/gas_purchase_action.dart';
import 'package:wan_mobile/models/shop.dart';
import 'package:wan_mobile/views/controllers/gaz/gas_format_vctl.dart';
import 'package:wan_mobile/views/controllers/gaz/gas_shop_vctl.dart';
import 'package:wan_mobile/views/controllers/gaz/gas_vctl.dart';
import 'package:wan_mobile/views/static/gaz/pages/gaz_delivery_map_page.dart';

import '../../../../tools/utils/brands_item.dart';
import '../../paiement/paiement_mode_paiement.dart';
import '../../paiement/paiement_operation_success.dart';
import '../widgets/brand_list_view.dart';

class GazPosInfoPage extends StatefulWidget {
  final ScrollController scrollController;
  final Function() togglePanel;

  const GazPosInfoPage(
    this.scrollController, {
    Key? key,
    required this.togglePanel,
  }) : super(key: key);

  @override
  State<GazPosInfoPage> createState() => _GazPosInfoPageState();
}

class _GazPosInfoPageState extends State<GazPosInfoPage> {
  GasController _gasController = Get.put(GasController());
  GasShopController _gasShopController = Get.put(GasShopController());
  GasFormatController _gasFormatController = Get.put(GasFormatController());

  Shop? _shop;

  @override
  void initState() {
    _shop = _gasController.shop;
    _gasShopController.reset();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _gasController.addListener(() {
        _shop = _gasController.shop;
        _getShopInfo();
      });
      if (_shop != null) {
        _getShopInfo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      controller: widget.scrollController,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  widget.togglePanel();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: screenWidth * 0.15,
                  height: 8,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _shop?.name ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset('assets/images/pin.png', width: 10),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              _shop?.address ?? '',
                              style: const TextStyle(
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
                    color: (_shop?.isOpen ?? false
                            ? AssetColors.green
                            : Colors.red)
                        .withOpacity(0.15),
                  ),
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    _shop?.isOpen ?? false ? 'Ouvert' : 'Fermé',
                    style: TextStyle(
                        color: _shop?.isOpen ?? false
                            ? const Color(0xff00853F)
                            : Colors.red,
                        fontSize: 12),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Image.asset(
                  "assets/images/gaz_info_image.png",
                  width: 100,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _shop?.description ?? "Aucune description",
                    style: const TextStyle(
                        color: AssetColors.blueGrey, fontSize: 10),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Marques vendues',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 20),
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
                              color:
                                  _gasShopController.isPurchaseActionSelected(
                                          GasPurchaseAction.recharger)
                                      ? AssetColors.blueButton
                                      : AssetColors.lightGrey2,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            padding: const EdgeInsets.all(8),
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
                              color:
                                  _gasShopController.isPurchaseActionSelected(
                                          GasPurchaseAction.acheter)
                                      ? AssetColors.blueButton
                                      : AssetColors.lightGrey2,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              'Acheter',
                              style: TextStyle(
                                color:
                                    _gasShopController.isPurchaseActionSelected(
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
            const SizedBox(height: 15),
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
                      const Text(
                        'Marques',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 10),
                      GridView.builder(
                        itemCount: brands.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                _gasShopController.updateSelectedBrand(brand);
                                _getGasFormat();
                              }
                            },
                            child: BrandsItem(
                              image: 'assets/images/${brand.pictureName}.png',
                              selected: selected,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Format de gaz',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 10),
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
                              return const Center(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      response.message,
                                      style: const TextStyle(fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                    const Icon(Icons.refresh),
                                  ],
                                ),
                              );
                            }

                            var formats = response.data!;

                            return GridView.builder(
                              itemCount: formats.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      childAspectRatio: 2 / 2.5),
                              itemBuilder: (context, index) {
                                var format = formats[index];
                                var selected = _gasShopController.gasSize?.id ==
                                    format.id!;
                                format.id!;
                                return InkWell(
                                  onTap: () {
                                    if (!selected) {
                                      _gasShopController.updateGasSize(format);
                                    }
                                  },
                                  child: BrandsItem(
                                    image:
                                        'assets/images/${format.pictureName}.png',
                                    label: format.name!,
                                    price: format.price!,
                                    selected: selected,
                                  ),
                                );
                              },
                            );
                          }),
                      const SizedBox(height: 15),
                      const Text(
                        'Localisation',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      GetBuilder(
                          init: _gasController,
                          builder: (controller) {
                            _gasController = controller;
                            String deliveryLocationName =
                                _gasController.deliveryLocationName;
                            return InkWell(
                              onTap: () {
                                Get.to(() => const GazDeliveryMapPage());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AssetColors.blueButton
                                        .withOpacity(0.15),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 18),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Utiliser cette localisation',
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                  'assets/images/pin.png',
                                                  width: 10),
                                              const SizedBox(width: 5),
                                              Expanded(
                                                child: Text(
                                                  deliveryLocationName,
                                                  style: const TextStyle(
                                                      color: AssetColors
                                                          .blueButton),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 12,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                      const SizedBox(height: 25),
                      CButton(
                        height: 50,
                        onPressed: () {
                          if (_gasShopController.isFormValid &&
                              _gasController.isLocationTypeSelected) {
                            _submitPayment();
                          }
                        },
                        color: _gasShopController.isFormValid &&
                                _gasController.isLocationTypeSelected
                            ? AssetColors.blueButton
                            : const Color(0xffEDF2F9),
                        child: Text(
                          "Payer",
                          style: TextStyle(
                            color: _gasShopController.isFormValid &&
                                    _gasController.isLocationTypeSelected
                                ? Colors.white
                                : const Color(0xffB5C4D8),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }

  _getShopInfo() {
    _gasShopController.getShopInfo(_shop?.id ?? 0);
  }

  void _getGasFormat() {
    var brandId = _gasShopController.brand!.id!;
    var shopId = _shop?.id ?? 0;
    _gasFormatController.getGasSize(shopId: shopId, brandId: brandId);
  }

  _submitPayment() async {
    var rep =
        await Tools.showChoiceMessage(message: "Confirmez-vous le paiement ?");
    if (rep == true) {
      var page = Get.currentRoute;
      await Get.to(
        () => PaiementModePaiement(
          route: page,
          motifPaiement: "Paiement de gaz",
          montant: _gasShopController.gasSize!.price!,
          frais: 0,
          service: "Paiement Gaz",
        ),
      );

      var result = Get.parameters['paiementResult'];
      if (result == "true") {
        _submitOrder();
      } else {
        Tools.messageBox(
            message: "Désolé, le paiement n'a pas pu être effectué.");
      }
    }
  }

  void _submitOrder() async {
    var pr = Tools.progressDialog(isDismissible: true);
    pr.show();
    var response = await _gasController.submitOrder(
      gasSize: _gasShopController.gasSize!,
      shop: _gasController.shop!,
      userlocation:
          _gasController.deliveryLocation ?? _gasController.userLocation!,
    );
    Get.back();
    if (!response.status) {
      Tools.messageBox(message: response.message);
      return;
    }

    Get.to(
      () => const PaiementOperationSucess(
        animationAsset: "assets/lotties/88063-delivery-icon.json",
        description: "Vous serez livrés dans les plus\nbrefs délais",
      ),
    );
  }
}
