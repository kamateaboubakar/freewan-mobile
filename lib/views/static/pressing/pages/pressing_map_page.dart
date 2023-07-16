import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wan_mobile/api/services/location_service.dart';
import 'package:wan_mobile/models/pressing/pressing.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/gaz/gas_shop_vctl.dart';
import 'package:wan_mobile/views/controllers/gaz/gas_vctl.dart';
import 'package:wan_mobile/views/controllers/pressing/pressing_vctl.dart';
import 'package:wan_mobile/views/static/gaz/gaz_view.dart';
import 'package:wan_mobile/views/static/gaz/pages/gaz_pos_info_page.dart';
import 'package:wan_mobile/views/static/pressing/pages/pages.dart';

import '../../../../models/gaz_pos.dart';
import '../../../../models/service.dart';
import '../../../../models/shop.dart';
import '../../../../tools/widgets/c_textform_field.dart';

class PressingMapPage extends StatefulWidget {
  const PressingMapPage({Key? key}) : super(key: key);

  @override
  State<PressingMapPage> createState() => _PressingMapPageState();
}

class _PressingMapPageState extends State<PressingMapPage> {
  final List<Service> serviceFilterItems = [
    Service(label: "Tous", icon: "assets/images/all_icon.png"),
    Service(label: "Gaz", icon: "assets/images/gaz_icon.png"),
    Service(
        label: "Pressing", icon: "assets/images/pressing_selection_icon.png"),
    Service(label: "Restos", icon: "assets/images/ion_fast-food-outline.png"),
  ];

  final MapController _mapController = MapController();

  final double mapZoom = 16.2;

  int noSelectionIndex = -1;
  late int selectedPosIndex;

  PressingController _pressingController = Get.put(PressingController());

  @override
  void initState() {
    selectedPosIndex = noSelectionIndex;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _requestPermissionForLocation();
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
        title: const Text("Pressing"),
      ),
      body: GetBuilder(
        init: _pressingController,
        builder: (controller) {
          _pressingController = controller;
          List<Pressing>? pressings = _pressingController.pressings;
          Pressing? pressing = _pressingController.pressing;
          return Stack(
            fit: StackFit.expand,
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                    center: LatLng(5.379617, -3.934711),
                    zoom: mapZoom,
                    onTap: (_, __) {
                      _pressingController.clearSelectedPressing();
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
                  MarkerLayer(markers: [
                    if (_pressingController.hasUserLocation) ...{
                      Marker(
                          point: _pressingController.userLocation!.toLatLng(),
                          builder: (context) {
                            return Image.asset(
                              'assets/images/pin_red.png',
                              width: 40,
                              height: 40,
                            );
                          })
                    },
                    if (pressings != null) ...[
                      for (int i = 0; i < pressings.length; i++) ...[
                        Marker(
                          point: LatLng(
                              pressings[i].latitude!, pressings[i].longitude!),
                          builder: (context) => InkWell(
                            onTap: () {
                              _pressingController.updatePressing(pressings[i]);
                              _mapController.move(
                                LatLng(
                                  pressings[i].latitude!,
                                  pressings[i].longitude!,
                                ),
                                mapZoom,
                              );
                            },
                            child: Opacity(
                              opacity: (hasPosSelected || isPosSelected(i))
                                  ? 1
                                  : 0.5,
                              child: Image.asset(
                                'assets/images/pressing_pin.png',
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                        )
                      ]
                    ]
                  ]),
                ],
              ),
              if (pressings != null)
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      if (_pressingController.hasUserLocation) ...[
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
                      showServiceFilterView(),
                    ],
                  ),
                ),
              if (_pressingController.pressing != null)
                SlidingUpPanel(
                  controller: panelController,
                  body: Container(),
                  panelBuilder: (scrollCtl) =>
                      PressingDetailsPage(scrollCtl, togglePanel: () {
                    if (panelController.isPanelOpen) {
                      panelController.close();
                    } else {
                      panelController.open();
                    }
                  }),
                  minHeight: pressing == null ? 0 : 350,
                  maxHeight: pressing == null ? 0 : screenHeight * 0.9,
                  isDraggable: false,
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
                      var selected = index == 2;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                          onTap: () {
                            if (index == 1) {
                              Get.off(GazMapPage());
                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: selected
                                      ? Color(0xffFC5E93).withOpacity(0.15)
                                      : const Color(0xffB5C4D8)
                                          .withOpacity(0.15),
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
                                      ? const Color(0xffFC5E93)
                                      : AssetColors.blueGrey,
                                ),
                              ),
                            ],
                          ),
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

  bool get hasPosSelected => selectedPosIndex == noSelectionIndex;

  bool isPosSelected(int index) => selectedPosIndex == index;

  _requestPermissionForLocation() async {
    var hasLocationPermission = await LocationService.hasLocationPermission();
    if (hasLocationPermission) {
      _getPressings();
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
        _getPressings();
      },
    );
  }

  _getPressings() async {
    var pr = Tools.progressDialog();
    pr.show();
    var response = await _pressingController.getClosestPressing();
    Get.back();
    if (!response.status) {
      Tools.messageBox(message: response.message);
      return;
    }
    _moveToCurrentLocation();
  }

  void _moveToCurrentLocation() {
    var userLocation = _pressingController.userLocation!;
    _mapController.move(userLocation.toLatLng(), mapZoom);
  }
}
