import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';

class ListableMenu extends StatelessWidget {
  final String? title;
  final List<ButtonMenu> children;
  final EdgeInsetsGeometry margin;
  final double? height;

  const ListableMenu(
      {this.margin = const EdgeInsets.only(bottom: 10),
      this.height,
      this.children = const [],
      this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
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
            child: Column(
              children: [
                Text(
                  title.value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 100,
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
