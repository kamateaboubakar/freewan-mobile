import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';

class WrapperBodyGridView extends StatelessWidget {
  final bool loading;
  final List<Widget> children;
  final String emptyText;
  final ScrollPhysics? physics;
  final Future<void> Function()? onRefresh;
  final String? error;
  final String lottieEmptyImage;
  final Widget? emptyWidget;
  final EdgeInsetsGeometry? gridPadding;
  final Widget? refreshButton;
  final bool shrinkWrap;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;
  final bool? primary;
  const WrapperBodyGridView(
      {required this.loading,
      this.primary,
      this.refreshButton,
      this.onRefresh,
      this.emptyWidget,
      this.crossAxisCount = 2,
      this.mainAxisSpacing = 2,
      this.childAspectRatio = 1.0,
      this.physics,
      required this.children,
      this.crossAxisSpacing = 0.0,
      this.lottieEmptyImage = "assets/lotties/123725-box-empty.json",
      this.gridPadding = const EdgeInsets.all(10),
      this.error,
      this.emptyText = "Aucune données à afficher",
      this.shrinkWrap = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (error != null && error!.isNotEmpty)
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    error.value,
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
            ? GridView.count(
                padding: gridPadding,
                crossAxisSpacing: crossAxisSpacing,
                childAspectRatio: childAspectRatio,
                shrinkWrap: shrinkWrap,
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  4,
                  (index) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: const Card(elevation: 0),
                  ),
                )
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: List.generate(
                //     5,
                //     (index) => Shimmer.fromColors(
                //       baseColor: Colors.grey.shade300,
                //       highlightColor: Colors.white,
                //       child: ListTile(
                //         leading: const CircleAvatar(),
                //         title: Container(
                //           color: Colors.grey,
                //           height: 10,
                //           width: double.infinity,
                //         ),
                //         subtitle: Container(
                //           color: Colors.grey,
                //           height: 10,
                //           width: double.infinity,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                )
            : (children.isEmpty)
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        emptyWidget ??
                            Lottie.asset(
                              lottieEmptyImage,
                              height: 140,
                            ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                emptyText,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 200,
                              child: refreshButton ??
                                  CButton(
                                    onPressed: onRefresh,
                                    child: const Text(
                                      "Recharger",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : onRefresh != null
                    ? RefreshIndicator(
                        onRefresh: onRefresh!,
                        child: GridView.count(
                          physics: physics,
                          primary: primary,
                          childAspectRatio: childAspectRatio,
                          mainAxisSpacing: mainAxisSpacing,
                          crossAxisSpacing: crossAxisSpacing,
                          crossAxisCount: crossAxisCount,
                          shrinkWrap: shrinkWrap,
                          padding: gridPadding,
                          children: children,
                        ),
                      )
                    : GridView.count(
                        physics: physics,
                        childAspectRatio: childAspectRatio,
                        mainAxisSpacing: mainAxisSpacing,
                        crossAxisSpacing: crossAxisSpacing,
                        crossAxisCount: crossAxisCount,
                        padding: gridPadding,
                        children: children,
                      );
  }
}
