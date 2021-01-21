import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_music/presentation/journey/home_screen/page/homeScreen.dart';
import 'presentation/theme/theme.dart';
import 'presentation/widgets/custom_scroll_behavior.dart';
import 'package:pedantic/pedantic.dart';
import 'di/get_it.dart' as getIt;

void main() async {
  debugPaintSizeEnabled = false;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  await GetStorage.init();
  unawaited(getIt.init());

  runApp(MyApp());
}

//TODO: Implement the local database as well as clean code architecture.
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

// class DataController extends GetxController {
//   SongRepositoryImpl songRepo = getItInstance<SongRepository>();

//   @override
//   void onInit() {
//     loadMusic();
//     super.onInit();
//   }

//   // getLoadedValue() async {

//   //   print(isloaded);
//   // }

//   loadMusic() async {
//     var data = await songRepo.getAllSongs();
//     data.fold((l) {
//       print("There is error");
//     }, (r) {
//       print("the song length is ${r.length}");
//     });
//   }
// }

// class MusicScreen extends StatefulWidget {
//   @override
//   _MusicScreenState createState() => _MusicScreenState();
// }

// class _MusicScreenState extends State<MusicScreen> {
//   DataController dc;
//   @override
//   void initState() {
//     dc = Get.put(DataController());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // startupService.setSongLoaded(false);

//     return Container();
//   }
// }
