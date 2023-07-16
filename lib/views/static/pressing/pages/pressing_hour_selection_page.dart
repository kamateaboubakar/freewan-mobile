import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:wan_mobile/models/location_model.dart';
import 'package:wan_mobile/models/pressing/pressing.dart';
import 'package:wan_mobile/models/pressing/time_delivery.dart';
import 'package:wan_mobile/models/shop.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/gaz/gas_vctl.dart';
import 'package:wan_mobile/views/controllers/pressing/pressing_vctl.dart';
import '../../../../tools/widgets/address_type_item.dart';
import '../../../../tools/widgets/c_button.dart';

class PressingHourSelectionPage extends StatefulWidget {
  const PressingHourSelectionPage({Key? key}) : super(key: key);

  @override
  State<PressingHourSelectionPage> createState() =>
      _PressingHourSelectionPageState();
}

class _PressingHourSelectionPageState extends State<PressingHourSelectionPage> {
  PressingController _pressingController = Get.put(PressingController());

  late Pressing pressing;

  final MapController _mapController = MapController();
  final double mapZoom = 16.2;

  bool canSelectHour = false;

  final TextEditingController _timeCtrl = TextEditingController();

  @override
  void initState() {
    pressing = _pressingController.pressing!;
    canSelectHour = _pressingController.deliveryHour != null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(pressing.latitude!, pressing.longitude!),
              zoom: mapZoom,
              onTap: (_, __) {},
              onPositionChanged: (mapPosition, _) {},
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(pressing.latitude!, pressing.longitude!),
                    builder: (context) => Image.asset(
                      'assets/images/pressing_pin.png',
                      width: 40,
                      height: 40,
                    ),
                  )
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: GetBuilder(
              init: _pressingController,
              builder: (controller) {
                _pressingController = controller;
                TimeDeliverySelection timeDelivery =
                    _pressingController.timeDeliverySelection;
                TimeOfDay? _deliveryHour = _pressingController.deliveryHour;
                _timeCtrl.text =
                    _deliveryHour != null ? _deliveryHour.format(context) : '';
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
                        'Sélectionner l’heure',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AssetColors.darkBrown,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'A quel moment',
                        style:
                            TextStyle(color: Color(0xff9D9D9D), fontSize: 12),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          if (canSelectHour) return;
                          _showDeliveryTimeDialog();
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    timeDelivery.title,
                                    style: TextStyle(
                                      color: canSelectHour
                                          ? Color(0xffB5C4D8)
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: canSelectHour
                                      ? Color(0xffB5C4D8)
                                      : AssetColors.blueButton,
                                )
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text(
                            "Spécifier l'heure",
                            style: TextStyle(
                              color: Color(0xff9D9D9D),
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              canSelectHour = !canSelectHour;
                              if (!canSelectHour) {
                                _pressingController.updateDeliveryHour(null);
                              } else {
                                setState(() {});
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: canSelectHour
                                      ? AssetColors.blueButton
                                      : Color(0xffD7DDE3)),
                              width: 25,
                              height: 25,
                              child: canSelectHour
                                  ? Center(
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Opacity(
                        opacity: canSelectHour ? 1 : 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AssetColors.lightGrey2,
                              borderRadius: BorderRadius.circular(2)),
                          padding: EdgeInsets.all(4),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      AssetColors.blueButton.withOpacity(0.09),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Image.asset(
                                  "assets/images/time.png",
                                  width: 17.5,
                                  height: 17.5,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: _timeCtrl,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Color(0xff9D9D9D),
                                      fontSize: 12,
                                    ),
                                    hintText: "Spécifier une heure",
                                  ),
                                  readOnly: true,
                                  onTap: () {
                                    if (!canSelectHour) return;
                                    _showTimePicker();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CButton(
                        height: 50,
                        onPressed: () {
                          Get.back();
                        },
                        color: canSelectHour &&
                                    _pressingController.deliveryHour != null ||
                                !canSelectHour
                            ? AssetColors.blueButton
                            : const Color(0xffEDF2F9),
                        child: Text(
                          "Enregister l'heure",
                          style: TextStyle(
                            color:
                                true ? Colors.white : const Color(0xffB5C4D8),
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

  Future<dynamic> _showDeliveryTimeDialog() {
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
                'Séléctionner le moment',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            GetBuilder(
              init: _pressingController,
              builder: (controller) {
                _pressingController = controller;
                var timeDelivery = _pressingController.timeDeliverySelection;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0;
                        i < TimeDeliverySelection.times.length;
                        i++) ...[
                      InkWell(
                        onTap: () {
                          _pressingController.updateDeliverySelectionTime(
                              TimeDeliverySelection.times[i]);
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                TimeDeliverySelection.times[i].title,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )),
                              if (TimeDeliverySelection.times[i].value ==
                                  timeDelivery.value)
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

  _showTimePicker() async {
    var selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selectedTime != null) {
      _pressingController.updateDeliveryHour(selectedTime);
    }
  }
}
