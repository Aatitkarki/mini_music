import 'package:dartz/dartz.dart';
import 'package:my_music/data/core/logger.dart';
import 'package:my_music/domain/entities/app_error.dart';
import 'package:my_music/domain/entities/song_entity.dart';

abstract class SongRepository {
  Log log = Log("Song Repository");
  Future<Either<AppError, List<SongEntity>>> getAllSongs();
}
