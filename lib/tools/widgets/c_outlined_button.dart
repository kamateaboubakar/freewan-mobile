import 'package:flutter/material.dart';
import 'package:module_master/module_master.dart';

class COutlinedButton extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? minWidth;
  final Color? color;
  final double? elevation;
  final Color? textColor;
  final Color borderColor;
  final double borderRadius;

  final Widget? icon;

  final void Function()? onPressed;
  const COutlinedButton(
      {this.elevation = 0,
      this.icon,
      this.borderRadius = 8,
      this.borderColor = AssetColors.blue,
      required this.onPressed,
      this.textColor = AssetColors.blueButton,
      this.color = Colors.white,
      this.minWidth,
      this.height,
      required this.child,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: minWidth,
      height: height,
      child: icon != null
          ? TextButton.icon(
              icon: icon!,
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(textColor),
                backgroundColor: MaterialStateProperty.all(color),
                elevation: MaterialStateProperty.all(elevation),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    side: BorderSide(color: borderColor),
                  ),
                ),
              ),
              onPressed: onPressed,
              label: child,
            )
          : TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(textColor),
                backgroundColor: MaterialStateProperty.all(color),
                elevation: MaterialStateProperty.all(elevation),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    side: BorderSide(color: borderColor),
                  ),
                ),
              ),
              onPressed: onPressed,
              child: child,
            ),
    );
  }
}
