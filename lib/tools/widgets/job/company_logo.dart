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
    String? logoUrl = company.logoUrl;
    if (logoUrl != null && p.extension(logoUrl).isNotEmpty) {
      return Image.network(
        logoUrl,
        width: 35,
        height: 35,
      );
    }

    return Image.memory(
      Uri.parse("data:image/png;base64,${company.logo!}")
          .data!
          .contentAsBytes(),
      width: 35,
      height: 35,
    );
  }
}
