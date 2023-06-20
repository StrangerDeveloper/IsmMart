import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ism_mart/exports/exports_utils.dart';

class ThemeHelper {
  static ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.green,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.lato(
              color: Colors.black, fontWeight: FontWeight.w600),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.grey.shade50,
          elevation: 0),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
          hintStyle: GoogleFonts.lato(
            fontSize: 14,
          )),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: kPrimaryColor),
      textTheme: TextTheme(
          displayLarge: GoogleFonts.lato(
              letterSpacing: -1.5,
              fontSize: 48,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          displayMedium: GoogleFonts.lato(
              letterSpacing: -1.0,
              fontSize: 40,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          displaySmall: GoogleFonts.lato(
              letterSpacing: -1.0,
              fontSize: 32,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          headlineMedium: GoogleFonts.lato(
              letterSpacing: -1.0,
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.w600),
          headlineSmall: GoogleFonts.lato(
              letterSpacing: -1.0,
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500),
          titleLarge: GoogleFonts.lato(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          titleMedium: GoogleFonts.lato(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          titleSmall: GoogleFonts.lato(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          bodyLarge: GoogleFonts.lato(
              color: Colors.grey.shade700,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          bodyMedium: GoogleFonts.lato(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.w400),
          labelLarge: GoogleFonts.lato(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
          bodySmall: GoogleFonts.lato(
              color: Colors.grey.shade800,
              fontSize: 12,
              fontWeight: FontWeight.w400),
          labelSmall: GoogleFonts.lato(
              color: Colors.grey.shade700,
              fontSize: 10,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.5)));

  static ThemeData darkTheme = ThemeData(
    primaryColor: kPrimaryColor,
    primarySwatch: Colors.green,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kGrey900,
    appBarTheme: AppBarTheme(
      backgroundColor: kGrey900,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        hintStyle: GoogleFonts.lato(
          fontSize: 14,
        )),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: kPrimaryColor),
    textTheme: TextTheme(
        displayLarge: GoogleFonts.lato(
            letterSpacing: -1.5,
            fontSize: 48,
            color: Colors.grey.shade50,
            fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.lato(
            letterSpacing: -1.0,
            fontSize: 40,
            color: Colors.grey.shade50,
            fontWeight: FontWeight.bold),
        displaySmall: GoogleFonts.lato(
            letterSpacing: -1.0,
            fontSize: 32,
            color: Colors.grey.shade50,
            fontWeight: FontWeight.bold),
        headlineMedium: GoogleFonts.lato(
            letterSpacing: -1.0,
            color: Colors.grey.shade50,
            fontSize: 28,
            fontWeight: FontWeight.w600),
        headlineSmall: GoogleFonts.lato(
            letterSpacing: -1.0,
            color: Colors.grey.shade50,
            fontSize: 24,
            fontWeight: FontWeight.w500),
        titleLarge: GoogleFonts.lato(
            color: Colors.grey.shade50,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        titleMedium: GoogleFonts.lato(
            color: Colors.grey.shade50,
            fontSize: 16,
            fontWeight: FontWeight.w500),
        titleSmall: GoogleFonts.lato(
            color: Colors.grey.shade50,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        bodyLarge: GoogleFonts.lato(
            color: Colors.grey.shade50,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        bodyMedium: GoogleFonts.lato(
            color: Colors.grey.shade50,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        labelLarge: GoogleFonts.lato(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
        bodySmall: GoogleFonts.lato(
            color: Colors.grey.shade50,
            fontSize: 12,
            fontWeight: FontWeight.w500),
        labelSmall: GoogleFonts.lato(
            color: Colors.grey.shade50,
            fontSize: 10,
            fontWeight: FontWeight.w400)),
    bottomAppBarTheme: BottomAppBarTheme(color: kGrey800),
  );
}
