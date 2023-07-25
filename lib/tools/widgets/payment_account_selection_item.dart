import 'package:flutter/material.dart';

class PaiementAccountSelectionItem extends StatelessWidget {
  final String? image;
  final String title;
  final double? imageWidth;
  final double? imageHeight;
  final Function() onTap;
  const PaiementAccountSelectionItem({
    Key? key,
    required this.title,
    required this.onTap,
    this.image,
    this.imageWidth,
    this.imageHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xfff3f8fe),
          borderRadius: BorderRadius.circular(10)
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          tileColor: const Color.fromRGBO(237, 242, 249, 1),
          title: const Text(
            "Utiliser ce moyen de paiement",
            style: TextStyle(
              color: Color.fromRGBO(72, 76, 79, 1),
              fontSize: 15,
            ),
          ),
          subtitle: Row(
            children: [
              if (image != null) ...[
                Image.asset(
                  image!,
                  width: imageWidth,
                  height: imageHeight,
                ),
                const SizedBox(width: 10)
              ],
              Text(
                title,
                style: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 12,
            color: Color.fromRGBO(7, 21, 60, 1),
          ),
          //onTap: () => Get.to(BillsListPage()),
        ),
      ),
    );
  }
}
