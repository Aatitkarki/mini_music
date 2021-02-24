import 'package:dartz/dartz.dart';
import 'package:my_music/domain/entities/app_error.dart';

abstract class UseCase<Type, Params> {
  Future<Either<AppError, Type>> call(Params params);
}
