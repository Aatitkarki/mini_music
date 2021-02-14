import 'package:my_music/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:my_music/domain/entities/favourite_param.dart';
import 'package:my_music/domain/repositories/song_repository.dart';
import 'package:my_music/domain/usecase/usecase.dart';

class ChangeFavouriteStatus implements UseCase<int, FavouriteParams> {
  final SongRepository songRepository;
  ChangeFavouriteStatus(this.songRepository);

  @override
  Future<Either<AppError, int>> call(FavouriteParams params) async {
    await songRepository.changeFavouriteStatus(params.id, params.value);
  }
}
