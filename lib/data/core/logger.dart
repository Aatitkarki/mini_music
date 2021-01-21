class Log {
  final String tag;

  static const ansiEsc = '\x1B[';

  static const red = 196;
  static const blue = 12;
  static const green = 34;
  static const orange = 208;

  Log(this.tag);

  // debug
  d(String message) => _print(tag, message, 69);

  static debug(String tag, String message) => _print(tag, message, 69);

  // error
  e(String message) => _print(tag, message, red);

  static error(String tag, String message) => _print(tag, message, red);

  // info
  i(String message) => _print(tag, message, blue);

  static info(String tag, String message) => _print(tag, message, blue);

  // warning
  w(String message) => _print(tag, message, blue);

  static warn(String tag, String message) => _print(tag, message, blue);

  // success
  s(String message) => _print(tag, message, green);

  static success(String tag, String message) => _print(tag, message, green);

  static void _print(tag, message, color) =>
      print("""${ansiEsc}38;5;${color}m$tag : $message\x1B[0m""");
}
