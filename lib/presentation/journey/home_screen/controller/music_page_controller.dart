import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:my_music/data/core/logger.dart';
import 'package:my_music/domain/entities/song_entity.dart';
import 'package:my_music/domain/usecase/get_all_songs.dart';
import 'package:my_music/domain/usecase/usecase.dart';
import 'dart:math';

class MusicController extends GetxController {
  Log log = Log("Music Controller");
  AnimationController animationController;
  int currentSongIndex = -1;
  var songPosition = 0.obs;
  bool isPlaying = false;
  bool isStopped = true;
  final AudioPlayer audioPlayer;
  final GetAllSongs getAllSongs;
  List<SongEntity> songsList = List<SongEntity>();
  // List<Uint8List> imagesList = [];

  MusicController(this.audioPlayer, this.getAllSongs);

  @override
  void onInit() {
    loadSong();

    // For the animation we have to set the upper bound and the widget angle accordingly
    animationController = AnimationController(
        vsync: NavigatorState(),
        duration: Duration(seconds: 5),
        upperBound: 0.5 * pi);

    audioPlayer.onAudioPositionChanged.listen((event) {
      songPosition.value = event.inMilliseconds;
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
      isPlaying = true;
      animationController.repeat();
    }
    update();
  }

  // getImage() async {
  //   songsList.forEach((song) async {
  //     imagesList.add(
  //         await audioQuery.getArtwork(id: song.id, type: ResourceType.SONG));
  //   });
  // }

  // void getData() async {
  //   songsList = await songData.getSongs();
  //   // logger.i("${songsList[0].title}");
  //   // logger.i("THis should be at middle");
  //   for (var song in songsList) {
  //     Uint8List artWork = await audioQuery.getArtwork(
  //         id: song.id, type: ResourceType.SONG, size: Size(100, 100));
  //     imagesList.add(artWork);
  //   }
  //   // logger.i("${imagesList[5]}");
  //   // logger.i("this is at last");
  //   update();
  // }

  // Future<Uint8List> getImage(int index) async {
  //   return audioQuery.getArtwork(
  //       id: songsList[index].id, type: ResourceType.SONG, size: Size(100, 100));
  // }

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
    if (currentSongIndex < length) {
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
}
