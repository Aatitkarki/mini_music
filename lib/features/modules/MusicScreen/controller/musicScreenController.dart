// import 'dart:math';
// import 'dart:typed_data';

// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_audio_query/flutter_audio_query.dart';
// import 'package:get/get.dart';
// import 'package:logger/logger.dart';

// class MusicScreenController extends GetxController {
//   Logger logger = Logger();
//   AnimationController animationController;

//   var songPosition = 0.obs;

//   AudioPlayer audioPlayer = AudioPlayer();
//   List<SongInfo> songsList;

//   int currentSongIndex = -1;
//   bool isPlaying = false;
//   bool isStopped = true;
//   List<Uint8List> imagesList = [];

//   @override
//   void onInit() {
//     /// For the animation we have to set the upper bound and the widget angle accordingly
//     animationController = AnimationController(
//         vsync: NavigatorState(),
//         duration: Duration(seconds: 5),
//         upperBound: 0.5 * pi);

//     audioPlayer.onAudioPositionChanged.listen((event) {
//       songPosition.value = event.inMilliseconds;
//     });

//     audioPlayer.onPlayerCompletion.listen((event) {
//       isStopped = true;
//       animationController.reset();
//       update();
//     });
//     getData();
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     animationController.dispose();
//     super.dispose();
//   }

//   // getImage() async {
//   //   songsList.forEach((song) async {
//   //     imagesList.add(
//   //         await audioQuery.getArtwork(id: song.id, type: ResourceType.SONG));
//   //   });
//   // }

//   void getData() async {
//     songsList = await songData.getSongs();
//     // logger.i("${songsList[0].title}");
//     // logger.i("THis should be at middle");
//     for (var song in songsList) {
//       Uint8List artWork = await audioQuery.getArtwork(
//           id: song.id, type: ResourceType.SONG, size: Size(100, 100));
//       imagesList.add(artWork);
//     }
//     // logger.i("${imagesList[5]}");
//     // logger.i("this is at last");
//     update();
//   }

//   Future<Uint8List> getImage(int index) async {
//     return audioQuery.getArtwork(
//         id: songsList[index].id, type: ResourceType.SONG, size: Size(100, 100));
//   }

//   int get length => songsList.length;

//   int get songNumber => currentSongIndex + 1;

//   startSong({int index}) async {
//     // logger.i("${audioPlayer.mode} is mode");
//     // logger.i("${audioPlayer.state}");
//     audioPlayer.state == AudioPlayerState.PLAYING ?? audioPlayer.stop();
//     index != null ? currentSongIndex = index : currentSongIndex++;
//     String filePath = songsList[currentSongIndex].filePath;
//     int status = await audioPlayer.play(filePath, isLocal: true);
//     logger.i(status);
//     if (status == 1) {
//       isPlaying = true;
//       animationController.repeat();
//     }
//     update();
//   }

//   pauseSong() {
//     audioPlayer.pause();
//     isPlaying = false;
//     animationController.stop();
//     update();
//   }

//   resumeSong() {
//     audioPlayer.resume();
//     isPlaying = true;
//     animationController.repeat();
//     update();
//   }

//   stopSong() {
//     audioPlayer.stop();
//     isPlaying = false;
//     songPosition.value = 0;
//     animationController.reset();
//     update();
//   }

//   seekSong(Duration duration) {
//     audioPlayer.seek(duration);
//   }

//   SongInfo currentSong() {
//     return songsList[currentSongIndex];
//   }

//   nextSong() {
//     stopSong();
//     if (currentSongIndex < length) {
//       currentSongIndex++;
//     }
//     if (currentSongIndex >= length) return null;

//     startSong(index: currentSongIndex);
//     update();
//   }

//   prevSong() {
//     stopSong();
//     if (currentSongIndex > 0) {
//       currentSongIndex--;
//     }
//     if (currentSongIndex < 0) return null;
//     startSong(index: currentSongIndex);
//     update();
//   }
// }
