import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/services/location_service.dart';

import 'package:wan_mobile/views/controllers/gaz/gas_shop_vctl.dart';
import 'package:wan_mobile/views/controllers/gaz/gas_vctl.dart';
import 'package:wan_mobile/views/static/gaz/pages/gaz_pos_info_page.dart';
import '../../../../models/shop.dart';

class GazMapPage extends StatefulWidget {
  const GazMapPage({Key? key}) : super(key: key);

  @override
  State<GazMapPage> createState() => _GazMapPageState();
}

class _GazMapPageState extends State<GazMapPage> {
  final MapController _mapController = MapController();

  final double mapZoom = 16.2;

  int noSelectionIndex = -1;
  late int selectedGazPosIndex;

  GasController _gazController = Get.put(GasController());
  final GasShopController _gazShopController = Get.put(GasShopController());

  @override
  void initState() {
    selectedGazPosIndex = noSelectionIndex;
    _gazController.reset();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _requestPermissionForLocation();
      _gazShopController.addListener(() {
        if (_gazShopController.hasPurchaseActionSelected) {
          panelController.open();
        }
      });
    });
  }

  PanelController panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Gaz"),
      ),
      body: GetBuilder(
        init: _gazController,
        builder: (controller) {
          _gazController = controller;
          List<Shop>? shops = controller.shops;
          Shop? shop = _gazController.shop;
          return Stack(
            fit: StackFit.expand,
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: const LatLng(5.379617, -3.934711),
                  zoom: mapZoom,
                  onTap: (_, __) {
                    _gazController.clearSelectedShop();
                    _gazShopController.clearSelectedPurchaseAction();
                    if (panelController.isPanelOpen) {
                      panelController.close();
                    }
                  },
                  interactiveFlags:
                      InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                ),
                children: [
                  TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
                  MarkerLayer(markers: [
                    if (_gazController.hasUserLocation) ...{
                      Marker(
                        point: _gazController.userLocation!.toLatLng(),
                        child: Image.asset(
                          'assets/images/icons/marker_map.gif',
                          width: 100,
                          height: 100,
                        ),
                      )
                    },
                    if (shops != null) ...[
                      for (int i = 0; i < shops.length; i++) ...[
                        Marker(
                          width: 250,
                          height: 65,
                          point:
                              LatLng(shops[i].latitude!, shops[i].longitude!),
                          child: SpeechBubble(
                            padding: EdgeInsets.zero,
                            borderRadius: 14,
                            color: Colors.red,
                            width: 250,
                            child: Column(
                              children: [
                                ListTile(
                                  dense: true,
                                  horizontalTitleGap: 0,
                                  textColor: Colors.white,
                                  leading: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.white,
                                    child: Image.asset(
                                      'assets/images/icons/boutique.png',
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                  title: Text(
                                    shops[i].name!,
                                    maxLines: 1,
                                  ),
                                  subtitle: Text(
                                    shops[i].address!,
                                    maxLines: 1,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${shops[i].distance(_gazController.userLocation!.toLatLng())}km",
                                        maxLines: 1,
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    _gazController.updateShop(shops[i]);
                                    _mapController.move(
                                        LatLng(shops[i].latitude!,
                                            shops[i].longitude!),
                                        mapZoom);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Marker(
                        //     point:
                        //         LatLng(shops[i].latitude!, shops[i].longitude!),
                        //     builder: (context) => InkWell(
                        //           onTap: () {
                        //             _gazController.updateShop(shops[i]);
                        //             _mapController.move(
                        //                 LatLng(shops[i].latitude!,
                        //                     shops[i].longitude!),
                        //                 mapZoom);
                        //           },
                        //           child: Opacity(
                        //             opacity: (hasNoGazPosSelected ||
                        //                     isGazPosSelected(i))
                        //                 ? 1
                        //                 : 0.5,
                        //             child: SpeechBalloon(
                        //               width: 350,

                        //               color: Colors.red,
                        //               child: ListTile(
                        //                 dense: true,
                        //                 title: Text(shops[i].name!),
                        //               ),
                        //               // Column(
                        //               //   mainAxisSize: MainAxisSize.min,
                        //               //   children: [
                        //               //     ListTile(
                        //               //       leading: Image.asset(
                        //               //         'assets/images/gaz_pin.png',
                        //               //       ),
                        //               //     )
                        //               //   ],
                        //               // ),
                        //             ),
                        //             //  Image.asset(
                        //             //   'assets/images/gaz_pin.png',
                        //             // ),
                        //           ),
                        //         ),
                        //     width: 40,
                        //     height: 40)
                      ]
                    ]
                  ]),
                ],
              ),
              if (shops != null)
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      if (_gazController.hasUserLocation) ...[
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: () {
                                _moveToCurrentLocation();
                              },
                              child: const Icon(
                                Icons.my_location_sharp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5)
                      ],
                    ],
                  ),
                ),
              if (_gazController.shop != null)
                SlidingUpPanel(
                  controller: panelController,
                  body: Container(),
                  panelBuilder: (scrollCtl) =>
                      GazPosInfoPage(scrollCtl, togglePanel: () {
                    if (panelController.isPanelOpen) {
                      panelController.close();
                      if (_gazShopController.hasPurchaseActionSelected) {
                        _gazShopController.clearSelectedPurchaseAction();
                      }
                    } else {
                      panelController.open();
                    }
                  }),
                  minHeight: shop == null ? 0 : 300,
                  maxHeight: shop == null ? 0 : screenHeight * 0.85,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  bool get hasNoGazPosSelected => selectedGazPosIndex == noSelectionIndex;

  bool isGazPosSelected(int index) => selectedGazPosIndex == index;

  _requestPermissionForLocation() async {
    var hasLocationPermission = await LocationService.hasLocationPermission();
    if (hasLocationPermission) {
      _getShops();
      return;
    }
    Tools.messageBox(
      message:
          "WAN a besoin d'accéder à votre position pour trouver les services les plus proches de vous",
      onConfirm: () async {
        var isGranted = await LocationService.requestLocationPermission();
        if (!isGranted) {
          Get.back();
          return;
        }
        _getShops();
      },
    );
  }

  _getShops() async {
    var pr = Tools.progressDialog();
    pr.show();
    var response = await _gazController.getClosestShop();
    Get.back();
    if (!response.status) {
      Tools.messageBox(message: response.message);
      return;
    }
    _moveToCurrentLocation();
  }

  void _moveToCurrentLocation() {
    var userLocation = _gazController.userLocation!;
    _mapController.move(userLocation.toLatLng(), mapZoom);
  }
}
