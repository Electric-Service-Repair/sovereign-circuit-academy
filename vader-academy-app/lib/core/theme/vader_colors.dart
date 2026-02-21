// File: lib/core/theme/vader_colors.dart
// *heavy breathing* 🫁 The colors of the dark side...

import 'package:flutter/material.dart';

/// Vader Colors - The Sith Palette
/// Black and red dominate. There is no light, only varying degrees of darkness.
abstract class VaderColors {
  VaderColors._();

  // Primary Sith Colors
  static const Color redSith = Color(0xFFD32F2F);
  static const Color redBright = Color(0xFFFF1744);
  static const Color redDark = Color(0xFF8B0000);
  static const Color redBlood = Color(0xFFB71C1C);

  // Void Blacks
  static const Color blackVoid = Color(0xFF000000);
  static const Color blackCarbon = Color(0xFF0A0A0A);
  static const Color blackHelmet = Color(0xFF121212);

  // Dark Grays
  static const Color darkGray = Color(0xFF1A1A1A);
  static const Color charcoal = Color(0xFF2C2C2C);
  static const Color obsidian = Color(0xFF1E1E1E);
  static const Color shadowGray = Color(0xFF242424);

  // Medium Grays
  static const Color grayMedium = Color(0xFF424242);
  static const Color graySteel = Color(0xFF616161);

  // Light Grays
  static const Color grayLight = Color(0xFFBDBDBD);
  static const Color silver = Color(0xFFE0E0E0);
  static const Color silverChrome = Color(0xFFFAFAFA);

  // White
  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteGhost = Color(0xFFF5F5F5);

  // Accent Gold - For imperial highlights
  static const Color accentGold = Color(0xFFFFD700);
  static const Color goldDark = Color(0xFFFF8F00);
  static const Color goldLight = Color(0xFFFFC107);

  // Warning Colors
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color success = Color(0xFF4CAF50);
  static const Color info = Color(0xFF2196F3);

  // Lightsaber Glow - The weapon of the Sith
  static const Color lightsaberCore = Color(0xFFFF5252);
  static const Color lightsaberOuter = Color(0xFFFF8A80);
  static const Color lightsaberGlow = Color(0x40FF1744);

  // Gradients
  static const LinearGradient lightsaberGradient = LinearGradient(
    colors: [redSith, redBright],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient imperialGradient = LinearGradient(
    colors: [blackVoid, charcoal],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [redSith, redBlood],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [blackCarbon, darkGray],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient headerGradient = LinearGradient(
    colors: [blackVoid, obsidian, charcoal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadows - The darkness casts many shadows
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: blackVoid.withOpacity(0.4),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: redDark.withOpacity(0.1),
          blurRadius: 12,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get glowShadow => [
        BoxShadow(
          color: lightsaberGlow,
          blurRadius: 16,
          spreadRadius: 2,
        ),
        BoxShadow(
          color: redSith.withOpacity(0.3),
          blurRadius: 24,
          spreadRadius: 4,
        ),
      ];

  static List<BoxShadow> get buttonShadow => [
        BoxShadow(
          color: redSith.withOpacity(0.4),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get textShadow => [
        BoxShadow(
          color: redSith.withOpacity(0.5),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get iconShadow => [
        BoxShadow(
          color: lightsaberGlow,
          blurRadius: 8,
          spreadRadius: 1,
        ),
      ];

  // Opacity Helpers
  static Color redWithOpacity(double opacity) => redSith.withOpacity(opacity);
  static Color blackWithOpacity(double opacity) => blackVoid.withOpacity(opacity);
  static Color goldWithOpacity(double opacity) => accentGold.withOpacity(opacity);

  // Surface Colors for Theme
  static Color get surface => blackCarbon;
  static Color get surfaceVariant => charcoal;
  static Color get background => blackVoid;
  static Color get errorSurface => error.withOpacity(0.1);
  static Color get warningSurface => warning.withOpacity(0.1);
  static Color get successSurface => success.withOpacity(0.1);
}

/// Vader Color Extensions
extension VaderColorExtensions on Color {
  Color darken([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    final value = 1 - percent / 100;
    return Color.fromARGB(
      alpha,
      (red * value).round(),
      (green * value).round(),
      (blue * value).round(),
    );
  }

  Color lighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    final value = percent / 100;
    return Color.fromARGB(
      alpha,
      (red + ((255 - red) * value)).round(),
      (green + ((255 - green) * value)).round(),
      (blue + ((255 - blue) * value)).round(),
    );
  }

  Color get glow => withOpacity(0.3);
}
