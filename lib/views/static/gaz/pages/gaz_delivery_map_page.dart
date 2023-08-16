import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:wan_mobile/models/location_model.dart';
import 'package:wan_mobile/models/shop.dart';
import 'package:module_master/module_master.dart';
import 'package:wan_mobile/views/controllers/gaz/gas_vctl.dart';
import '../../../../tools/widgets/address_type_item.dart';

class GazDeliveryMapPage extends StatefulWidget {
  const GazDeliveryMapPage({Key? key}) : super(key: key);

  @override
  State<GazDeliveryMapPage> createState() => _GazDeliveryMapPageState();
}

class _GazDeliveryMapPageState extends State<GazDeliveryMapPage> {
  GasController _gasController = Get.put(GasController());

  late LocationModel deliveryLocation;
  final TextEditingController _locationNameCtrl = TextEditingController();
  Timer? locationDescriptionTimer;
  late Shop shop;

  final MapController _mapController = MapController();
  final double mapZoom = 16.2;
  int selectedLocationType = -1;

  @override
  void initState() {
    deliveryLocation =
        _gasController.deliveryLocation ?? _gasController.userLocation!;
    _locationNameCtrl.text = deliveryLocation.title;
    shop = _gasController.shop!;
    super.initState();
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
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: deliveryLocation.toLatLng(),
              zoom: mapZoom,
              onTap: (_, __) {
                /*if (!hasNoGazPosSelected) {
                    setState(() {
                      selectedGazPosIndex = noSelectionIndex;
                    });
                  }*/
              },
              onPositionChanged: (mapPosition, _) {
                cancelLocationDescriptionTimer();
                startLocationDescriptionSearch(mapPosition);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(shop.latitude!, shop.longitude!),
                    builder: (context) => Image.asset(
                      'assets/images/gaz_pin.png',
                      width: 40,
                      height: 40,
                    ),
                  )
                ],
              ),
            ],
          ),
          Center(
            child: Image.asset(
              'assets/images/pin_red.png',
              width: 40,
              height: 40,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: GetBuilder(
              init: _gasController,
              builder: (controller) {
                _gasController = controller;
                _locationNameCtrl.text = _gasController.deliveryLocationName;
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
                      TextField(
                        controller: _locationNameCtrl,
                        readOnly: true,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Sauvegarder comme',
                        style:
                            TextStyle(color: Color(0xff9D9D9D), fontSize: 12),
                      ),
                      const SizedBox(height: 10),
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
                      ),
                      const SizedBox(height: 20),
                      CButton(
                        height: 50,
                        onPressed: () {
                          if (_gasController.isLocationTypeSelected) {
                            Get.back();
                          }
                        },
                        color: _gasController.isLocationTypeSelected
                            ? AssetColors.blueButton
                            : const Color(0xffEDF2F9),
                        child: Text(
                          "Enregistrer comme adresse",
                          style: TextStyle(
                            color: _gasController.isLocationTypeSelected
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

  void startLocationDescriptionSearch(MapPosition mapPosition) {
    locationDescriptionTimer = Timer(const Duration(milliseconds: 500), () {
      _searchLocationDescription(mapPosition);
    });
  }

  @override
  void dispose() {
    cancelLocationDescriptionTimer();
    super.dispose();
  }

  void cancelLocationDescriptionTimer() {
    locationDescriptionTimer?.cancel();
  }

  _searchLocationDescription(MapPosition mapPosition) async {
    deliveryLocation = LocationModel(
        latitude: mapPosition.center!.latitude,
        longitude: mapPosition.center!.longitude);
    _gasController.getLocationDescription(deliveryLocation).then((location) {
      _gasController.updateDeliveryLocation(deliveryLocation);
    });
  }
}
