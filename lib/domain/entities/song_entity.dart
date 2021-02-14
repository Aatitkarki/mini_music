import 'package:equatable/equatable.dart';

class SongEntity extends Equatable {
  final int songId;
  final String artist;
  final String artistId;
  final String album;
  final String title;
  final String year;
  final String track;
  final String duration;
  final String filePath;
  final String uri;
  bool isFavourite;
  SongEntity(
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
      this.isFavourite});

  @override
  List<Object> get props => [songId, title];
}
