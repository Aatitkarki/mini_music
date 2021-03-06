import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get_it/get_it.dart';
import 'package:my_music/common/db/music_database.dart';
import 'package:my_music/data/core/services.dart';
import 'package:my_music/data/data_sources/device_song_source.dart';
import 'package:my_music/data/data_sources/local_db_song_source.dart';
import 'package:my_music/data/repositories/song_repository_impl.dart';
import 'package:my_music/domain/repositories/song_repository.dart';
import 'package:my_music/domain/usecase/change_favourite_status.dart';
import 'package:my_music/domain/usecase/get_all_songs.dart';
import 'package:my_music/domain/usecase/get_favourite_songs.dart';
import 'package:my_music/presentation/journey/favourite_songs_screen/controller/favourite_songs_screen_controller.dart';
import 'package:my_music/presentation/journey/home_screen/controller/home_screen_controller.dart';
import 'package:my_music/presentation/journey/music_player_screen/controller/music_page_controller.dart';

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

  getItInstance.registerLazySingleton<HomeScreenController>(
      () => HomeScreenController());
  getItInstance.registerLazySingleton<FavouriteSongScreenController>(
      () => FavouriteSongScreenController(getItInstance(), getItInstance()));
  getItInstance
      .registerLazySingleton<GetAllSongs>(() => GetAllSongs(getItInstance()));
  getItInstance.registerLazySingleton<GetFavouriteSongs>(
      () => GetFavouriteSongs(getItInstance()));

  getItInstance.registerLazySingleton<ChangeFavouriteStatus>(
      () => ChangeFavouriteStatus(getItInstance()));

  getItInstance.registerLazySingleton<AudioPlayer>(() => AudioPlayer());

  getItInstance.registerLazySingleton<MusicController>(
      () => MusicController(getItInstance(), getItInstance(), getItInstance()));
}
