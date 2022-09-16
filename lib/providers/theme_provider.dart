import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Mythemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
      primarySwatch: Colors.deepPurple,
      primaryColor: Colors.white,
      fontFamily: 'Inter'

  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: HexColor('#C4BAE0'),
    colorScheme: ColorScheme.light(),
      primarySwatch: Colors.deepPurple,

      primaryColor: Colors.black,
    fontFamily: 'Poppins'
  );
}