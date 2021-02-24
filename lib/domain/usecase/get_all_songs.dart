import 'package:my_music/data/core/logger.dart';
import 'package:my_music/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:my_music/domain/entities/no_params.dart';
import 'package:my_music/domain/entities/song_entity.dart';
import 'package:my_music/domain/repositories/song_repository.dart';
import 'package:my_music/domain/usecase/usecase.dart';

class GetAllSongs implements UseCase<List<SongEntity>, NoParams> {
  Log log = Log("GET ALL SONGS");
  final SongRepository repository;
  GetAllSongs(this.repository);

  @override
  Future<Either<AppError, List<SongEntity>>> call(NoParams noParams) async {
    return await repository.getAllSongs();
  }
}
