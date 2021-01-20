import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:my_music/common/db/music_database.dart';
import 'package:my_music/data/core/services.dart';
import 'package:my_music/data/data_sources/device_song_source.dart';
import 'package:my_music/data/data_sources/local_db_song_source.dart';
import 'package:my_music/data/models/song_response_model.dart';
import 'package:my_music/domain/entities/app_error.dart';
import 'package:my_music/domain/entities/no_params.dart';
import 'package:my_music/domain/entities/song_entity.dart';
import 'package:my_music/domain/repositories/song_repository.dart';
import 'package:sqflite/sqflite.dart';

class SongRepositoryImpl extends SongRepository {
  final DeviceSongSource deviceSongSource;
  final LocalDbSongSource localDbSongSource;
  final StartupService startupService;

  SongRepositoryImpl(
      this.deviceSongSource, this.localDbSongSource, this.startupService);

  @override
  Future<Either<AppError, List<SongEntity>>> getAllSongs() async {
    return await getSongsFromDevice();
  }

  Future<Either<AppError, List<SongEntity>>> getSongsFromDevice() async {
    if (startupService.isSongLoaded()) {
      try {
        return Right(await localDbSongSource.getDatabaseSongs());
      } on DatabaseException {
        return Left(AppError(AppErrorType.database));
      }
    } else {
      try {
        List<SongEntity> songList = await deviceSongSource.getDeviceSongs();
        await localDbSongSource.saveSongToDatabase(songList);
        startupService.setSongLoaded(true);
        return Right(songList);
      } on FileSystemException {
        return Left(AppError(AppErrorType.storage));
      }
    }
  }
}
