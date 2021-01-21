import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:my_music/common/constants/size_constants.dart';
import 'package:my_music/data/core/logger.dart';
import 'package:my_music/features/modules/MusicScreen/controller/musicScreenController.dart';
import 'package:my_music/presentation/journey/home_screen/controller/music_page_controller.dart';
import 'package:my_music/presentation/theme/colors.dart';

class MusicPlayingScreen extends StatelessWidget {
  final MusicController musicController = Get.find();

  final int index;

  MusicPlayingScreen({this.index});
  @override
  Widget build(BuildContext context) {
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
            GetBuilder<MusicController>(
              builder: (_) {
                Log("").e("Song title chagne");
                return Text(_.currentSong().title);
              },
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(Icons.skip_previous),
                    onPressed: () {
                      musicController.prevSong();
                    }),
                GetBuilder<MusicController>(builder: (musicController) {
                  Log("").i("building icons");
                  return IconButton(
                      icon: Icon(musicController.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow),
                      onPressed: () {
                        musicController.isPlaying
                            ? musicController.pauseSong()
                            : musicController.resumeSong();
                      });
                }),
                IconButton(
                    icon: Icon(Icons.skip_next),
                    onPressed: () {
                      musicController.nextSong();
                    }),
                IconButton(
                    icon: Icon(Icons.stop),
                    onPressed: () {
                      musicController.stopSong();
                    }),
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
              Duration duration = Duration(milliseconds: value.toInt());
              musicController.seekSong(duration);
            },
            onChangeEnd: (value) {
              // musicController.audioPlayer.seek(duration);
              musicController.resumeSong();
            },
            min: 0.0,
            max: double.parse(musicController.currentSong().duration),
            value: musicController.songPosition.value.toDouble(),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.dimen_10, vertical: Sizes.dimen_10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(
                //     "${ComputeTime.computeTime.getTimeInSeconds(Duration(milliseconds: musicController.songPosition.value))}"),
                // Text(
                //     '${ComputeTime.computeTime.getTimeInSeconds(Duration(milliseconds: int.parse(musicController.currentSong().duration)))}')
              ],
            ),
          ),
        ],
      );
    });
  }
}
