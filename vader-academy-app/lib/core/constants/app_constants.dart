// File: lib/core/constants/app_constants.dart
// *heavy breathing* 🫁 The constants that bind the Empire...

import 'package:flutter/material.dart';

/// App Constants - The laws of the Vader Academy
abstract class AppConstants {
  AppConstants._();

  static const String appName = 'Vader Academy';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Master the Code. Bend the Conduit. Calculate the Load.';

  static const String moduleNecCodes = 'nec_codes';
  static const String moduleConduitBending = 'conduit_bending';
  static const String moduleLoadCalculator = 'load_calculator';
  static const String moduleSafety = 'safety';

  static const String moduleNameNecCodes = 'NEC Codes';
  static const String moduleNameConduitBending = 'Conduit Bending';
  static const String moduleNameLoadCalculator = 'Load Calculator';
  static const String moduleNameSafety = 'Safety Standards';

  static const String moduleDescNecCodes = 'Master the National Electrical Code. Compliance is mandatory.';
  static const String moduleDescConduitBending = 'Learn precise conduit bends. Perfect angles, perfect power.';
  static const String moduleDescLoadCalculator = 'Calculate electrical loads. The Force must have room to breathe.';
  static const String moduleDescSafety = 'Safety first. Always. The dark side tolerates no shortcuts.';

  static const List<String> necCategories = [
    'Article 100 - Definitions',
    'Article 110 - Requirements for Electrical Installations',
    'Article 200 - Use and Identification of Grounded Conductors',
    'Article 210 - Branch Circuits',
    'Article 215 - Feeders',
    'Article 220 - Branch-Circuit, Feeder, and Service Load Calculations',
    'Article 230 - Services',
    'Article 240 - Overcurrent Protection',
    'Article 250 - Grounding and Bonding',
    'Article 300 - Wiring Methods',
    'Article 310 - Conductors for General Wiring',
    'Article 314 - Outlet, Device, Pull, and Junction Boxes',
    'Article 342 - Intermediate Metal Conduit (IMC)',
    'Article 344 - Rigid Metal Conduit (RMC)',
    'Article 352 - PVC Conduit',
    'Article 358 - Electrical Metallic Tubing (EMT)',
  ];

  static const List<String> conduitBendTypes = [
    '90° Stub-Up',
    '90° Back-to-Back',
    'Offset Bend',
    'Saddle Bend (3-point)',
    'Saddle Bend (4-point)',
    'Parallel Bend',
    'Kick Bend',
    'Box Offset',
  ];

  static const List<double> conduitSizes = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0];

  static const List<String> conduitTypes = [
    'EMT (Electrical Metallic Tubing)',
    'RMC (Rigid Metal Conduit)',
    'IMC (Intermediate Metal Conduit)',
    'PVC (Polyvinyl Chloride)',
    'ENT (Electrical Nonmetallic Tubing)',
    'FMC (Flexible Metal Conduit)',
    'LFMC (Liquidtight Flexible Metal Conduit)',
  ];

  static const Map<int, double> bendMultipliers = {10: 6.0, 15: 4.0, 22: 2.6, 30: 2.0, 45: 1.4, 60: 1.2};
  static const Map<double, double> bendDeductions = {0.5: 5.0, 0.75: 6.0, 1.0: 8.0, 1.25: 11.0, 1.5: 12.0, 2.0: 15.0};
  static const Map<double, double> bendRadius = {0.5: 4.0, 0.75: 4.5, 1.0: 5.75, 1.25: 7.25, 1.5: 8.25, 2.0: 9.5, 2.5: 10.75, 3.0: 13.0, 4.0: 16.0};

  static const double standardVoltage = 120.0;
  static const double highVoltage = 240.0;
  static const double threePhaseVoltage = 208.0;
  static const double threePhaseHighVoltage = 480.0;

  static const Map<int, double> wireAmpacity = {14: 20, 12: 25, 10: 35, 8: 50, 6: 65, 4: 85, 3: 100, 2: 115, 1: 130, 0: 150};
  static const List<int> breakerSizes = [15, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100, 110, 125, 150, 175, 200, 225, 250, 300, 350, 400, 500, 600];
  static const Map<int, double> boxFillVolume = {14: 2.0, 12: 2.25, 10: 2.5, 8: 3.0, 6: 5.0};

  static const List<String> vaderQuotes = [
    'I find your lack of precision... disturbing.',
    'The Code is strong with this one.',
    'Join the dark side of perfect bends.',
    'You underestimate the power of the NEC.',
    'I am your father... of electrical code.',
    'The Force must have room to breathe.',
    'Resistance is futile. Compliance is mandatory.',
    'Your sloppy work is pathetic.',
    'Complete the code, or you will have nothing.',
    'The dark side of perfect bends awaits.',
    'Good. Compliance serves you well.',
    'You have done well. For an apprentice.',
    'The NEC does not forgive weakness.',
    'Safety is not optional. It is the way.',
    'Your calculations must be precise.',
  ];

  static const double touchTargetMin = 48.0;
  static const double touchTargetComfortable = 56.0;
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 12.0;
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
}

/// Training Module Data Model
class TrainingModule {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final int totalLessons;
  final int completedLessons;

  const TrainingModule({required this.id, required this.name, required this.description, required this.icon, this.totalLessons = 0, this.completedLessons = 0});

  double get progress => totalLessons > 0 ? completedLessons / totalLessons : 0.0;
  bool get isComplete => completedLessons >= totalLessons;

  TrainingModule copyWith({int? totalLessons, int? completedLessons}) {
    return TrainingModule(id: id, name: name, description: description, icon: icon, totalLessons: totalLessons ?? this.totalLessons, completedLessons: completedLessons ?? this.completedLessons);
  }
}

/// All training modules
abstract class TrainingModules {
  TrainingModules._();

  static const necCodes = TrainingModule(id: AppConstants.moduleNecCodes, name: AppConstants.moduleNameNecCodes, description: AppConstants.moduleDescNecCodes, icon: Icons.code, totalLessons: 25);
  static const conduitBending = TrainingModule(id: AppConstants.moduleConduitBending, name: AppConstants.moduleNameConduitBending, description: AppConstants.moduleDescConduitBending, icon: Icons.architecture, totalLessons: 20);
  static const loadCalculator = TrainingModule(id: AppConstants.moduleLoadCalculator, name: AppConstants.moduleNameLoadCalculator, description: AppConstants.moduleDescLoadCalculator, icon: Icons.calculate, totalLessons: 15);
  static const safety = TrainingModule(id: AppConstants.moduleSafety, name: AppConstants.moduleNameSafety, description: AppConstants.moduleDescSafety, icon: Icons.security, totalLessons: 10);

  static const List<TrainingModule> all = [necCodes, conduitBending, loadCalculator, safety];
}
