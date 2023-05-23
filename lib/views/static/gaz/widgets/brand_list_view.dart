import 'package:flutter/material.dart';

import '../../../../models/shop.dart';
import '../../../../tools/utils/http_response.dart';

class BrandList extends StatelessWidget {
  final HttpResponse<Shop>? response;
  final Function() retry;

  const BrandList({
    Key? key,
    required this.response,
    required this.retry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (response == null) {
      return Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!response!.status) {
      return InkWell(
        onTap: retry,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              response!.message,
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            Icon(Icons.refresh),
          ],
        ),
      );
    }

    var shop = response!.data!;

    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: shop.brands!.length,
        separatorBuilder: (context, index) => SizedBox(width: 10),
        itemBuilder: (context, index) {
          return Image.asset(
            "assets/images/${shop.brands![index].pictureName!}.png",
          );
        },
      ),
    );
  }
}
