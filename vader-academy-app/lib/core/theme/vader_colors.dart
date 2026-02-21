// File: lib/core/theme/vader_colors.dart
// *heavy breathing* 🫁 The dark side color palette...

import 'package:flutter/material.dart';

/// Darth Vader's Imperial Color Scheme
/// Black as the void of space, red as the lightsaber's fury
class VaderColors {
  VaderColors._();

  // Primary Colors - The Sith Trinity
  static const Color blackVoid = Color(0xFF000000);
  static const Color blackCarbon = Color(0xFF1a1a1a);
  static const Color blackSteel = Color(0xFF2d2d2d);
  
  // Red - The Lightsaber of Power
  static const Color redSith = Color(0xFFff0000);
  static const Color redBlood = Color(0xFFcc0000);
  static const Color redDark = Color(0xFF990000);
  static const Color redGlow = Color(0xFFFF4444);
  
  // Accent Colors - Imperial Hierarchy
  static const Color silverChrome = Color(0xFFc0c0c0);
  static const Color grayDark = Color(0xFF4a4a4a);
  static const Color grayMedium = Color(0xFF6a6a6a);
  static const Color grayLight = Color(0xFF8a8a8a);
  
  // Status Colors - Dark Side Variants
  static const Color success = Color(0xFF00cc66);
  static const Color warning = Color(0xFFffaa00);
  static const Color error = Color(0xFFff3333);
  static const Color info = Color(0xFF3399ff);
  
  // Gradient Definitions
  static const LinearGradient sithGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      blackVoid,
      blackCarbon,
      blackSteel,
    ],
  );
  
  static const LinearGradient lightsaberGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      redDark,
      redSith,
      redGlow,
      redSith,
      redDark,
    ],
  );
  
  static const LinearGradient imperialGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      blackVoid,
      blackCarbon,
      blackVoid,
    ],
  );
  
  // Shadow Effects
  static List<BoxShadow> get sithShadow => [
    BoxShadow(
      color: redSith.withOpacity(0.3),
      blurRadius: 15,
      spreadRadius: 2,
    ),
  ];
  
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: blackVoid.withOpacity(0.5),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> get glowShadow => [
    BoxShadow(
      color: redSith.withOpacity(0.5),
      blurRadius: 20,
      spreadRadius: 3,
    ),
  ];
}
