import 'package:my_music/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:my_music/domain/entities/no_params.dart';
import 'package:my_music/domain/entities/song_entity.dart';
import 'package:my_music/domain/repositories/song_repository.dart';
import 'package:my_music/domain/usecase/usecase.dart';

class GetFavouriteSongs implements UseCase<List<SongEntity>, NoParams> {
  final SongRepository repository;

  GetFavouriteSongs(this.repository);

  @override
  Future<Either<AppError, List<SongEntity>>> call(NoParams params) async {
    return await repository.getFavouriteSongs();
  }
}
