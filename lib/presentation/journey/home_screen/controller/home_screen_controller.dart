import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeScreenController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController tabController;
  final List<Tab> tabList = <Tab>[
    Tab(text: "Songs"),
    Tab(text: "Favourite"),
    Tab(text: "Playlists"),
    Tab(text: "Artist"),
  ];
  @override
  void onInit() {
    tabController = TabController(length: tabList.length, vsync: this);
    super.onInit();
  }
}
