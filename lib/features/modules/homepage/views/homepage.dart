import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/features/modules/homepage/controller/homepage_controller.dart';

// <uses-permission android:name="android.permission.INTERNET"/>
    // <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    // <uses-permission android:name="android.permission.WAKE_LOCK" />

class HomePage extends StatelessWidget {
  final HomePageController homePageController = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Player"),
      ),
      body: Container(child: GetBuilder<HomePageController>(
        builder: (homePageController) {
          return Column(
            children: [
              Row(
                children: [
                  IconButton(icon: Icon(Icons.skip_next), onPressed: () {}),
                  homePageController.isPlaying
                      ? IconButton(
                          icon: Icon(Icons.pause),
                          onPressed: () {
                            homePageController.pauseLocal();
                          })
                      : IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: () {
                            homePageController.playLocal();
                          }),
                  IconButton(icon: Icon(Icons.skip_next), onPressed: () {

                  }),
                ],
              )
            ],
          );
        },
      )),
    );
  }
}
