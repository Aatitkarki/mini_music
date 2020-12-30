import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get/get.dart';
import 'package:my_music/features/data/songsData.dart';

class HomePageController extends GetxController {
  SongData songData;

  AudioPlayer audioPlayer = AudioPlayer();
  List<SongInfo> songsList;
  int _currentSongIndex = 2;
  bool isPlaying = false;
  // MusicFinder audioPlayer;

  @override
  void onInit() {
    super.onInit();
    songData = SongData();
    getData();
    // audioPlayer = songData.audioPlayer;
  }

  void getData() async {
    songsList = await songData.getSongs();
  }

  int get length => songsList.length;

  int get songNumber => _currentSongIndex + 1;
  playLocal() async {
    print("printing files");
    if (_currentSongIndex == -1) {
      // print(songsList[_currentSongIndex].filePath);
      _currentSongIndex++;
      String filePath = songsList[6].filePath;
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
