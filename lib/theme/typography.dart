import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class ChainTypography {
  TextTheme textTheme = TextTheme(
      button: GoogleFonts.roboto(
          textStyle: TextStyle(
              color: ChainColor.white,
              fontSize: 22,
              decoration: TextDecoration.none)),
      bodyText1: GoogleFonts.roboto(
          textStyle: TextStyle(
              color: ChainColor.black,
              fontSize: 16,
              decoration: TextDecoration.none)),
      headline1: GoogleFonts.roboto(
          textStyle: TextStyle(
              color: ChainColor.black,
              fontSize: 32,
              decoration: TextDecoration.none)),
      headline2: GoogleFonts.roboto(
        textStyle: TextStyle(
            color: ChainColor.black,
            fontSize: 24,
            decoration: TextDecoration.none),
      ),
      bodyText2: GoogleFonts.roboto(
          textStyle: TextStyle(
              color: ChainColor.black,
              fontSize: 24,
              decoration: TextDecoration.none)),
      headline3: GoogleFonts.roboto(
          textStyle: TextStyle(
              color: ChainColor.black,
              fontSize: 16,
              decoration: TextDecoration.none))


  );

  static TextStyle socialText = TextStyle();
  static TextStyle smallSubtitle = TextStyle();
  static TextStyle classTitle = TextStyle();
  static TextStyle leaderboardText = TextStyle();
  static TextStyle error = TextStyle();

      
  static TextStyle tokenAmount = TextStyle(
      color: ChainColor.white,
      fontSize: 40,
      decoration: TextDecoration.none
  );
  static TextStyle appBar = TextStyle(
    color: ChainColor.blackText,
    fontSize: 16
  );
}
