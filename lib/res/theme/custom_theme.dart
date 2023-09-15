// light_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
final ThemeData lightTheme = ThemeData.light().copyWith(

  textTheme: GoogleFonts.figtreeTextTheme(ThemeData.light().textTheme),
);

final ThemeData darkTheme = ThemeData.dark().copyWith(

  textTheme: GoogleFonts.figtreeTextTheme(ThemeData.dark().textTheme),
);
