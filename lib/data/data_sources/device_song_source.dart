import 'dart:io';

import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:my_music/data/models/song_response_model.dart';

abstract class DeviceSongSource {
  Future<List<SongModel>> getDeviceSongs();
}

class DeviceSongSourceImpl extends DeviceSongSource {
  final FlutterAudioQuery audioQuery;
  DeviceSongSourceImpl(this.audioQuery);

  @override
  Future<List<SongModel>> getDeviceSongs() async {
    var data = await audioQuery.getSongs();
    if (data != null) {
      final songsList = data.map((songInfo) {
        Map<String, dynamic> jsonData;
        jsonData = {
          "artistId": songInfo.artistId,
          "artist": songInfo.artist,
          "album": songInfo.album,
          "title": songInfo.title,
          "year": songInfo.year,
          "track": songInfo.track,
          "duration": songInfo.duration,
          "filePath": songInfo.filePath,
          "uri": songInfo.uri
        };
        return SongModel.fromJson(jsonData);
      }).toList();
      return songsList;
    } else {
      throw FileSystemException();
    }
  }
}
