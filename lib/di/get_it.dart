import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get_it/get_it.dart';
import 'package:my_music/common/db/music_database.dart';
import 'package:my_music/data/core/services.dart';
import 'package:my_music/data/data_sources/device_song_source.dart';
import 'package:my_music/data/data_sources/local_db_song_source.dart';
import 'package:my_music/data/repositories/song_repository_impl.dart';
import 'package:my_music/domain/repositories/song_repository.dart';

final getItInstance = GetIt.I;

Future init() {
  getItInstance.registerLazySingleton<StartupService>(() => StartupService());
  getItInstance
      .registerLazySingleton<FlutterAudioQuery>(() => FlutterAudioQuery());

  getItInstance.registerLazySingleton<MusicDatabase>(() => MusicDatabase());

  getItInstance.registerLazySingleton<DeviceSongSource>(
      () => DeviceSongSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<LocalDbSongSource>(
      () => LocalDbSongSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<SongRepository>(() =>
      SongRepositoryImpl(getItInstance(), getItInstance(), getItInstance()));
}
