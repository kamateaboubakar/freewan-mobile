import 'package:flutter/material.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class HomePageVctl extends ViewController {
  List<String> ads = [
    "https://www.wordstream.com/wp-content/uploads/2021/07/persuasive-ads-coca-cola-1.jpg",
    "https://165225.fs1.hubspotusercontent-na1.net/hubfs/165225/Video-ads-meta.jpg",
    "https://www.shutterstock.com/image-vector/deluxe-king-size-burger-ads-260nw-1121447561.jpg"
  ];

  final ScrollController scrollController = ScrollController();

  int currentAds = 0;
  double fabSize = 56.0;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      fabSize = scrollController.offset > 100 ? 40.0 : 56.0;
      update();
    });
  }
}
