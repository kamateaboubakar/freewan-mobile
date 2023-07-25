import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:wan_mobile/models/location_model.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import '../../../../tools/utils/tools.dart';
import '../../../../tools/widgets/address_type_item.dart';
import '../../../../tools/widgets/c_button.dart';
import '../../../../tools/widgets/error_view.dart';
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
  Timer? locationDescriptionTimer;

  LocationModel? recuperationPlace;

  bool isLocationNameLoading = false;
  @override
  void initState() {
    recuperationPlace = _pressingController.recuperationPlace ??
        _pressingController.userLocation!;
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
                return FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: recuperationPlace?.toLatLng(),
                    zoom: mapZoom,
                    onTap: (_, __) {},
                    onPositionChanged: (mapPosition, _) {
                      cancelLocationDescriptionTimer();
                      startLocationDescriptionSearch(mapPosition);
                    },
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
              init: _pressingController,
              builder: (controller) {
                _pressingController = controller;
                var userLocalisation = _pressingController.userLocalisation;
                var addressType = _pressingController.addressType;
                _locationNameCtrl.text =
                    _pressingController.recuperationPlaceName;
                return Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
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
                        const SizedBox(height: 5),
                        const Text(
                          'Votre localisation',
                          style:
                              TextStyle(color: Color(0xff9D9D9D), fontSize: 12),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _locationNameCtrl,
                          readOnly: true,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                          ),
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
                              return const Center(
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
                              return const Center(
                                child: Text('Aucune addresse'),
                              );
                            }

                            return InkWell(
                              onTap: () {
                                _showAddressesDialog();
                              },
                              child: const Text(
                                'Cliquer ici pour sélectionner une addrese',
                                style: TextStyle(
                                  color: AssetColors.blueButton,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Sauvegarder comme',
                          style:
                              TextStyle(color: Color(0xff9D9D9D), fontSize: 12),
                        ),
                        const SizedBox(height: 10),
                        GetBuilder(
                            init: _addressController,
                            id: 'addressTypeView',
                            builder: (controller) {
                              _addressController = controller;
                              var response =
                                  _addressController.addressTypeResponse;
                              if (response == null) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              if (!response.status) {
                                return ErrorView(
                                  message: response.message,
                                  retry: () {
                                    _getAddressTypes();
                                  },
                                );
                              }

                              var addressTypes = response.data ?? [];
                              return SizedBox(
                                height: 40,
                                child: ListView.separated(
                                  itemCount: addressTypes.length,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 10);
                                  },
                                  itemBuilder: (context, index) {
                                    var type = addressTypes[index];

                                    var selected = (userLocalisation != null && userLocalisation.localisationType!.id == type.id)  || (addressType != null &&
                                        type.id == addressType.id!);
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: AddressTypeItem(
                                        icon: '',
                                        title: type.name!,
                                        selected: selected,
                                        onTap: () {
                                          _pressingController
                                              .updateAddressType(type);
                                          _pressingController.updateUserLocalisation(null);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                        const SizedBox(height: 20),

                        if(isLocationNameLoading)...{
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                        } else ...{
                          CButton(
                            height: 50,
                            onPressed: () {
                              if (isFormValid()) {
                                _pressingController.saveRecuperationPlace();
                                Get.back();
                              }
                            },
                            color: isFormValid()
                                ? AssetColors.blueButton
                                : const Color(0xffEDF2F9),
                            child: Text(
                              "Enregistrer comme adresse",
                              style: TextStyle(
                                color: isFormValid()
                                    ? Colors.white
                                    : const Color(0xffB5C4D8),
                              ),
                            ),
                          ),
                        }
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  bool isFormValid() {
    if (!_pressingController.hasUserLocalisation && !_pressingController.hasAddressTypeSeleced) {
      return false;
    }

    return true;
  }

  void _getAddresses() {
    _addressController.getUserAddresses();
  }

  void _getAddressTypes() {
    _addressController.getAddressTypes();
  }

  void startLocationDescriptionSearch(MapPosition mapPosition) {
    locationDescriptionTimer = Timer(const Duration(milliseconds: 500), () {
      _searchLocationDescription(mapPosition);
    });
  }

  _searchLocationDescription(MapPosition mapPosition) async {
    setState(() {
      isLocationNameLoading = true;
    });
    recuperationPlace = LocationModel(
        latitude: mapPosition.center!.latitude,
        longitude: mapPosition.center!.longitude);
    _pressingController
        .getLocationDescription(recuperationPlace!)
        .then((location) {
      setState(() {
        isLocationNameLoading = false;
      });
      _pressingController.updateRecuperationPlace(location);
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
              color: const Color(0xffB5C4D8).withOpacity(0.15),
              padding: const EdgeInsets.all(16),
              child: const Text(
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
                var items =
                    _addressController.userLocalisationResponse!.data ?? [];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0; i < items.length; i++) ...[
                      InkWell(
                        onTap: () {
                          _pressingController
                              .updateAddressType(null);
                          _pressingController.updateUserLocalisation(items[i]);
                          Get.back();
                          _mapController.move(
                              LatLng(items[i].latitude!, items[i].longitude!),
                              mapZoom);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                items[i].address!,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              )),
                              if (_pressingController.userLocalisation !=
                                      null &&
                                  items[i].id ==
                                      _pressingController.userLocalisation!.id)
                                Image.asset(
                                  'assets/images/check.png',
                                  width: 20,
                                )
                            ],
                          ),
                        ),
                      ),
                      const Divider()
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
