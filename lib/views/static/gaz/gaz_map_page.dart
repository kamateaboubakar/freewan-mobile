import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/views/static/gaz/gaz_pos_info_page.dart';

import '../../../tools/widgets/c_textform_field.dart';

class GazMapPage extends StatefulWidget {
  const GazMapPage({Key? key}) : super(key: key);

  @override
  State<GazMapPage> createState() => _GazMapPageState();
}

class _GazMapPageState extends State<GazMapPage> {
  final List<_ServiceFilter> serviceFilterItems = [
    _ServiceFilter(title: "Tous", image: "assets/images/all_icon.png"),
    _ServiceFilter(title: "Gaz", image: "assets/images/gaz_selection_icon.png"),
    _ServiceFilter(title: "Pressing", image: "assets/images/pressing_icon.png"),
    _ServiceFilter(
        title: "Restos", image: "assets/images/ion_fast-food-outline.png"),
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

  @override
  void initState() {
    selectedGazPosIndex = noSelectionIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Gaz"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
                center: LatLng(5.379617, -3.934711),
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
                    builder: (context) => InkWell(
                      onTap: () {
                        /*_mapController.move(gazPos[i].position, mapZoom);
                        setState(() {
                          selectedGazPosIndex = i;
                        });*/
                        Get.to(()=> GazPosInfoPage());

                      },
                      child: Opacity(
                        opacity: (hasNoGazPosSelected || isGazPosSelected(i))
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
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: showServiceFilterView(),
          )
        ],
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
                    Color(0xffFCFFFF).withOpacity(0),
                    Color(0xffFCFFFF),
                  ],
                  stops: [
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
                                color: Color(0xffB5C4D8).withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(12),
                              child: Center(
                                child: Image.asset(
                                  item.image,
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                            ),
                            Text(
                              item.title,
                              style: TextStyle(
                                color: selected
                                    ? Color(0xff0042FF)
                                    : AssetColors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CTextFormField(
                    hintText: "Chercher un",
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.search),
                    ),
                    fillColor: Color(0xffCFD8DC).withOpacity(.56),
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
}

class _ServiceFilter {
  final String title;
  final String image;

  _ServiceFilter({
    required this.title,
    required this.image,
  });
}

class GazPos {
  final LatLng position;

  GazPos({
    required this.position,
  });
}
