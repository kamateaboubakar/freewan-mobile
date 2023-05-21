import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';

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
                  if (!hasNoGazPosSelected) {
                    setState(() {
                      selectedGazPosIndex = noSelectionIndex;
                    });
                  }
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
                        _mapController.move(gazPos[i].position, mapZoom);
                        setState(() {
                          selectedGazPosIndex = i;
                        });
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
            child: hasNoGazPosSelected
                ? showServiceFilterView()
                : showGazPosInfoView(screenWidth),
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

  Widget showGazPosInfoView(double screenWidth) {
    List<String> marques = [
      'assets/images/Logo-300-Blue-Full 1.png',
      'assets/images/oryx.png',
      'assets/images/oilibya 1.png',
      'assets/images/269_shell 1.png',
      'assets/images/Petroivoire 1.png',
      'assets/images/Logotype_Petroci 1.png',
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: screenWidth * 0.15,
              height: 5,
              decoration: BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dépot de gaz',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset('assets/images/pin.png', width: 10),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'Angré 22eme',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: (selectedGazPosIndex % 2 == 0
                          ? AssetColors.green
                          : Colors.red)
                      .withOpacity(0.15),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  selectedGazPosIndex % 2 == 0 ? 'Ouvert' : 'Fermé',
                  style: TextStyle(
                      color: selectedGazPosIndex % 2 == 0
                          ? Color(0xff00853F)
                          : Colors.red,
                      fontSize: 12),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Image.asset(
                "assets/images/gaz_info_image.png",
                width: 100,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Lorem ipsum dolor sit amet consectetur. Mi maecenas posuere malesuada eget. Id enim diam tortor venenatis aliquam varius libero tortor.",
                  style: TextStyle(color: AssetColors.blueGrey, fontSize: 10),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Marques vendues',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 30,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: marques.length,
              separatorBuilder: (context, index) => SizedBox(width: 10),
              itemBuilder: (context, index) {
                return Image.asset(
                  marques[index],
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AssetColors.lightGrey2,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    'Recharger',
                    style: TextStyle(color: AssetColors.grey3),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AssetColors.lightGrey2,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Acheter',
                    style: TextStyle(color: AssetColors.grey3),
                  ),
                ),
              )
            ],
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
