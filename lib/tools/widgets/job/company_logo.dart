import 'package:flutter/material.dart';

import '../../../models/job/company.dart';
import 'package:path/path.dart' as p;

class CompanyLogo extends StatelessWidget {
  final Company company;

  const CompanyLogo({
    Key? key,
    required this.company,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? logoUrl = company!.logoUrl;
    if (logoUrl != null) {
      return Image.network(
        logoUrl,
        width: 35,
        height: 35,
        errorBuilder: (context, _, __) {
          return Icon(Icons.info);
        },
      );
    }

    return Image.memory(
      Uri.parse("data:image/png;base64,${company.logo!}")
          .data!
          .contentAsBytes(),
      errorBuilder: (context, _, __) {
        return Icon(Icons.info);
      },
      width: 35,
      height: 35,
    );
  }
}
