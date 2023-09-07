import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wan_mobile/tools/services/location_service.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
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
                  center: LatLng(5.379617, -3.934711),
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
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(markers: [
                    if (_gazController.hasUserLocation) ...{
                      Marker(
                          point: _gazController.userLocation!.toLatLng(),
                          builder: (context) {
                            return Image.asset(
                              'assets/images/pin_red.png',
                              width: 50,
                              height: 50,
                            );
                          })
                    },
                    if (shops != null) ...[
                      for (int i = 0; i < shops.length; i++) ...[
                        Marker(
                            point:
                                LatLng(shops[i].latitude!, shops[i].longitude!),
                            builder: (context) => InkWell(
                                  onTap: () {
                                    _gazController.updateShop(shops[i]);
                                    _mapController.move(
                                        LatLng(shops[i].latitude!,
                                            shops[i].longitude!),
                                        mapZoom);
                                  },
                                  child: Opacity(
                                    opacity: (hasNoGazPosSelected ||
                                            isGazPosSelected(i))
                                        ? 1
                                        : 0.5,
                                    child: Image.asset(
                                      'assets/images/gaz_pin.png',
                                    ),
                                  ),
                                ),
                            width: 40,
                            height: 40)
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
