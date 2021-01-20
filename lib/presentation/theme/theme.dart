import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_music/presentation/theme/colors.dart';

class AppTheme {
  AppTheme._();
  static final appTheme = AppTheme._();
  ThemeData kDarkTheme = ThemeData(
    accentColor: kDarkBlue,
    backgroundColor: kBackgroundColor,
    canvasColor: kBackgroundColor,
    buttonTheme: ButtonThemeData(
      buttonColor: kViolet,
    ),
    iconTheme: IconThemeData(color: kViolet),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
        headline1: TextStyle(color: kPureWhite),
        button: TextStyle(fontSize: 18),
        headline2: TextStyle(color: kPureWhite),
        headline3: TextStyle(color: kPureWhite),
        headline4: TextStyle(color: kPureWhite),
        headline5: TextStyle(color: kPureWhite, fontWeight: FontWeight.w600),
        headline6: TextStyle(color: kPureWhite),
        bodyText1: TextStyle(color: kPureWhite),
        bodyText2: TextStyle(color: kPureWhite)),
    sliderTheme: SliderThemeData(
      activeTrackColor: kSliderColor,
      inactiveTrackColor: Colors.transparent,
      trackHeight: 3.0,
      thumbColor: kSliderColor,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
      overlayColor: Colors.purple.withAlpha(32),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
    ),
  );
}
