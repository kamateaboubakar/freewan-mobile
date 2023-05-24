import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';

class ToggleItem extends StatelessWidget {
  final String label;
  final bool selected;
  final EdgeInsetsGeometry padding;
  const ToggleItem(
      {this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      this.selected = false,
      required this.label,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          width: .8,
          color: selected ? AssetColors.blue : AssetColors.grey4,
        ),
      ),
      child: Padding(
        padding: padding,
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? AssetColors.blue : AssetColors.grey3,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}