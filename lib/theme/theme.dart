import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supply_chain/theme/typography.dart';

import 'colors.dart';

class ChainTheme {
  ThemeData themeData = ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(TextStyle(
              fontSize: 24
            )),
              elevation: MaterialStateProperty.all(5.0),
              backgroundColor: MaterialStateProperty.all(ChainColor.primary),

          ),


      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ChainColor.white,
        titleTextStyle: ChainTypography.appBar,
        toolbarTextStyle: ChainTypography.appBar,
        iconTheme: IconThemeData(color: ChainColor.blackText),
        centerTitle: true,
        elevation: 0.0,
      ),
      textTheme: ChainTypography().textTheme,
      scaffoldBackgroundColor: ChainColor.white);
}
