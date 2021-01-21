import 'dart:io';
import 'package:my_music/data/models/song_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MusicDatabase {
  static MusicDatabase _musicDatabase;
  Database _database;
  static String musicTable = "MUSIC_TABLE";
  String songIdCol = "songId";
  String artistCol = "artist";
  String artistIdCol = "artistId";
  String albumCol = "album";
  String titleCol = "title";
  String yearCol = "year";
  String trackCol = "track";
  String durationCol = "duration";
  String filePathCol = "filePath";
  String uriCol = "uri";

  MusicDatabase._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory MusicDatabase() {
    if (_musicDatabase == null) {
      _musicDatabase = MusicDatabase
          ._createInstance(); // This is executed only once, singleton object
    }
    return _musicDatabase;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'musicList.db';
    //open or create database
    var dealsDatabase =
        await openDatabase(path, version: 3, onCreate: _createDB);
    return dealsDatabase;
  }

  void _createDB(Database db, int newVersion) async {
    print('called helper');
    await db.execute(
        'CREATE TABLE $musicTable($songIdCol INTEGER PRIMARY KEY AUTOINCREMENT, $artistCol TEXT, $artistIdCol TEXT, $albumCol TEXT,'
        ' $titleCol TEXT, $yearCol TEXT, $trackCol TEXT, $durationCol TEXT, $filePathCol TEXT,$uriCol TEXT )');
  }

  Future<bool> batchInsertData(List<SongModel> songsList) async {
    try {
      Database db = await this.database;
      db.transaction((txn) async {
        Batch batch = txn.batch();
        for (var song in songsList) {
          batch.insert(musicTable, song.toMap());
        }
        batch.commit();
      });
    } on DatabaseException catch (e) {
      return false;
    }
    return true;
  }

  Future<List<SongModel>> getAllSongsList() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $musicTable');
    List<SongModel> songList = List<SongModel>();
    for (var song in result) {
      songList.add(SongModel.fromJson(song));
    }
    return songList;
  }
}
