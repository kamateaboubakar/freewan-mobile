import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';

import 'package:wan_mobile/tools/widgets/button_menu.dart';

class PageableMenu extends StatelessWidget {
  final String? title;
  final List<ButtonMenu> children;
  final EdgeInsetsGeometry margin;
  final int nbButtonPerPage;
  const PageableMenu({
    this.children = const [],
    this.title,
    this.margin = const EdgeInsets.only(bottom: 10),
    this.nbButtonPerPage = 4,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      constraints: const BoxConstraints(minHeight: 150),
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ImageSlideshow(
            height: 140,
            children: splitListIntoChunks(children)
                .map(
                  (e) => GridView(
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 15),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: nbButtonPerPage,
                      childAspectRatio: 1,
                    ),
                    children: e,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  List<List<Widget>> splitListIntoChunks(List<Widget> widgets) {
    List<List<Widget>> chunks = [];
    int chunkSize = 4;

    for (int i = 0; i < widgets.length; i += chunkSize) {
      int endIndex = i + chunkSize;
      chunks.add(widgets.sublist(
          i, endIndex > widgets.length ? widgets.length : endIndex));
    }

    return chunks;
  }
}
