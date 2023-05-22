import 'package:flutter/material.dart';

import '../utils/asset_colors.dart';

class AddressTypeItem extends StatelessWidget {
  final bool selected;
  final String title;
  final String icon;

  AddressTypeItem({
    Key? key,
    this.selected = false,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? AssetColors.blueButton : AssetColors.lightGrey2,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: (selected ? Colors.white : AssetColors.blueButton)
                  .withOpacity(0.09),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            child: Image.asset(
              icon,
              width: 10,
              color: selected ? Colors.white : AssetColors.blueButton,
              colorBlendMode: BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
