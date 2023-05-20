import 'package:flutter/material.dart';
import 'package:wan_mobile/models/don/don.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';

class DonListTile extends StatelessWidget {
  final Don don;
  final void Function() onPressed;
  const DonListTile(this.don, {required this.onPressed, super.key});

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
                    don.title.value,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 0,
                  dense: true,
                  minLeadingWidth: 0,
                  leading: Image.asset(
                    "assets/images/don/Vector.png",
                    width: 24,
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(don.receiver.value),
                  trailing: CButton(
                    onPressed: onPressed,
                    child: const Text("Donner"),
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
