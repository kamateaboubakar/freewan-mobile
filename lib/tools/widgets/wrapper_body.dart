import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:shimmer/shimmer.dart';

class WrapperBody extends StatelessWidget {
  final bool loading;
  final Widget child;
  final String emptyText;
  final Future<void> Function()? onRefresh;
  final String error;
  final EdgeInsetsGeometry? listPadding;
  const WrapperBody(
      {required this.loading,
      this.onRefresh,
      required this.child,
      this.listPadding,
      this.error = "",
      this.emptyText = "Aucune données à afficher",
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (error.isNotEmpty)
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    error,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: TextButton(
                    onPressed: onRefresh,
                    child: const Text("Recharger"),
                  ),
                ),
              ],
            ),
          )
        : (loading)
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.grey,
                ),
              )
            : child;
  }
}
