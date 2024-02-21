import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';



ThemeData darkTheme() => ThemeData(
    primaryColor: const Color(0xFF8687E7),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF121212),
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:  Color(0xFF121212),
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        )),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.lato(
        textStyle: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.w700,
          fontSize: 32,
        ),
      ),
      displayMedium: GoogleFonts.lato(
        textStyle: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w400,
            fontSize: 16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: Colors.white,
      fillColor: const Color(0xFF1D1D1D),
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white)),
      hintStyle: GoogleFonts.lato(
        textStyle: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w400,
            fontSize: 16),
      ),
    ));

ThemeData lightTheme() => ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0.0,
        foregroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark // For Android (dark icons)
            )),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.lato(
        textStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 32,
        ),
      ),
      displayMedium: GoogleFonts.lato(
        textStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: Colors.black,
      fillColor: Colors.grey[400],
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black)),
      hintStyle: GoogleFonts.lato(
        textStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
      ),
    ));
