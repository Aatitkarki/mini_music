import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:my_music/features/data/songsData.dart';

class MusicScreenController extends GetxController {
  FlutterAudioQuery audioQuery = FlutterAudioQuery();
  Logger logger = Logger();
  SongData songData;

  AudioPlayer audioPlayer = AudioPlayer();
  List<SongInfo> songsList;
  List<Uint8List> imagesList=[];
  int _currentSongIndex = 0;
  bool isPlaying = false;
  bool isStopped = true;
  // MusicFinder audioPlayer;

  @override
  void onInit() {
    super.onInit();
    songData = SongData();
    getData();
    // getImage();
    // audioPlayer = songData.audioPlayer;
  }

  // getImage() async {
  //   songsList.forEach((song) async {
  //     imagesList.add(
  //         await audioQuery.getArtwork(id: song.id, type: ResourceType.SONG));
  //   }) ;
  //   // update();
  //   // var image = await audioQuery.getArtwork(
  //   //     id: songsList[_currentSongIndex].id, type: ResourceType.SONG);
  //   // return image;
  // }

  void getData() async {
    songsList = await songData.getSongs();
    logger.i("${songsList[0].title}");
    logger.i("THis should be at middle");
    // songsList?.forEach((song) async {
    //   imagesList.add(
    //       await audioQuery.getArtwork(id: song.id, type: ResourceType.SONG));
    // }) ;
    // logger.i("${imagesList[_currentSongIndex]}");
    for(var song in songsList){
      var artWork = await audioQuery.getArtwork(id: song.id, type: ResourceType.SONG);
      imagesList.add(artWork);
    }
    logger.i("this is at last");
    update();
  }

  int get length => songsList.length;

  int get songNumber => _currentSongIndex + 1;
  playLocal() async {
    print("printing files");
    if (_currentSongIndex == -1) {
      // print(songsList[_currentSongIndex].filePath);
      _currentSongIndex++;
      String filePath = songsList[_currentSongIndex].filePath;
      int status = await audioPlayer.play(filePath, isLocal: true);
      if (status == 1) {
        isPlaying = true;
      }
    }
    update();
  }

  pauseLocal() {
    audioPlayer.pause();
    isPlaying = false;
    update();
  }

  SongInfo get nextSong {
    if (_currentSongIndex < length) {
      _currentSongIndex++;
      isPlaying = true;
      update();
    }
    if (_currentSongIndex >= length) return null;

    return songsList[_currentSongIndex];
  }

  SongInfo get prevSong {
    if (_currentSongIndex > 0) {
      _currentSongIndex--;
      update();
    }
    if (_currentSongIndex < 0) return null;

    return songsList[_currentSongIndex];
  }
}
