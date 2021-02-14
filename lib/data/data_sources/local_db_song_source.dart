import 'package:my_music/common/db/music_database.dart';
import 'package:my_music/data/core/logger.dart';
import 'package:my_music/data/models/song_model.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class LocalDbSongSource {
  Future<List<SongModel>> getDatabaseSongs();
  Future<void> saveSongToDatabase(List<SongModel> songList);
  Future<int> changeFavouriteStatus(int index, int value);
  Future<List<SongModel>> getFavouriteSongs();
}

class LocalDbSongSourceImpl extends LocalDbSongSource {
  Log log = Log("Local Database Song source Impl");
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

  @override
  Future<int> changeFavouriteStatus(int index, int value) async {
    print("The index is $index and the value is $value");
    await musicDatabase.setFavouriteToDatabase(index, value);
    return 1;
  }

  @override
  Future<List<SongModel>> getFavouriteSongs() async {
    List<SongModel> songList = List<SongModel>();
    songList = await musicDatabase.getFavouriteSongs();
    if (songList != null) {
      return songList;
    } else {
      throw Exception("NullFavourite");
    }
  }
}
