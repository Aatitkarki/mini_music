import 'package:my_music/domain/entities/song_entity.dart';

class SongModel extends SongEntity {
  final int songId;
  final String artistId;
  final String artist;
  final String album;
  final String title;
  final String year;
  final String track;
  final String duration;
  final String filePath;
  final String uri;
  bool isFavourite;
  SongModel(
      {this.songId,
      this.artistId,
      this.artist,
      this.album,
      this.title,
      this.year,
      this.track,
      this.duration,
      this.filePath,
      this.uri,
      this.isFavourite})
      : super(
            songId: songId,
            album: album,
            artist: artist,
            artistId: artistId,
            duration: duration,
            filePath: filePath,
            title: title,
            track: track,
            uri: uri,
            year: year,
            isFavourite: isFavourite);

  factory SongModel.fromJson(Map<String, dynamic> data) {
    return SongModel(
        songId: data["songId"],
        album: data["album"],
        artist: data["artist"],
        artistId: data["artistId"],
        duration: data["duration"],
        filePath: data["filePath"],
        title: data["title"],
        track: data["track"],
        uri: data["uri"],
        year: data["year"],
        isFavourite: data["isFavourite"] == 1 ? true : false);
  }

  Map<String, dynamic> toMap() {
    return {
      "songId": songId,
      "artistId": artistId,
      "artist": artist,
      "album": album,
      "title": title,
      "year": year,
      "track": track,
      "duration": duration,
      "filePath": filePath,
      "uri": uri,
      "isFavourite": isFavourite ? 1 : 0,
    };
  }
}
