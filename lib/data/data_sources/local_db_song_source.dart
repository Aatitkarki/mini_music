import 'package:get_it/get_it.dart';
import 'package:my_music/common/db/music_database.dart';
import 'package:my_music/data/models/song_response_model.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class LocalDbSongSource {
  Future<List<SongModel>> getDatabaseSongs();
  Future<void> saveSongToDatabase(List<SongModel> songList);
}

class LocalDbSongSourceImpl extends LocalDbSongSource {
  final MusicDatabase musicDatabase;
  LocalDbSongSourceImpl(this.musicDatabase);

  @override
  Future<List<SongModel>> getDatabaseSongs() async {
    List<SongModel> songList = List<SongModel>();
    songList = await musicDatabase.getAllSongsList();
    if (songList != null) {
      return songList;
    } else {
      throw DatabaseException;
    }
  }

  @override
  Future<void> saveSongToDatabase(List<SongModel> songList) async {
    await musicDatabase.batchInsertData(songList);
  }
}
