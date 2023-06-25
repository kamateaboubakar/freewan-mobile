import 'package:flutter/material.dart';
import 'package:wan_mobile/models/loyer/abstracts/bloc_appartement.dart';
import 'package:wan_mobile/tools/types/types.dart';

class BlocAppartementListTile extends StatelessWidget {
  final BlocAppartement item;
  final void Function()? onPressed;
  const BlocAppartementListTile(this.item,
      {required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/images/icons/immeuble.png",
            width: 45,
            height: 65,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.libelle.value,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.lieu.value,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${item.appartements.length} appartements",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(71, 36, 251, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Center(
            child: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          )
        ],
      ),
    );
  }
}
