import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/pressing/pressing.dart';
import 'package:module_master/module_master.dart';
import 'package:wan_mobile/views/controllers/pressing/pressing_services_vctl.dart';

import '../../../controllers/pressing/pressing_vctl.dart';

class PressingInfoPage extends StatefulWidget {
  final Function() showArticle;

  const PressingInfoPage({
    Key? key,
    required this.showArticle,
  }) : super(key: key);

  @override
  State<PressingInfoPage> createState() => _PressingInfoPageState();
}

class _PressingInfoPageState extends State<PressingInfoPage> {
  final PressingController _pressingController = Get.put(PressingController());

  PressingServiceController _pressingServiceController =
      Get.put(PressingServiceController());

  Pressing? _pressing;

  bool isOpen = false;

  @override
  void initState() {
    _pressing = _pressingController.pressing;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_pressing != null) {
        _getPressingServices();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      _pressing?.name ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset('assets/images/pin.png', width: 10),
                        const SizedBox(width: 5),
                        Text(
                          _pressing?.address ?? '',
                          style: const TextStyle(fontSize: 10),
                        ),
                        const SizedBox(width: 15),
                        Image.asset(
                          'assets/images/star.png',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 5),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: Color(0xff07153C),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(text: "0 "),
                              TextSpan(
                                text: "(22)",
                                style: TextStyle(
                                  color: Color(0xff7D8EA3),
                                ),
                              )
                            ],
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
                  /*color: (_pressing?.isOpen ?? false
                          ? AssetColors.green
                          : Colors.red)
                      .withOpacity(0.15),*/
                  color: AssetColors.green.withOpacity(0.15),
                ),
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: const Text(
                  //_pressing?.isOpen ?? false ? 'Ouvert' : 'Fermé',
                  'Ouvert',
                  style: TextStyle(
                    /* color: _pressing?.isOpen ?? false
                          ? const Color(0xff00853F)
                          : Colors.red,*/
                    color: Color(0xff00853F),
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  _pressing!.imageUrl,
                  width: 100,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, _, __) {
                    return const Placeholder(
                      fallbackWidth: 100,
                      fallbackHeight: 70,
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _pressing?.description ?? "Aucune description",
                  style: const TextStyle(
                      color: AssetColors.blueGrey, fontSize: 10),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Services',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          GetBuilder(
            init: _pressingServiceController,
            builder: (controller) {
              _pressingServiceController = controller;
              var response = _pressingServiceController.response;
              if (response == null) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!response.status) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(response.message),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _getPressingServices();
                        },
                        child: const Icon(Icons.refresh),
                      )
                    ],
                  ),
                );
              }

              var services = _pressingServiceController.response!.data ?? [];

              if (services.isEmpty) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(response.message),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _getPressingServices();
                        },
                        child: const Icon(Icons.refresh),
                      )
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 10);
                      },
                      itemBuilder: (context, index) {
                        var service = services[index];
                        return Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Image.network(
                                  service.imageUrl,
                                  width: 75,
                                  height: 75,
                                  errorBuilder: (context, _, __) {
                                    return const Placeholder(
                                      fallbackWidth: 50,
                                      fallbackHeight: 50,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Text(
                              service.name!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Color(0xff647892), fontSize: 12),
                            )
                          ],
                        );
                      },
                      itemCount: services.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: () {
                      widget.showArticle();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AssetColors.blueButton,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: const Text(
                        'Continuer',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          /*GetBuilder(
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
                        init: _pressingController,
                        builder: (controller) {
                          _pressingController = controller;
                          String deliveryLocationName =
                              _pressingController.deliveryLocationName;
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
                    const SizedBox(height: 15),
                    const Text(
                      'Paiement',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
                    PaiementAccountSelectionItem(
                      title: "**** **** **** **02",
                      onTap: () {},
                      image: 'assets/images/master_card.png',
                      imageWidth: 25,
                    ),
                    const SizedBox(height: 25),
                    CButton(
                      height: 50,
                      onPressed: () {
                        if (_gasShopController.isFormValid &&
                            _pressingController.isLocationTypeSelected) {
                          Get.to(() => const GazPaymentRecapPage());
                        }
                      },
                      color: _gasShopController.isFormValid &&
                              _pressingController.isLocationTypeSelected
                          ? AssetColors.blueButton
                          : const Color(0xffEDF2F9),
                      child: Text(
                        "Payer",
                        style: TextStyle(
                          color: _gasShopController.isFormValid &&
                                  _pressingController.isLocationTypeSelected
                              ? Colors.white
                              : const Color(0xffB5C4D8),
                        ),
                      ),
                    ),
                  ],
                );
              }),*/
        ],
      ),
    );
  }

  _getPressingServices() {
    _pressingServiceController.getPressingServices(_pressing?.id ?? 0);
  }
}
