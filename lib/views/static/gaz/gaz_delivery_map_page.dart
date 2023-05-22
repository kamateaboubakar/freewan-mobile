import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/views/static/gaz/gaz_pos_info_page.dart';

import '../../../models/gaz_pos.dart';
import '../../../tools/widgets/address_type_item.dart';
import '../../../tools/widgets/c_button.dart';
import '../../../tools/widgets/c_textform_field.dart';

class GazDeliveryMapPage extends StatefulWidget {
  const GazDeliveryMapPage({Key? key}) : super(key: key);

  @override
  State<GazDeliveryMapPage> createState() => _GazDeliveryMapPageState();
}

class _GazDeliveryMapPageState extends State<GazDeliveryMapPage> {
  final List<GazPos> gazPos = [
    GazPos(position: LatLng(5.379946, -3.933305)),
  ];

  final MapController _mapController = MapController();

  final double mapZoom = 16.2;

  final TextEditingController _locationNameCtrl =
      TextEditingController(text: "Rue M66");

  final LatLng userLocation = LatLng(5.379617, -3.934711);

  int selectedLocationType = -1;

  @override
  void initState() {
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
                center: userLocation,
                zoom: mapZoom,
                onTap: (_, __) {
                  /*if (!hasNoGazPosSelected) {
                    setState(() {
                      selectedGazPosIndex = noSelectionIndex;
                    });
                  }*/
                }),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(markers: [
                for (int i = 0; i < gazPos.length; i++) ...[
                  Marker(
                    point: gazPos[i].position,
                    builder: (context) => Image.asset(
                      'assets/images/gaz_pin.png',
                      width: 40,
                      height: 40,
                    ),
                  )
                ],
                Marker(
                  point: userLocation,
                  builder: (context) =>
                      Image.asset('assets/images/pin_red.png'),
                  width: 40,
                  height: 40,
                )
              ]),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: showLocationFormView(),
          )
        ],
      ),
    );
  }

  Widget showLocationFormView() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sélectionner la localisation',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AssetColors.darkBrown,
                fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            'Votre localisation',
            style: TextStyle(color: Color(0xff9D9D9D), fontSize: 12),
          ),
          TextField(
            controller: _locationNameCtrl,
            readOnly: true,
            decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4, horizontal: 8)),
          ),
          SizedBox(height: 20),
          Text(
            'Sauvegarder comme',
            style: TextStyle(color: Color(0xff9D9D9D), fontSize: 12),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: AddressTypeItem(
                  icon:  'assets/images/home_icon.png',
                  title: 'Maison',
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: AddressTypeItem(
                  icon:  'assets/images/office_icon.png',
                  title: 'Bureau',
                  selected: true,
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          CButton(
            height: 50,
            onPressed: () {
              Get.back();
            },
            minWidth: double.infinity,
            child: const Text("Enregistrer comme adresse"),
          )
        ],
      ),
    );
  }
}
