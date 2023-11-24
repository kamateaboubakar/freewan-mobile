import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/models/don/campagne.dart';

class CampagneListTile extends StatelessWidget {
  final Campagne don;

  const CampagneListTile(this.don, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 13, right: 13),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: AssetColors.grey5, borderRadius: BorderRadius.circular(20)),
      height: 258,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(don.image.value, fit: BoxFit.cover)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: true,
                  minVerticalPadding: 0,
                  minLeadingWidth: 0,
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(
                    don.label.value,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: const LinearProgressIndicator(
                    minHeight: 8,
                    value: .75,
                  ),
                ),
                const ListTile(
                  dense: true,
                  minVerticalPadding: 0,
                  minLeadingWidth: 0,
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    "0 sur F 500 000",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
