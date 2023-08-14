import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wan_mobile/api/services/location_service.dart';
import 'package:wan_mobile/models/pressing/pressing.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/pressing/pressing_vctl.dart';
import 'package:wan_mobile/views/static/gaz/gaz_view.dart';
import 'package:wan_mobile/views/static/pressing/pages/pages.dart';

import '../../../../models/service.dart';
import '../../../../tools/widgets/c_textform_field.dart';

class PressingMapPage extends StatefulWidget {
  const PressingMapPage({Key? key}) : super(key: key);

  @override
  State<PressingMapPage> createState() => _PressingMapPageState();
}

class _PressingMapPageState extends State<PressingMapPage> {
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
                      _pressingController.reset();
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
          "${Const.appName} a besoin d'accéder à votre position pour trouver les services les plus proches de vous",
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
