import 'package:get_storage/get_storage.dart';

class StartupService {
  static const String SONGLOADED = "SongLoaded";

  StartupService._();
  static final _instance = StartupService._();

  factory StartupService() {
    return _instance;
  }

  final GetStorage storage = GetStorage();

  bool isSongLoaded() {
    return storage.read("$SONGLOADED") ?? false;
  }

  setSongLoaded(bool value) {
    storage.write("$SONGLOADED", value);
  }
}
