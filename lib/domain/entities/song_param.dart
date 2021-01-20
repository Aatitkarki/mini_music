import 'package:equatable/equatable.dart';

class SongParams extends Equatable {
  final int id;

  const SongParams(this.id);

  @override
  List<Object> get props => [id];
}
