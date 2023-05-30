import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';

class JobTag extends StatelessWidget {
  final String title;
  final double? fontSize;
  final bool selected;
  final Function()? onTap;

  const JobTag({
    Key? key,
    required this.title,
    this.fontSize,
    this.selected = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected
          ? AssetColors.blueButton
              : const Color(0xffE0E0E0),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              color: selected ? Colors.white : AssetColors.grey3, fontSize: fontSize ?? 13),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
