import 'package:flutter/material.dart';

import '../utils/asset_colors.dart';

class AddressTypeItem extends StatelessWidget {
  final bool selected;
  final String title;
  final String icon;
  final Function() onTap;
  AddressTypeItem({
    Key? key,
    this.selected = false,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? AssetColors.blueButton : AssetColors.lightGrey2,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(8),
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
                errorBuilder: (context, _, __){
                  return Container();
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.white : Colors.black,
                  fontSize: 12
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
