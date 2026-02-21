// File: lib/core/theme/vader_theme.dart
// *heavy breathing* 🫁 The theme of the Empire...

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'vader_colors.dart';

/// Vader Theme - Dark mode is not optional. It is mandatory.
abstract class VaderTheme {
  VaderTheme._();

  static const String fontPrimary = 'Orbitron';
  static const String fontSecondary = 'StarJedi';
  static const String fontBody = 'Roboto';

  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 12.0;
  static const double borderRadiusXLarge = 16.0;

  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  static const double touchTargetMin = 48.0;
  static const double touchTargetComfortable = 56.0;

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: VaderColors.redSith,
      scaffoldBackgroundColor: VaderColors.blackVoid,
      canvasColor: VaderColors.blackCarbon,
      cardColor: VaderColors.charcoal,
      dividerColor: VaderColors.redDark.withOpacity(0.3),
      indicatorColor: VaderColors.redSith,
      colorScheme: const ColorScheme.dark(
        primary: VaderColors.redSith,
        onPrimary: VaderColors.blackVoid,
        primaryContainer: VaderColors.redDark,
        onPrimaryContainer: VaderColors.silver,
        secondary: VaderColors.accentGold,
        onSecondary: VaderColors.blackVoid,
        secondaryContainer: VaderColors.goldDark,
        onSecondaryContainer: VaderColors.blackCarbon,
        tertiary: VaderColors.graySteel,
        onTertiary: VaderColors.white,
        tertiaryContainer: VaderColors.charcoal,
        onTertiaryContainer: VaderColors.silver,
        error: VaderColors.error,
        onError: VaderColors.white,
        errorContainer: VaderColors.errorSurface,
        onErrorContainer: VaderColors.error,
        surface: VaderColors.blackCarbon,
        onSurface: VaderColors.silverChrome,
        surfaceContainerHighest: VaderColors.charcoal,
        onSurfaceVariant: VaderColors.grayLight,
        outline: VaderColors.redDark,
        shadow: VaderColors.blackVoid,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: VaderColors.blackVoid,
        foregroundColor: VaderColors.redSith,
        titleTextStyle: TextStyle(
          fontFamily: fontPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: VaderColors.redSith,
          letterSpacing: 2,
        ),
        iconTheme: IconThemeData(color: VaderColors.redSith, size: 24),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: VaderColors.blackVoid,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: VaderColors.blackCarbon,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      textTheme: _buildTextTheme(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          backgroundColor: VaderColors.redSith,
          foregroundColor: VaderColors.blackVoid,
          minimumSize: const Size(double.infinity, VaderTheme.touchTargetComfortable),
          padding: const EdgeInsets.symmetric(horizontal: VaderTheme.spacingL, vertical: VaderTheme.spacingM),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(VaderTheme.borderRadiusMedium)),
          textStyle: const TextStyle(fontFamily: fontPrimary, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, VaderColors.touchTargetComfortable),
          side: const BorderSide(color: VaderColors.redSith, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: VaderTheme.spacingL, vertical: VaderTheme.spacingM),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(VaderTheme.borderRadiusMedium)),
          textStyle: const TextStyle(fontFamily: fontPrimary, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(VaderColors.touchTargetMin, VaderColors.touchTargetMin),
          padding: const EdgeInsets.symmetric(horizontal: VaderTheme.spacingM, vertical: VaderTheme.spacingS),
          textStyle: const TextStyle(fontFamily: fontPrimary, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 1),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(VaderColors.touchTargetMin, VaderColors.touchTargetMin),
          padding: const EdgeInsets.all(VaderTheme.spacingM),
          iconSize: 24,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: VaderColors.redSith,
        foregroundColor: VaderColors.blackVoid,
        elevation: 6,
        highlightElevation: 8,
      ),
      cardTheme: CardTheme(
        elevation: 4,
        color: VaderColors.charcoal,
        surfaceTintColor: VaderColors.redDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(VaderTheme.borderRadiusLarge),
          side: const BorderSide(color: VaderColors.redDark, width: 1),
        ),
        margin: const EdgeInsets.all(VaderTheme.spacingM),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: VaderColors.darkGray,
        contentPadding: const EdgeInsets.symmetric(horizontal: VaderTheme.spacingM, vertical: VaderTheme.spacingM),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(VaderTheme.borderRadiusMedium),
          borderSide: const BorderSide(color: VaderColors.redDark, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(VaderTheme.borderRadiusMedium),
          borderSide: const BorderSide(color: VaderColors.grayMedium, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(VaderTheme.borderRadiusMedium),
          borderSide: const BorderSide(color: VaderColors.redSith, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(VaderTheme.borderRadiusMedium),
          borderSide: const BorderSide(color: VaderColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(VaderTheme.borderRadiusMedium),
          borderSide: const BorderSide(color: VaderColors.error, width: 2),
        ),
        labelStyle: const TextStyle(fontFamily: fontPrimary, fontSize: 14, color: VaderColors.grayLight),
        hintStyle: const TextStyle(fontFamily: fontPrimary, fontSize: 14, color: VaderColors.grayMedium),
        errorStyle: const TextStyle(fontFamily: fontPrimary, fontSize: 12, color: VaderColors.error),
        prefixIconColor: VaderColors.grayLight,
        suffixIconColor: VaderColors.grayLight,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: VaderColors.darkGray,
        deleteIconColor: VaderColors.redSith,
        disabledColor: VaderColors.charcoal,
        labelStyle: const TextStyle(fontFamily: fontPrimary, fontSize: 14, color: VaderColors.silverChrome),
        padding: const EdgeInsets.symmetric(horizontal: VaderTheme.spacingM, vertical: VaderTheme.spacingS),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(VaderTheme.borderRadiusSmall),
          side: const BorderSide(color: VaderColors.redDark, width: 1),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: VaderColors.blackCarbon,
        selectedItemColor: VaderColors.redSith,
        unselectedItemColor: VaderColors.grayMedium,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: VaderColors.blackCarbon,
        indicatorColor: VaderColors.redSith.withOpacity(0.2),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(fontFamily: fontPrimary, fontSize: 12, fontWeight: FontWeight.bold, color: VaderColors.redSith);
          }
          return const TextStyle(fontFamily: fontPrimary, fontSize: 12, color: VaderColors.grayMedium);
        }),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: VaderColors.charcoal,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(VaderTheme.borderRadiusLarge),
          side: const BorderSide(color: VaderColors.redDark, width: 1),
        ),
        titleTextStyle: const TextStyle(fontFamily: fontPrimary, fontSize: 20, fontWeight: FontWeight.bold, color: VaderColors.redSith),
        contentTextStyle: const TextStyle(fontFamily: fontBody, fontSize: 16, color: VaderColors.silverChrome),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: VaderColors.charcoal,
        contentTextStyle: const TextStyle(fontFamily: fontBody, fontSize: 14, color: VaderColors.silverChrome),
        actionTextColor: VaderColors.redSith,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(VaderTheme.borderRadiusMedium)),
        behavior: SnackBarBehavior.floating,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: VaderColors.redSith, linearTrackColor: VaderColors.darkGray),
      sliderTheme: SliderThemeData(
        activeTrackColor: VaderColors.redSith,
        inactiveTrackColor: VaderColors.darkGray,
        thumbColor: VaderColors.redSith,
        overlayColor: VaderColors.redSith.withOpacity(0.2),
        tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 4),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? VaderColors.redSith : VaderColors.grayMedium),
        trackColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? VaderColors.redDark : VaderColors.darkGray),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? VaderColors.redSith : Colors.transparent),
        checkColor: WidgetStateProperty.all(VaderColors.blackVoid),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(VaderTheme.borderRadiusSmall)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? VaderColors.redSith : VaderColors.grayMedium),
      ),
      dividerTheme: const DividerThemeData(color: VaderColors.redDark, thickness: 1, space: VaderTheme.spacingM),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: VaderColors.blackCarbon,
          borderRadius: BorderRadius.circular(VaderTheme.borderRadiusSmall),
          border: Border.all(color: VaderColors.redDark, width: 1),
        ),
        textStyle: const TextStyle(fontFamily: fontPrimary, fontSize: 12, color: VaderColors.silverChrome),
        padding: const EdgeInsets.symmetric(horizontal: VaderTheme.spacingM, vertical: VaderTheme.spacingS),
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: VaderTheme.spacingM, vertical: VaderTheme.spacingS),
        titleTextStyle: TextStyle(fontFamily: fontPrimary, fontSize: 16, fontWeight: FontWeight.w600, color: VaderColors.silverChrome),
        subtitleTextStyle: TextStyle(fontFamily: fontBody, fontSize: 14, color: VaderColors.grayLight),
      ),
      expansionTileTheme: const ExpansionTileThemeData(
        backgroundColor: VaderColors.darkGray,
        collapsedBackgroundColor: Colors.transparent,
        textColor: VaderColors.silverChrome,
        collapsedTextColor: VaderColors.grayLight,
        iconColor: VaderColors.redSith,
        collapsedIconColor: VaderColors.grayMedium,
      ),
    );
  }

  static TextTheme _buildTextTheme() {
    return const TextTheme(
      displayLarge: TextStyle(fontFamily: fontPrimary, fontSize: 57, fontWeight: FontWeight.bold, color: VaderColors.redSith, letterSpacing: 2, height: 1.1),
      displayMedium: TextStyle(fontFamily: fontPrimary, fontSize: 45, fontWeight: FontWeight.bold, color: VaderColors.redSith, letterSpacing: 2, height: 1.15),
      displaySmall: TextStyle(fontFamily: fontPrimary, fontSize: 36, fontWeight: FontWeight.bold, color: VaderColors.redSith, letterSpacing: 1.5, height: 1.2),
      headlineLarge: TextStyle(fontFamily: fontPrimary, fontSize: 32, fontWeight: FontWeight.bold, color: VaderColors.silverChrome, letterSpacing: 1.5),
      headlineMedium: TextStyle(fontFamily: fontPrimary, fontSize: 28, fontWeight: FontWeight.w600, color: VaderColors.silverChrome, letterSpacing: 1),
      headlineSmall: TextStyle(fontFamily: fontPrimary, fontSize: 24, fontWeight: FontWeight.w600, color: VaderColors.silverChrome, letterSpacing: 1),
      titleLarge: TextStyle(fontFamily: fontPrimary, fontSize: 22, fontWeight: FontWeight.bold, color: VaderColors.redSith, letterSpacing: 1),
      titleMedium: TextStyle(fontFamily: fontPrimary, fontSize: 16, fontWeight: FontWeight.w600, color: VaderColors.silverChrome, letterSpacing: 0.5),
      titleSmall: TextStyle(fontFamily: fontPrimary, fontSize: 14, fontWeight: FontWeight.w600, color: VaderColors.grayLight, letterSpacing: 0.5),
      bodyLarge: TextStyle(fontFamily: fontBody, fontSize: 16, color: VaderColors.silverChrome, height: 1.5),
      bodyMedium: TextStyle(fontFamily: fontBody, fontSize: 14, color: VaderColors.grayLight, height: 1.5),
      bodySmall: TextStyle(fontFamily: fontBody, fontSize: 12, color: VaderColors.grayMedium, height: 1.4),
      labelLarge: TextStyle(fontFamily: fontPrimary, fontSize: 14, fontWeight: FontWeight.w600, color: VaderColors.silverChrome, letterSpacing: 1),
      labelMedium: TextStyle(fontFamily: fontPrimary, fontSize: 12, fontWeight: FontWeight.w600, color: VaderColors.grayLight, letterSpacing: 0.5),
      labelSmall: TextStyle(fontFamily: fontPrimary, fontSize: 11, fontWeight: FontWeight.w600, color: VaderColors.grayMedium, letterSpacing: 0.5),
    );
  }

  static BoxDecoration gradientBox({
    LinearGradient gradient = VaderColors.imperialGradient,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(borderRadiusLarge)),
    Border? border,
  }) {
    return BoxDecoration(
      gradient: gradient,
      borderRadius: borderRadius,
      border: border ?? Border.all(color: VaderColors.redDark.withOpacity(0.3), width: 1),
    );
  }

  static BoxDecoration glowBox({Color glowColor = VaderColors.lightsaberGlow, double blurRadius = 16, double spreadRadius = 2}) {
    return BoxDecoration(boxShadow: [BoxShadow(color: glowColor, blurRadius: blurRadius, spreadRadius: spreadRadius)]);
  }
}
