import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';

class JobTag extends StatelessWidget {
  final String title;
  final double? fontSize;
  final Color? textColor;
  final Color? backgroundColor;

  const JobTag({
    Key? key,
    required this.title,
    this.fontSize,
    this.textColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AssetColors.blueButton,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
            color: textColor ?? Colors.white, fontSize: fontSize ?? 13),
      ),
    );
  }
}
