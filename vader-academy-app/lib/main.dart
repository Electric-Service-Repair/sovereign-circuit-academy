// File: lib/main.dart
// *heavy breathing* 🫁 The entry point of the Empire...

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/vader_theme.dart';
import 'core/theme/vader_colors.dart';
import 'features/home/presentation/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: VaderColors.blackCarbon,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const ProviderScope(child: VaderAcademyApp()));
}

class VaderAcademyApp extends StatelessWidget {
  const VaderAcademyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vader Academy',
      debugShowCheckedModeBanner: false,
      theme: VaderTheme.darkTheme,
      darkTheme: VaderTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}
