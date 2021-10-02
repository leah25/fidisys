import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const backgroundColor = Color(0xFF1A121E);
  static const mainTextColor = Color(0xFFFEFEFE);
  static const formColor = Color(0xFF292333);
  static const buttonColor = Color(0xFFFCBC3C);
  static const textColor = Colors.white70;

  static var textDisplayedStyleLarge = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: AppTheme.mainTextColor,
          fontSize: 32,
          fontWeight: FontWeight.w600));
  static var textDisplayedStyleMedium = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: AppTheme.mainTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w600));
  static var textDisplayedStyleSmall = GoogleFonts.poppins(
    textStyle: TextStyle(
        color: AppTheme.mainTextColor,
        fontSize: 18,
        fontWeight: FontWeight.w600),
  );
  static var textDisplayedStyleSmallest = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: AppTheme.mainTextColor,
      fontSize: 14,
    ),
  );
  static var addPageDisplayedStyleSmallest = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: AppTheme.textColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );
}
