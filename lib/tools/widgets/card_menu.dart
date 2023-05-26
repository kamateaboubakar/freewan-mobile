import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';

class CardMenu extends StatelessWidget {
  final String? title;
  final List<ButtonMenu> children;

  final EdgeInsetsGeometry? margin;
  const CardMenu(
      {this.margin = const EdgeInsets.only(bottom: 20),
      this.title,
      this.children = const [],
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(
            width: .2,
            color: const Color.fromRGBO(218, 218, 218, 1),
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, .5), // décalage vertical de l'ombre
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: title != null,
            child: Text(
              title.value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView(
            padding: const EdgeInsets.only(top: 7),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: .85,
            ),
            children: children,
          ),
        ],
      ),
    );
  }
}
