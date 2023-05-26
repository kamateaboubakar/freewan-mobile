import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wan_mobile/api/services/location_service.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/gaz/gas_shop_vctl.dart';
import 'package:wan_mobile/views/controllers/gaz/gas_vctl.dart';
import 'package:wan_mobile/views/static/gaz/pages/gaz_pos_info_page.dart';

import '../../../../models/gaz_pos.dart';
import '../../../../models/service.dart';
import '../../../../models/shop.dart';
import '../../../../tools/widgets/c_textform_field.dart';

class GazMapPage extends StatefulWidget {
  const GazMapPage({Key? key}) : super(key: key);

  @override
  State<GazMapPage> createState() => _GazMapPageState();
}

class _GazMapPageState extends State<GazMapPage> {
  final List<Service> serviceFilterItems = [
    Service(label: "Tous", icon: "assets/images/all_icon.png"),
    Service(label: "Gaz", icon: "assets/images/gaz_selection_icon.png"),
    Service(label: "Pressing", icon: "assets/images/pressing_icon.png"),
    Service(label: "Restos", icon: "assets/images/ion_fast-food-outline.png"),
  ];

  final List<GazPos> gazPos = [
    GazPos(position: LatLng(5.379946, -3.933305)),
    GazPos(position: LatLng(5.380910, -3.935291)),
    GazPos(position: LatLng(5.379331, -3.935650)),
    GazPos(position: LatLng(5.380526, -3.936791)),
    GazPos(position: LatLng(5.378974, -3.933182)),
  ];

  final MapController _mapController = MapController();

  final double mapZoom = 16.2;

  int noSelectionIndex = -1;
  late int selectedGazPosIndex;

  GasController _gazController = Get.put(GasController());
  GasShopController _gazShopController = Get.put(GasShopController());

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
                    }),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                      markers: shops == null
                          ? []
                          : [
                              for (int i = 0; i < shops.length; i++) ...[
                                Marker(
                                  point: LatLng(
                                      shops[i].latitude!, shops[i].longitude!),
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
                                        width: 40,
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                )
                              ]
                            ]),
                ],
              ),
              if (shops != null)
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: showServiceFilterView(),
                ),
              if (_gazController.shop != null)
                SlidingUpPanel(
                  controller: panelController,
                  body: Container(),
                  panel: GazPosInfoPage(togglePanel: () {
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

  Widget showServiceFilterView() {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xffFCFFFF).withOpacity(0),
                    const Color(0xffFCFFFF),
                  ],
                  stops: const [
                    0,
                    0.3,
                  ]),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 16,
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    itemCount: serviceFilterItems.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var item = serviceFilterItems[index];
                      var selected = index == 1;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xffB5C4D8).withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Center(
                                child: Image.asset(
                                  item.icon,
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                            ),
                            Text(
                              item.label,
                              style: TextStyle(
                                color: selected
                                    ? const Color(0xff0042FF)
                                    : AssetColors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CTextFormField(
                    hintText: "Chercher un",
                    suffixIcon: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.search),
                    ),
                    fillColor: const Color(0xffCFD8DC).withOpacity(.56),
                  ),
                ),
              ],
            ),
          )
        ],
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
    var userLocation = _gazController.userLocation!;
    _mapController.move(userLocation.toLatLng(), mapZoom);
  }
}
