import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:my_music/data/core/logger.dart';
import 'package:my_music/domain/entities/favourite_param.dart';
import 'package:my_music/domain/entities/no_params.dart';
import 'package:my_music/domain/entities/song_entity.dart';
import 'package:my_music/domain/usecase/change_favourite_status.dart';
import 'package:my_music/domain/usecase/get_all_songs.dart';
import 'dart:math';

class MusicController extends GetxController {
  AnimationController animationController;
  int currentSongIndex = -1;
  var songPosition = 0.obs;
  bool isPlaying = false;
  bool isStopped = true;
  final AudioPlayer audioPlayer;
  final GetAllSongs getAllSongs;
  final ChangeFavouriteStatus changeFavouriteStatus;
  List<SongEntity> songsList = List<SongEntity>();

  // List<Uint8List> imagesList = [];

  MusicController(
      this.audioPlayer, this.getAllSongs, this.changeFavouriteStatus);

  @override
  void onInit() {
    loadSong();

    // For the animation we have to set the upper bound and the widget angle accordingly
    animationController = AnimationController(
        vsync: NavigatorState(),
        duration: Duration(seconds: 5),
        upperBound: 0.5 * pi);

    audioPlayer.onAudioPositionChanged.listen((event) {
      songPosition.value = event.inSeconds;
    });

    audioPlayer.onPlayerCompletion.listen((event) {
      isStopped = true;
      animationController.reset();
      nextSong();
      update();
    });
    super.onInit();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    animationController.dispose();
    super.dispose();
  }

  loadSong() async {
    var data = await getAllSongs(NoParams());
    data.fold((l) {
      print("The error is $l");
    }, (r) {
      songsList = r;
    });
    update();
  }

  startSong({int index}) async {
    audioPlayer.state == AudioPlayerState.PLAYING ?? audioPlayer.stop();
    index != null ? currentSongIndex = index : currentSongIndex++;
    String filePath = songsList[currentSongIndex].filePath;
    int status = await audioPlayer.play(filePath, isLocal: true);
    if (status == 1) {
      isStopped = false;
      isPlaying = true;
      animationController.repeat();
    }
    update();
  }

  int get length => songsList.length;

  int get songNumber => currentSongIndex + 1;

  pauseSong() {
    audioPlayer.pause();
    isPlaying = false;
    animationController.stop();
    update();
  }

  resumeSong() {
    audioPlayer.resume();
    isPlaying = true;
// isStopped = false;
    animationController.repeat();
    update();
  }

  stopSong() {
    audioPlayer.stop();
    isPlaying = false;
    songPosition.value = 0;
    animationController.reset();
    update();
  }

  seekSong(Duration duration) {
    audioPlayer.seek(duration);
  }

  SongEntity currentSong() {
    return songsList[currentSongIndex];
  }

  nextSong() {
    stopSong();

    if (currentSongIndex < length - 1) {
      currentSongIndex++;
    }
    if (currentSongIndex >= length) return null;

    startSong(index: currentSongIndex);
    update();
  }

  prevSong() {
    stopSong();
    if (currentSongIndex > 0) {
      currentSongIndex--;
    }
    if (currentSongIndex < 0) return null;
    startSong(index: currentSongIndex);
    update();
  }

  changeFavStat() async {
    if (currentSong().isFavourite) {
      fav
    }

    songsList[currentSongIndex].isFavourite =
        !songsList[currentSongIndex].isFavourite;
    update();
  }
}
