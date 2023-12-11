import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class AgenceAProximite extends StatelessWidget {
  const AgenceAProximite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agences à proximite")),
      body: FlutterMap(
        options: const MapOptions(),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
        ],
      ),
    );
  }
}
