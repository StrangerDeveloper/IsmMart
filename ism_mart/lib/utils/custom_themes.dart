import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class Themes {
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
          headline1: GoogleFonts.lato(
              letterSpacing: -1.5,
              fontSize: 48,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          headline2: GoogleFonts.lato(
              letterSpacing: -1.0,
              fontSize: 40,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          headline3: GoogleFonts.lato(
              letterSpacing: -1.0,
              fontSize: 32,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          headline4: GoogleFonts.lato(
              letterSpacing: -1.0,
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.w600),
          headline5: GoogleFonts.lato(
              letterSpacing: -1.0,
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500),
          headline6: GoogleFonts.lato(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          subtitle1: GoogleFonts.lato(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          subtitle2: GoogleFonts.lato(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          bodyText1: GoogleFonts.lato(
              color: Colors.grey.shade700,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          bodyText2: GoogleFonts.lato(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.w400),
          button: GoogleFonts.lato(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
          caption: GoogleFonts.lato(
              color: Colors.grey.shade800,
              fontSize: 12,
              fontWeight: FontWeight.w400),
          overline: GoogleFonts.lato(
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
        headline1: GoogleFonts.lato(
            letterSpacing: -1.5,
            fontSize: 48,
            color: Colors.grey.shade50,
            fontWeight: FontWeight.bold),
        headline2: GoogleFonts.lato(
            letterSpacing: -1.0,
            fontSize: 40,
            color: Colors.grey.shade50,
            fontWeight: FontWeight.bold),
        headline3: GoogleFonts.lato(
            letterSpacing: -1.0,
            fontSize: 32,
            color: Colors.grey.shade50,
            fontWeight: FontWeight.bold),
        headline4: GoogleFonts.lato(
            letterSpacing: -1.0,
            color: Colors.grey.shade50,
            fontSize: 28,
            fontWeight: FontWeight.w600),
        headline5: GoogleFonts.lato(
            letterSpacing: -1.0,
            color: Colors.grey.shade50,
            fontSize: 24,
            fontWeight: FontWeight.w500),
        headline6: GoogleFonts.lato(
            color: Colors.grey.shade50,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        subtitle1: GoogleFonts.lato(
            color: Colors.grey.shade50,
            fontSize: 16,
            fontWeight: FontWeight.w500),
        subtitle2: GoogleFonts.lato(
            color: Colors.grey.shade50,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        bodyText1: GoogleFonts.lato(
            color: Colors.grey.shade50,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        bodyText2: GoogleFonts.lato(
            color: Colors.grey.shade50,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        button: GoogleFonts.lato(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
        caption: GoogleFonts.lato(
            color: Colors.grey.shade50,
            fontSize: 12,
            fontWeight: FontWeight.w500),
        overline: GoogleFonts.lato(
            color: Colors.grey.shade50,
            fontSize: 10,
            fontWeight: FontWeight.w400)), bottomAppBarTheme: BottomAppBarTheme(color: kGrey800),
  );
}
