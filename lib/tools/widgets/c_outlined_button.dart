import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';

class COutlinedButton extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? minWidth;
  final Color? color;
  final double? elevation;
  final Color? textColor;
  final double borderRadius;
  final OutlinedBorder? shape;
  final Widget? icon;

  final void Function()? onPressed;
  const COutlinedButton(
      {this.elevation = 0,
      this.shape,
      this.icon,
      this.borderRadius = 8,
      required this.onPressed,
      this.textColor = Colors.white,
      this.color = Colors.white,
      this.minWidth,
      this.height,
      required this.child,
      super.key});

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? TextButton.icon(
            icon: icon!,
            style: ButtonStyle(
              
              foregroundColor: MaterialStateProperty.all(textColor),
              backgroundColor: MaterialStateProperty.all(color),
              elevation: MaterialStateProperty.all(elevation),
              shape: MaterialStateProperty.all(shape),
            ),
            onPressed: onPressed,
            label: child,
          )
        : TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(textColor),
              backgroundColor: MaterialStateProperty.all(color),
              elevation: MaterialStateProperty.all(elevation),
              shape: MaterialStateProperty.all(shape),
            ),
            onPressed: onPressed,
            child: child,
          );
  }
}
