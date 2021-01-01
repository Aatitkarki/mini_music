import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_music/theme/theme.dart';

import 'common/customScrollBehavior.dart';
import 'features/modules/MusicScreen/view/musicScreen.dart';

void main() {
  debugPaintSizeEnabled = false;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      theme: AppTheme.appTheme.kDarkTheme,
      debugShowCheckedModeBanner: false,
      home: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: MusicScreen()),
    );
  }
}

