import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_music/common/constants/size_constants.dart';
import 'package:my_music/data/core/logger.dart';
import 'package:my_music/domain/usecase/get_all_songs.dart';
import 'package:my_music/presentation/journey/home_screen/controller/music_page_controller.dart';
import 'package:my_music/presentation/journey/music_player_screen/page/music_player_screen.dart';
import 'package:my_music/presentation/theme/colors.dart';
import 'package:my_music/di/get_it.dart' as getIt;

class HomeScreen extends StatelessWidget {
  final MusicController musicController = Get.put(MusicController(
      getIt.getItInstance<AudioPlayer>(), getIt.getItInstance<GetAllSongs>()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          customAppBar(context),
          Divider(
            height: 2,
            color: kDarkBlack,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(
              child: Text("Songs"),
              onPressed: () {},
            ),
            TextButton(
              child: Text("Playlists"),
              onPressed: () {},
            ),
            TextButton(
              child: Text("Artists"),
              onPressed: () {},
            ),
            TextButton(
              child: Text("Genres"),
              onPressed: () {},
            ),
          ]),
          Divider(
            height: 2,
            color: kDarkBlack,
          ),
          SongsList(
            musicController: musicController,
          ),
        ]),
      ),
    );
  }

  Widget customAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Sizes.dimen_12, vertical: Sizes.dimen_10),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Music",
                style: Theme.of(context).textTheme.headline4,
              ),
              Row(
                // mainAxisSize: MainAxisSize.min,
                //  mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RawMaterialButton(
                      fillColor: klightDark,
                      elevation: 9,
                      constraints: BoxConstraints.tight(Size(36, 36)),
                      shape: CircleBorder(),
                      child: Icon(Icons.search),
                      onPressed: () {}),
                  // SizedBox(width: 10,),
                  RawMaterialButton(
                      constraints: BoxConstraints.tight(Size(36, 36)),
                      fillColor: klightDark,
                      elevation: 9,
                      shape: CircleBorder(),
                      child: Icon(Icons.add),
                      onPressed: () {}),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class SongsList extends StatelessWidget {
  const SongsList({
    Key key,
    @required this.musicController,
  }) : super(key: key);

  final MusicController musicController;

  getBottomSheet() {
    Get.bottomSheet(Container(
        // height: Get.bottomBarHeight,
        color: Colors.green,
        child: Column(children: [Text("THis is children")])));
  }

  @override
  Widget build(BuildContext context) {
    Log l = Log("Home Screen");
    return Expanded(child: GetBuilder<MusicController>(builder: (_) {
      final int itemCount = musicController.songsList.length;
      return musicController.songsList == null
          ? Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  SpinKitRotatingCircle(
                    color: kViolet,
                    size: 50.0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Please wait while the song is loading")
                ]))
          : Stack(
              children: [
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    l.d("rebuilding data");
                    return GestureDetector(
                      onTap: () {
                        musicController.startSong(index: index);

                        Get.to(MusicPlayingScreen(
                          index: index,
                        ));
                      },
                      child: Card(
                          color: kLightBlue,
                          child: Row(
                            children: [
                              Icon(
                                Icons.music_note,
                                size: 40,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "${musicController.songsList[index].title}",
                                  style: Theme.of(context).textTheme.bodyText1,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(width: 20),
                              Icon(Icons.more_vert_outlined)
                            ],
                          )),
                    );
                  },
                ),
                // Positioned(
                //   bottom: 0,
                //   left: Get.width / 2 - 25,
                //   right: Get.width / 2 - 25,
                //   child: GestureDetector(
                //     onTapUp: (value){
                //        print("${value.kind}");
                //       print("updrage");

                //     },
                //     child: Container(
                //       height: 10,
                //       width: 30,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: Colors.green,
                //       ),
                //     ),
                //   ),
                // )
              ],
            );
    }));
  }
}
