import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:my_music/common/constants/size_constants.dart';
import 'package:my_music/data/core/logger.dart';
import 'package:my_music/presentation/journey/music_player_screen/controller/music_page_controller.dart';
import 'package:my_music/presentation/theme/colors.dart';

class MusicPlayingScreen extends StatelessWidget {
  final MusicController musicController = Get.find();

  final int index;

  MusicPlayingScreen({this.index});
  @override
  Widget build(BuildContext context) {
    Log("").e(
        "THe data is as name: ${musicController.songsList[index].title} and isFav: ${musicController.songsList[index].isFavourite}");
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            customAppBar(context),
            Divider(
              height: 2,
              color: kDarkBlack,
            ),
            SizedBox(height: 20),
            Container(
              height: 300,
              child: Stack(
                children: [
                  Center(
                      child: AnimatedBuilder(
                    animation: musicController.animationController,
                    builder: (BuildContext context, Widget _widget) {
                      return Transform.rotate(
                        angle: -musicController.animationController.value * 4,
                        child: _widget,
                      );
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/no_cover.png')),
                          color: Colors.red,
                          shape: BoxShape.circle),
                    ),
                  ))
                ],
              ),
            ),
            buildRadialSeekBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GetBuilder<MusicController>(
                builder: (_) {
                  Log("").e("Song title chagne");
                  return Column(
                    children: [
                      Text(
                        _.currentSong().title.length > 20
                            ? _.currentSong().title.substring(0, 20) + "..."
                            : _.currentSong().title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        // overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        _.currentSong().artist,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    child: Icon(
                      Icons.skip_previous,
                      size: 50,
                    ),
                    onTap: () {
                      musicController.prevSong();
                    }),
                SizedBox(
                  width: 20,
                ),
                GetBuilder<MusicController>(builder: (musicController) {
                  Log("").i("building icons");
                  return Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: GestureDetector(
                        child: Icon(
                          musicController.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 50,
                        ),
                        onTap: () {
                          musicController.isPlaying
                              ? musicController.pauseSong()
                              : musicController.resumeSong();
                        }),
                  );
                }),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                    child: Icon(
                      Icons.skip_next,
                      size: 50,
                    ),
                    onTap: () {
                      musicController.nextSong();
                    }),
                // IconButton(
                //     icon: Icon(Icons.stop),
                //     onPressed: () {
                //       musicController.stopSong();
                //     }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder<MusicController>(builder: (_) {
                  return GestureDetector(
                      onTap: () {
                        musicController.changeFavStat();
                      },
                      child: Icon(
                        _.currentSong().isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                        size: 50,
                      ));
                })
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget customAppBar(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_10, vertical: Sizes.dimen_10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RawMaterialButton(
                  fillColor: klightDark,
                  elevation: 9,
                  constraints: BoxConstraints.tight(Size(36, 36)),
                  shape: CircleBorder(),
                  child: Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.back();
                  }),
              // SizedBox(width: 10,),
              Text(
                "Now Playing",
                style: Theme.of(context).textTheme.headline4,
              ),

              RawMaterialButton(
                  constraints: BoxConstraints.tight(Size(36, 36)),
                  fillColor: klightDark,
                  elevation: 9,
                  shape: CircleBorder(),
                  child: Icon(Icons.add),
                  onPressed: () {})
            ],
          ),
        ],
      ),
    );
  }

  Widget buildRadialSeekBar() {
    print("building data");
    return Obx(() {
      // Logger().i("building");
      return Column(
        children: [
          Slider(
            autofocus: false,
            onChangeStart: (value) {
              musicController.pauseSong();
            },
            onChanged: (value) {
              Duration duration = Duration(seconds: value.toInt());
              musicController.seekSong(duration);
            },
            onChangeEnd: (value) {
              // musicController.audioPlayer.seek(duration);
              musicController.resumeSong();
            },
            min: 0.0,
            max: double.parse(musicController.currentSong().duration) / 1000,
            value: musicController.songPosition.value.toDouble(),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.dimen_10, vertical: Sizes.dimen_10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "${(Duration(seconds: (musicController.songPosition.value)))}"
                        .substring(2, 7)),
                Text(
                    '${(Duration(seconds: int.parse(musicController.currentSong().duration) ~/ 1000))}'
                        .substring(2, 7))
              ],
            ),
          ),
        ],
      );
    });
  }
}
