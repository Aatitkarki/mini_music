import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/domain/usecase/change_favourite_status.dart';
import 'package:my_music/domain/usecase/get_all_songs.dart';
import 'package:my_music/presentation/journey/all_songs_screen/page/all_songs_screen.dart';
import 'package:my_music/presentation/journey/home_screen/controller/home_screen_controller.dart';
import 'package:my_music/presentation/journey/home_screen/widgets/custom_appbar.dart';
import 'package:my_music/presentation/journey/music_player_screen/controller/music_page_controller.dart';
import 'package:my_music/di/get_it.dart' as getIt;
import 'package:my_music/presentation/journey/music_player_screen/page/music_player_screen.dart';
import 'package:my_music/presentation/theme/colors.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  final MusicController musicController = Get.put(MusicController(
      getIt.getItInstance<AudioPlayer>(),
      getIt.getItInstance<GetAllSongs>(),
      getIt.getItInstance<ChangeFavouriteStatus>()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: musicController.isPlaying ? 0.86 : 1,
              child: Column(children: [
                customAppBar(context),

                Divider(
                  height: 2,
                  color: kDarkBlack,
                ),
                //TODO: Implement the custom tabbar view using getx and navigation
                TabBar(
                  isScrollable: true,
                  controller: homeScreenController.tabController,
                  tabs: homeScreenController.tabList,
                ),
                Expanded(
                    child: TabBarView(
                  controller: homeScreenController.tabController,
                  children: [
                    SongsList(
                      musicController: musicController,
                    ),
                    Center(
                      child: Text(
                        'Place 2 Bid',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Place 3 Bid',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    // second tab bar view widget
                    Center(
                      child: Text(
                        'Buy Now',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                )),
                Divider(
                  height: 2,
                  color: kDarkBlack,
                ),
              ]),
            ),
            GetBuilder<MusicController>(builder: (musicController) {
              return musicController.isStopped
                  ? SizedBox.shrink()
                  : buildMiniPlayer();
            })
          ],
        ),
      ),
    );
  }

  Widget buildMiniPlayer() {
    return FractionallySizedBox(
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
                      borderRadius: BorderRadius.circular(10)),
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
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
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
    );
  }
}
