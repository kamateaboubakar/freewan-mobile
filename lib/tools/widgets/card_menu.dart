import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';

class CardMenu extends StatelessWidget {
  final String title;
  final List<ButtonMenu> children;
  final double height;
  final EdgeInsetsGeometry? margin;
  const CardMenu(
      {this.height = 200,
      this.margin = const EdgeInsets.only(bottom: 20),
      required this.title,
      this.children = const [],
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(width: .5, color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: GridView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: .85,
              ),
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
