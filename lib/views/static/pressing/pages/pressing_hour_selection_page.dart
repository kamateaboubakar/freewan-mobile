import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart' hide Marker;
import 'package:tools_flutter_project/functions/tools.dart';
import 'package:tools_flutter_project/widgets/c_button.dart';
import 'package:wan_mobile/models/pressing/pressing.dart';
import 'package:wan_mobile/models/pressing/time_delivery.dart';

import 'package:wan_mobile/views/controllers/pressing/pressing_vctl.dart';

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
                    child: Image.asset(
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
                TimeOfDay? deliveryHour = _pressingController.deliveryHour;
                _timeCtrl.text =
                    deliveryHour != null ? deliveryHour.format(context) : '';
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
                      const SizedBox(height: 10),
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
                                          ? const Color(0xffB5C4D8)
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: canSelectHour
                                      ? const Color(0xffB5C4D8)
                                      : AssetColors.blueButton,
                                )
                              ],
                            ),
                            const Divider()
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
                          const Spacer(),
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
                                      : const Color(0xffD7DDE3)),
                              width: 25,
                              height: 25,
                              child: canSelectHour
                                  ? Center(
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        decoration: const BoxDecoration(
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
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      AssetColors.blueButton.withOpacity(0.09),
                                ),
                                padding: const EdgeInsets.all(8),
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
                                  decoration: const InputDecoration(
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
                          if (canSelectHour &&
                                  _pressingController.deliveryHour != null ||
                              !canSelectHour) {
                            Get.back();
                          }
                        },
                        color: canSelectHour &&
                                    _pressingController.deliveryHour != null ||
                                !canSelectHour
                            ? AssetColors.blueButton
                            : const Color(0xffEDF2F9),
                        child: const Text(
                          "Enregister l'heure",
                          style: TextStyle(
                            color: true ? Colors.white : Color(0xffB5C4D8),
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: const Color(0xffB5C4D8).withOpacity(0.15),
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Séléctionner le moment',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            GetBuilder(
              init: _pressingController,
              builder: (controller) {
                _pressingController = controller;
                var timeDelivery = _pressingController.timeDeliverySelection;
                return SingleChildScrollView(
                  child: Column(
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
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  TimeDeliverySelection.times[i].title,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                )),
                                if (TimeDeliverySelection.times[i].value ==
                                    timeDelivery.value)
                                  Image.asset(
                                    'assets/images/check.png',
                                    width: 15,
                                  )
                              ],
                            ),
                          ),
                        ),
                        const Divider()
                      ]
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // backgroundColor: Colors.transparent,
      // elevation: 0,
      // contentPadding: EdgeInsets.zero,
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
