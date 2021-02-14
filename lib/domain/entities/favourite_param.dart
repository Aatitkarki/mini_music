import 'package:equatable/equatable.dart';

class FavouriteParams extends Equatable {
  final int id;
  final int value;

  const FavouriteParams(this.id, this.value);

  @override
  List<Object> get props => [id];
}
