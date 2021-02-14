import 'dart:typed_data';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_music/common/constants/size_constants.dart';
import 'package:my_music/data/core/logger.dart';
import 'package:my_music/domain/usecase/change_favourite_status.dart';
import 'package:my_music/domain/usecase/get_all_songs.dart';
import 'package:my_music/presentation/journey/home_screen/controller/music_page_controller.dart';
import 'package:my_music/presentation/journey/music_player_screen/page/music_player_screen.dart';
import 'package:my_music/presentation/theme/colors.dart';
import 'package:my_music/di/get_it.dart' as getIt;

class HomeScreen extends StatelessWidget {
  final MusicController musicController = Get.put(MusicController(
      getIt.getItInstance<AudioPlayer>(),
      getIt.getItInstance<GetAllSongs>(),
      getIt.getItInstance<ChangeFavouriteStatus>()));

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
              fit: StackFit.expand,
              // alignment: Alignment.topCenter,
              children: [
                FractionallySizedBox(
                  alignment: Alignment.topCenter,
                  heightFactor: musicController.isPlaying ? 0.86 : 1,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    // physics: BouncingScrollPhysics(),
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
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
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
                ),
                musicController.isStopped
                    ? SizedBox.shrink()
                    : FractionallySizedBox(
                        alignment: Alignment.bottomCenter,
                        heightFactor: 0.14,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(MusicPlayingScreen(
                              index: musicController.currentSongIndex,
                            ));
                          },
                          child: Container(
                            height: 100,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            // width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kLightBlue,
                            ),
                            child: Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Icon(Icons.music_note)),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    "${musicController.currentSong().title}",
                                    style: TextStyle(fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                  child: GestureDetector(
                                      child: Icon(
                                        musicController.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        size: 40,
                                      ),
                                      onTap: () {
                                        musicController.isPlaying
                                            ? musicController.pauseSong()
                                            : musicController.resumeSong();
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
              ],
            );
    }));
  }
}
