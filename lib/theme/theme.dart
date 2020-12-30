import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_music/theme/colors.dart';

class AppTheme {
  AppTheme._();
  static final appTheme = AppTheme._();
  ThemeData kDarkTheme = ThemeData(
      backgroundColor: kBackgroundColor,
      canvasColor: kBackgroundColor,
      
      buttonTheme: ButtonThemeData(
        buttonColor: kDarkBlue,
        
      ),
      iconTheme: IconThemeData(color: kDarkBlue),
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
      accentColor: kDarkBlue);
}
