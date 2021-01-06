import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:my_music/common/ui_helper.dart';
import 'package:my_music/features/modules/MusicScreen/controller/musicScreenController.dart';
import 'package:my_music/theme/colors.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MusicPlayingScreen extends StatelessWidget {
  final MusicScreenController musicController = Get.find();
  final int index;

  MusicPlayingScreen({this.index});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicScreenController>(builder: (musicController) {
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
              buildRadialSeekBar(),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(Icons.skip_previous),
                      onPressed: () {
                        musicController.prevSong();
                      }),
                  IconButton(
                      icon: Icon(musicController.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow),
                      onPressed: () {
                        musicController.isPlaying
                            ? musicController.pauseSong()
                            : musicController.resumeSong();
                      }),
                  IconButton(
                      icon: Icon(Icons.skip_next),
                      onPressed: () {
                        musicController.nextSong();
                      }),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  Widget customAppBar(BuildContext context) {
    return Container(
      width: Get.width,
      padding: sYPagePadding,
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
    return GetX<MusicScreenController>(
        init: MusicScreenController(),
        builder: (musicUIController) {
          double maxValue =
              double.parse(musicUIController.currentSong().duration);
          return SleekCircularSlider(
            appearance: CircularSliderAppearance(
                animationEnabled: true,
                startAngle: 270,
                angleRange: 360,
                size: 300,
                counterClockwise: true,
                customWidths:
                    CustomSliderWidths(progressBarWidth: 15, trackWidth: 10)),
            min: 0,
            max: maxValue,
            initialValue: musicUIController.songPosition.value.toDouble(),
            // musicUIController.songPosition.value.toDouble(),
            innerWidget: (double value) {
              return Container(
                child: Center(
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
                )),
              );
            },
            onChange: (double value) {
              Duration duration = Duration(milliseconds: value.toInt());
              musicController.seekSong(duration);
            },
            // onChangeStart: (value) {
            //   musicController.pauseSong();
            // },
            // onChangeEnd: (value){

            // },
          );
        });
  }
}
