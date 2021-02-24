import 'package:get/get.dart';
import 'package:my_music/data/core/logger.dart';
import 'package:my_music/domain/entities/favourite_param.dart';
import 'package:my_music/domain/entities/no_params.dart';
import 'package:my_music/domain/entities/song_entity.dart';
import 'package:my_music/domain/usecase/change_favourite_status.dart';
import 'package:my_music/domain/usecase/get_favourite_songs.dart';

class FavouriteSongScreenController extends GetxController {
  final GetFavouriteSongs _getFavouriteSongs;
  final ChangeFavouriteStatus _changeFavouriteStatus;
  FavouriteSongScreenController(
      this._getFavouriteSongs, this._changeFavouriteStatus);
  List<SongEntity> favouriteSongsList = List<SongEntity>();
  @override
  void onInit() {
    loadFavouriteSongs();
    super.onInit();
  }

  loadFavouriteSongs() async {
    var data = await _getFavouriteSongs(NoParams());
    data.fold((l) {
      print("The error is $l");
    }, (r) {
      print("Getting the data");
      favouriteSongsList = r;
    });
  }

  addToFavourite(SongEntity song) async {
    favouriteSongsList.add(song);
    await _changeFavouriteStatus(FavouriteParams(song.songId, 1));
    update();
  }

  removeFromFavourite(int id, {int index}) async {
    index ?? searchIndex(id);
    Log("").i("$index");
    await _changeFavouriteStatus(
        FavouriteParams(favouriteSongsList[index].songId, 0));
    favouriteSongsList.removeAt(index);
  }

  int searchIndex(int id) {
    for (int i = 0; i < favouriteSongsList.length; i++) {
      if (favouriteSongsList[i].songId == id) {
        return i;
      }
    }
    return -1;
  }
}
