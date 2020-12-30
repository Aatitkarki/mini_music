import 'dart:typed_data';

import 'package:flutter_audio_query/flutter_audio_query.dart';

class SongData {
  List<SongInfo> _songs;
  FlutterAudioQuery audioQuery;

  Future<List<SongInfo>> getSongs() async {
    audioQuery = FlutterAudioQuery();
    _songs = await audioQuery.getSongs();
    return _songs;
  }



}
