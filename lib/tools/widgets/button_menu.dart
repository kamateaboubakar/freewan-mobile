import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';

class ButtonMenu extends StatelessWidget {
  final Widget icon;
  final String? title;
  final double? minWidth;
  final double? height;
  final String? categorie;
  final int iconFlex;
  final BorderSide side;

  final void Function()? onPressed;

  const ButtonMenu({
    this.minWidth,
    this.iconFlex = 1,
    this.height,
    this.categorie,
    required this.icon,
    this.title,
    this.onPressed,
    this.side = BorderSide.none,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: minWidth,
      height: height,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: side,
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(flex: iconFlex, child: icon),
            const SizedBox(height: 5),
            Visibility(
              visible: title != null,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: AutoSizeText(
                    title.value,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    maxFontSize: 12,
                    minFontSize: 10,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
