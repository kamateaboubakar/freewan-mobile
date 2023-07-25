import 'package:flutter/material.dart';

import 'asset_colors.dart';

class BrandsItem extends StatelessWidget {
  final String image;
  final String? label;
  final bool selected;

  const BrandsItem({
    Key? key,
    required this.image,
    this.label,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: selected ? AssetColors.blueButton : AssetColors.lightGrey3,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    image,
                    width: 50,
                  ),
                ),
                if (label != null)
                  Text(
                    label!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff07153C),
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ],
            ),
          ),
          if (selected)
            Positioned(
              top: 4,
              right: 4,
              child: Image.asset(
                'assets/images/blue_check.png',
                width: 10,
              ),
            )
        ],
      ),
    );
  }
}
