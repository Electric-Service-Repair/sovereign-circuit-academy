// File: lib/core/theme/vader_theme.dart
// *heavy breathing* 🫁 The theme of the dark side...

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'vader_colors.dart';

/// Darth Vader's Imperial Theme
/// Where weakness meets its end and precision reigns supreme
class VaderTheme {
  VaderTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Primary Colors
      primaryColor: VaderColors.redSith,
      scaffoldBackgroundColor: VaderColors.blackVoid,
      canvasColor: VaderColors.blackCarbon,
      
      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: VaderColors.redSith,
        secondary: VaderColors.redBlood,
        tertiary: VaderColors.silverChrome,
        background: VaderColors.blackVoid,
        surface: VaderColors.blackCarbon,
        error: VaderColors.error,
        onPrimary: VaderColors.blackVoid,
        onSecondary: VaderColors.blackVoid,
        onTertiary: VaderColors.blackVoid,
        onBackground: VaderColors.silverChrome,
        onSurface: VaderColors.silverChrome,
        onError: VaderColors.blackVoid,
      ),
      
      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: VaderColors.blackVoid,
        foregroundColor: VaderColors.redSith,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'StarJedi',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: VaderColors.redSith,
          letterSpacing: 2,
        ),
      ),
      
      // Card Theme
      cardTheme: CardTheme(
        color: VaderColors.blackCarbon,
        elevation: 8,
        shadowColor: VaderColors.redSith.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: VaderColors.redDark,
            width: 1,
          ),
        ),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: VaderColors.redSith,
          foregroundColor: VaderColors.blackVoid,
          elevation: 8,
          shadowColor: VaderColors.redSith,
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          minimumSize: const Size(48, 48), // Glove-friendly
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontFamily: 'StarJedi',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: VaderColors.redSith,
          side: const BorderSide(
            color: VaderColors.redSith,
            width: 2,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          minimumSize: const Size(48, 48), // Glove-friendly
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontFamily: 'StarJedi',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: VaderColors.redSith,
          minimumSize: const Size(48, 48), // Glove-friendly
          textStyle: const TextStyle(
            fontFamily: 'StarJedi',
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: VaderColors.blackSteel,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: VaderColors.grayDark,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: VaderColors.grayDark,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: VaderColors.redSith,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: VaderColors.error,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: VaderColors.error,
            width: 3,
          ),
        ),
        labelStyle: const TextStyle(
          color: VaderColors.grayLight,
          fontFamily: 'StarJedi',
        ),
        hintStyle: const TextStyle(
          color: VaderColors.grayMedium,
          fontFamily: 'StarJedi',
        ),
      ),
      
      // Text Theme
      textTheme: GoogleFonts.robotoTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'StarJedi',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: VaderColors.redSith,
            letterSpacing: 2,
          ),
          displayMedium: TextStyle(
            fontFamily: 'StarJedi',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: VaderColors.redSith,
            letterSpacing: 2,
          ),
          displaySmall: TextStyle(
            fontFamily: 'StarJedi',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: VaderColors.redSith,
            letterSpacing: 2,
          ),
          headlineLarge: TextStyle(
            fontFamily: 'StarJedi',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: VaderColors.silverChrome,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'StarJedi',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: VaderColors.silverChrome,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'StarJedi',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: VaderColors.silverChrome,
          ),
          titleLarge: TextStyle(
            fontFamily: 'StarJedi',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: VaderColors.redSith,
          ),
          titleMedium: TextStyle(
            fontFamily: 'StarJedi',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: VaderColors.silverChrome,
          ),
          titleSmall: TextStyle(
            fontFamily: 'StarJedi',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: VaderColors.silverChrome,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: VaderColors.silverChrome,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: VaderColors.grayLight,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: VaderColors.grayMedium,
          ),
        ),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: VaderColors.redSith,
        size: 24,
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: VaderColors.redSith,
        foregroundColor: VaderColors.blackVoid,
        elevation: 8,
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: VaderColors.grayDark,
        thickness: 1,
        space: 1,
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: VaderColors.blackCarbon,
        selectedItemColor: VaderColors.redSith,
        unselectedItemColor: VaderColors.grayMedium,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontFamily: 'StarJedi',
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'StarJedi',
          fontSize: 12,
        ),
      ),
      
      // Navigation Drawer Theme
      drawerTheme: const DrawerThemeData(
        backgroundColor: VaderColors.blackCarbon,
      ),
      
      // SnackBar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: VaderColors.blackSteel,
        contentTextStyle: const TextStyle(
          fontFamily: 'StarJedi',
          color: VaderColors.silverChrome,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            color: VaderColors.redSith,
            width: 1,
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      
      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: VaderColors.blackCarbon,
        elevation: 16,
        shadowColor: VaderColors.redSith.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: VaderColors.redDark,
            width: 2,
          ),
        ),
        titleTextStyle: const TextStyle(
          fontFamily: 'StarJedi',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: VaderColors.redSith,
        ),
        contentTextStyle: const TextStyle(
          fontFamily: 'StarJedi',
          fontSize: 16,
          color: VaderColors.silverChrome,
        ),
      ),
      
      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: VaderColors.redSith,
        linearTrackColor: VaderColors.grayDark,
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: VaderColors.blackSteel,
        selectedColor: VaderColors.redDark,
        labelStyle: const TextStyle(
          fontFamily: 'StarJedi',
          color: VaderColors.silverChrome,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            color: VaderColors.grayDark,
            width: 1,
          ),
        ),
      ),
    );
  }
}
