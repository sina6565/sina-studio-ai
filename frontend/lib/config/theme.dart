import 'package:flutter/material.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryGold = Color(0xFFD4AF37);
  static const Color primaryBlack = Color(0xFF1a1a1a);
  static const Color accentGold = Color(0xFFB8860B);
  static const Color lightGold = Color(0xFFFFD700);
  
  // Background Colors
  static const Color backgroundColor = Color(0xFF0f0f0f);
  static const Color surfaceColor = Color(0xFF2a2a2a);
  static const Color cardColor = Color(0xFF1f1f1f);
  
  // Text Colors
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFFB3B3B3);
  static const Color errorColor = Color(0xFFE74C3C);
  static const Color successColor = Color(0xFF27AE60);
  
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryGold,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryBlack,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: primaryGold),
      titleTextStyle: TextStyle(
        color: primaryGold,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'VazirmatnFD',
      ),
    ),
    cardTheme: CardTheme(
      color: cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: primaryGold, width: 1),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGold,
        foregroundColor: primaryBlack,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'VazirmatnFD',
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      hintStyle: TextStyle(color: secondaryText, fontFamily: 'VazirmatnFD'),
      labelStyle: TextStyle(color: primaryGold, fontFamily: 'VazirmatnFD'),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryGold, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryGold, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: lightGold, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: errorColor, width: 1),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primaryGold,
        fontFamily: 'VazirmatnFD',
      ),
      displayMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: primaryGold,
        fontFamily: 'VazirmatnFD',
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: primaryText,
        fontFamily: 'VazirmatnFD',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: secondaryText,
        fontFamily: 'VazirmatnFD',
      ),
    ),
  );
}
