// File: lib/features/load_calculator/data/load_data.dart
// *heavy breathing* 🫁 The data of electrical loads...

import '../../../core/constants/app_constants.dart';

abstract class LoadData {
  LoadData._();

  static const Map<String, double> residentialDemandFactors = {
    'general_lighting_first_3000': 1.0,
    'general_lighting_remainder': 0.35,
    'small_appliance': 1.0,
    'laundry': 1.0,
    'range_up_to_12kw': 0.8,
    'dryer': 0.75,
    'hvac': 1.0,
  };

  static const List<int> standardServices = [100, 125, 150, 200, 225, 250, 300, 400, 500, 600, 800, 1000];
  static const List<int> standardBreakers = AppConstants.breakerSizes;
  static const Map<String, double> standardVoltages = {'residential_single': 120, 'residential_split': 240, 'commercial_three_phase': 208, 'industrial_three_phase': 480};
}

class ApplianceLoad {
  final String name;
  final double typicalLoad;
  final String unit;
  final String necReference;

  const ApplianceLoad({required this.name, required this.typicalLoad, required this.unit, required this.necReference});
}

abstract class ApplianceLoads {
  ApplianceLoads._();

  static const range = ApplianceLoad(name: 'Electric Range', typicalLoad: 12.0, unit: 'kW', necReference: 'NEC Table 220.55');
  static const dryer = ApplianceLoad(name: 'Electric Dryer', typicalLoad: 5.0, unit: 'kW', necReference: 'NEC 220.54');
  static const waterHeater = ApplianceLoad(name: 'Water Heater', typicalLoad: 4.5, unit: 'kW', necReference: 'NEC 422.11');
  static const hvac = ApplianceLoad(name: 'HVAC System', typicalLoad: 15.0, unit: 'kW', necReference: 'NEC 220.82');

  static const List<ApplianceLoad> all = [range, dryer, waterHeater, hvac];
}
