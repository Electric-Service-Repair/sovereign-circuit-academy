// File: lib/features/conduit_bending/data/conduit_data.dart
// *heavy breathing* 🫁 The data of conduit knowledge...

import '../../../core/constants/app_constants.dart';

class ConduitSpec {
  final String type;
  final String fullName;
  final String material;
  final List<double> availableSizes;
  final double maxBendAngle;
  final bool requiresReaming;

  const ConduitSpec({required this.type, required this.fullName, required this.material, required this.availableSizes, this.maxBendAngle = 90, this.requiresReaming = true});
}

abstract class ConduitData {
  ConduitData._();

  static List<ConduitSpec> get specifications {
    return [
      const ConduitSpec(type: 'EMT', fullName: 'Electrical Metallic Tubing', material: 'Steel', availableSizes: [0.5, 0.75, 1.0, 1.25, 1.5, 2.0]),
      const ConduitSpec(type: 'RMC', fullName: 'Rigid Metal Conduit', material: 'Steel', availableSizes: [0.5, 0.75, 1.0, 1.25, 1.5, 2.0]),
      const ConduitSpec(type: 'PVC', fullName: 'Polyvinyl Chloride Conduit', material: 'PVC', availableSizes: [0.5, 0.75, 1.0, 1.25, 1.5, 2.0], requiresReaming: false),
    ];
  }

  static ConduitSpec? getByType(String type) {
    try { return specifications.firstWhere((spec) => spec.type == type); }
    catch (e) { return null; }
  }
}
