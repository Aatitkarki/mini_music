import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_music/data/core/logger.dart';
import 'package:my_music/presentation/journey/music_player_screen/controller/music_page_controller.dart';
import 'package:my_music/presentation/journey/music_player_screen/page/music_player_screen.dart';
import 'package:my_music/presentation/theme/colors.dart';
import 'package:my_music/presentation/widgets/song_item_widget.dart';

class SongsList extends StatelessWidget {
  const SongsList({
    Key key,
    @required this.musicController,
  }) : super(key: key);

  final MusicController musicController;

  @override
  Widget build(BuildContext context) {
    Log l = Log("Home Screen");
    return GetBuilder<MusicController>(builder: (_) {
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
          : ListView.builder(
              padding: EdgeInsets.zero,
              // physics: BouncingScrollPhysics(),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                l.d("rebuilding data");
                return SongItemWidget(
                  onPressed: () {
                    musicController.startSong(index: index);
                    Get.to(MusicPlayingScreen(
                      index: index,
                    ));
                  },
                  title: musicController.songsList[index].title,
                );
              },
            );
    });
  }
}
