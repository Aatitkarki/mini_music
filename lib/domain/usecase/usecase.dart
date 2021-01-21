import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_music/domain/entities/app_error.dart';

abstract class UseCase<Type, Params> {
  Future<Either<AppError, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
