import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/types/types.dart';

class ButtonMenu extends StatelessWidget {
  final Widget icon;
  final String? title;
  final double? minWidth;
  final double? height;
  final String? categorie;

  final void Function()? onPressed;

  const ButtonMenu({
    this.minWidth,
    this.height,
    this.categorie,
    required this.icon,
    this.title,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: minWidth,
      height: height,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(child: icon),
            const SizedBox(height: 5),
            Visibility(
              visible: title != null,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: AutoSizeText(
                    title.value,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    maxFontSize: 12,
                    minFontSize: 9,
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
