import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ButtonMenu extends StatelessWidget {
  final Widget icon;
  final String title;
  final void Function()? onPressed;

  const ButtonMenu(
      {required this.icon, required this.title, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: icon,
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: AutoSizeText(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  maxFontSize: 12,
                  minFontSize: 9,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
