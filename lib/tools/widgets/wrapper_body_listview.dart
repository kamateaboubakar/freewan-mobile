import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';

import '../const/const.dart';

class WrapperBodyListView extends StatelessWidget {
  final bool loading;
  final List<Widget> children;
  final String emptyText;
  final Future<void> Function()? onRefresh;
  final String error;
  final String lottieEmptyImage;
  final EdgeInsetsGeometry? listPadding;
  const WrapperBodyListView(
      {required this.loading,
      this.onRefresh,
      required this.children,
      this.lottieEmptyImage = "assets/lotties/123725-box-empty.json",
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
            ? SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.white,
                      child: ListTile(
                        leading: const CircleAvatar(),
                        title: Container(
                          color: Colors.grey,
                          height: 10,
                          width: double.infinity,
                        ),
                        subtitle: Container(
                          color: Colors.grey,
                          height: 10,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : (children.isEmpty)
                ? Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Lottie.asset(lottieEmptyImage),
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
                                child: CButton(
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
                    ),
                  )
                : onRefresh != null
                    ? RefreshIndicator(
                        onRefresh: onRefresh!,
                        child: ListView(
                          padding: listPadding,
                          children: children,
                        ),
                      )
                    : ListView(
                        padding: listPadding,
                        children: children,
                      );
  }
}
