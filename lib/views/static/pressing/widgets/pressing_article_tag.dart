import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';

class PressingArticleTag extends StatelessWidget {
  final String title;
  final double? fontSize;
  final bool selected;
  final Function()? onTap;

  const PressingArticleTag({
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
              : null,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? AssetColors.blueButton : AssetColors.lightGrey3,
          ),
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
