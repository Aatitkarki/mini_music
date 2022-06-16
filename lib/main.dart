import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_music/presentation/journey/home_screen/page/home_screen.dart';
import 'presentation/theme/theme.dart';
import 'presentation/widgets/custom_scroll_behavior.dart';
import 'di/get_it.dart' as getIt;

void main() async {
  debugPaintSizeEnabled = false;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  await GetStorage.init();
  await (getIt.init());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.appTheme.kDarkTheme,
      debugShowCheckedModeBanner: false,
      home: ScrollConfiguration(
          behavior: CustomScrollBehavior(), child: HomeScreen()),
    );
  }
}
