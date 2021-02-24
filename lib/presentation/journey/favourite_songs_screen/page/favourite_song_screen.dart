import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_music/presentation/journey/favourite_songs_screen/controller/favourite_songs_screen_controller.dart';
import 'package:my_music/presentation/theme/colors.dart';
import 'package:my_music/presentation/widgets/song_item_widget.dart';

class FavouriteSongScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouriteSongScreenController>(builder: (_) {
      final int itemCount = _.favouriteSongsList.length;
      return _.favouriteSongsList == null
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
                return SongItemWidget(
                  onPressed: () {
                    // _.startSong(index: index);
                    // Get.to(MusicPlayingScreen(
                    //   index: index,
                    // ));
                  },
                  title: _.favouriteSongsList[index].title,
                );
              },
            );
    });
  }
}
