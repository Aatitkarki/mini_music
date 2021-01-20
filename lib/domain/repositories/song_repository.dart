import 'package:dartz/dartz.dart';
import 'package:my_music/domain/entities/app_error.dart';
import 'package:my_music/domain/entities/song_entity.dart';

abstract class SongRepository {
  Future<Either<AppError, List<SongEntity>>> getAllSongs();
}
