import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:wan_mobile/models/location_model.dart';
import 'package:wan_mobile/models/shop.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/views/controllers/gaz/gas_vctl.dart';
import '../../../../tools/utils/tools.dart';
import '../../../../tools/widgets/address_type_item.dart';
import '../../../../tools/widgets/c_button.dart';
import '../../../controllers/pressing/address_vctl.dart';
import '../../../controllers/pressing/pressing_vctl.dart';

class PressingDeliveryAddressPage extends StatefulWidget {
  const PressingDeliveryAddressPage({Key? key}) : super(key: key);

  @override
  State<PressingDeliveryAddressPage> createState() =>
      _PressingDeliveryAddressPageState();
}

class _PressingDeliveryAddressPageState
    extends State<PressingDeliveryAddressPage> {
  PressingController _pressingController = Get.put(PressingController());
  AddressController _addressController = Get.put(AddressController());

  final TextEditingController _locationNameCtrl = TextEditingController();

  final MapController _mapController = MapController();
  final double mapZoom = 16.2;
  int selectedLocationType = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Localisation"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          GetBuilder(
              init: _pressingController,
              builder: (controller) {
                _pressingController = controller;
                var userLocalisation = _pressingController.userLocalisation;
                return FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: userLocalisation != null ? LatLng(userLocalisation.latitude!, userLocalisation.longitude!) : null,
                    zoom: mapZoom,
                    onTap: (_, __) {}
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                  ],
                );
              }),
          GetBuilder(
            init: _pressingController,
            builder: (controller) {
              _pressingController = controller;
              var userLocalisation = _pressingController.userLocalisation;
              if(userLocalisation == null){
                return Container();
              }
              return Center(
                child: Image.asset(
                  'assets/images/pin_red.png',
                  width: 40,
                  height: 40,
                ),
              );
            }
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: GetBuilder(
              init: _pressingController,
              builder: (controller) {
                _pressingController = controller;
                var userLocalisation = _pressingController.userLocalisation;
                return Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Sélectionner la localisation',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AssetColors.darkBrown,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Votre localisation',
                        style:
                            TextStyle(color: Color(0xff9D9D9D), fontSize: 12),
                      ),
                      const SizedBox(height: 10),
                      GetBuilder(
                          init: _addressController,
                          id: 'userLocalisationView',
                          builder: (controller) {
                            _addressController = controller;
                            var response =
                                _addressController.userLocalisationResponse;
                            if (response == null) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (!response.status) {
                              return InkWell(
                                onTap: () {
                                  _getAddresses();
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

                            var items = response.data ?? [];

                            if (items.isEmpty) {
                              return Center(
                                child: Text('Aucune addresse'),
                              );
                            }

                            return InkWell(
                              onTap: () {
                                _showAddressesDialog();
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          userLocalisation?.address ??
                                              "Sélectionner l'adresse",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: AssetColors.blueButton,
                                      )
                                    ],
                                  ),
                                  Divider()
                                ],
                              ),
                            );
                          }),
                      const SizedBox(height: 10),
                      const Text(
                        'Sauvegarder comme',
                        style:
                            TextStyle(color: Color(0xff9D9D9D), fontSize: 12),
                      ),
                      /*const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: AddressTypeItem(
                              icon: 'assets/images/home_icon.png',
                              title: 'Maison',
                              selected: _gasController.isLocationTypeHome,
                              onTap: () {
                                _gasController.updateLocationType(1);
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: AddressTypeItem(
                              icon: 'assets/images/office_icon.png',
                              title: 'Bureau',
                              selected: _gasController.isLocationTypeOffice,
                              onTap: () {
                                _gasController.updateLocationType(2);
                              },
                            ),
                          )
                        ],
                      ),*/
                      const SizedBox(height: 20),
                      CButton(
                        height: 50,
                        onPressed: () {
                          if( _pressingController.hasUserLocalisation){
                            Get.back();
                          }
                        },
                        color: _pressingController.hasUserLocalisation
                            ? AssetColors.blueButton
                            : const Color(0xffEDF2F9),
                        child: Text(
                          "Enregistrer comme adresse",
                          style: TextStyle(
                            color: _pressingController.hasUserLocalisation
                                ? Colors.white
                                : const Color(0xffB5C4D8),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _getAddresses() {
    _addressController.getUserAddresses();
  }

  Future<dynamic> _showAddressesDialog() {
    return Tools.openModal(
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Color(0xffB5C4D8).withOpacity(0.15),
              padding: EdgeInsets.all(16),
              child: Text(
                'Séléctionner l\'adresse',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            GetBuilder(
              init: _addressController,
              builder: (controller) {
                _addressController = controller;
                var items = _addressController.userLocalisationResponse!.data ?? [];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0;
                    i < items.length;
                    i++) ...[
                      InkWell(
                        onTap: () {
                          _pressingController.updateUserLocalisation(
                              items[i]);
                          Get.back();
                          _mapController.move(LatLng(items[i].latitude!, items[i].longitude!), mapZoom);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    items[i].address!,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )),
                              if (_pressingController.userLocalisation != null && items[i].id ==
                                  _pressingController.userLocalisation!.id)
                                Image.asset(
                                  'assets/images/check.png',
                                  width: 20,
                                )
                            ],
                          ),
                        ),
                      ),
                      Divider()
                    ]
                  ],
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
