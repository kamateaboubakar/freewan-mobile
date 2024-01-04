import 'package:flutter/material.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';

class ContainerMenu extends StatelessWidget {
  final String? title;
  final String? externalTitle;
  final double height;
  final int crossAxisCount;

  final Widget child;

  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  const ContainerMenu({
    this.margin = const EdgeInsets.only(bottom: 10),
    this.padding = const EdgeInsets.all(15),
    this.title,
    this.height = 150,
    this.externalTitle,
    this.child = const SizedBox.shrink(),
    this.crossAxisCount = 4,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (externalTitle != null)
            ? ListTile(
                title: Text(
                  externalTitle.value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        Container(
          margin: margin,
          padding: padding,
          constraints: BoxConstraints(minHeight: height),
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
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: title != null,
                child: Text(
                  title.value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              child
            ],
          ),
        ),
      ],
    );
  }
}
