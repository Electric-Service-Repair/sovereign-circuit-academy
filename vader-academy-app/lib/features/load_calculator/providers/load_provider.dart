// File: lib/features/load_calculator/providers/load_provider.dart
// *heavy breathing* 🫁 The Force of load calculations...

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';

enum LoadType { residential, commercial, industrial }

class LoadResult {
  final DateTime timestamp;
  final LoadType loadType;
  final double totalLoad;
  final int serviceSize;
  final int mainBreaker;
  final Map<String, double> breakdown;

  const LoadResult({required this.timestamp, required this.loadType, required this.totalLoad, required this.serviceSize, required this.mainBreaker, required this.breakdown});
}

class LoadState {
  final LoadType selectedLoadType;
  final Map<String, double> inputs;
  final LoadResult? lastResult;
  final List<LoadResult> calculationHistory;
  final bool isLoading;
  final String? error;

  const LoadState({
    this.selectedLoadType = LoadType.residential,
    this.inputs = const {},
    this.lastResult,
    this.calculationHistory = const [],
    this.isLoading = false,
    this.error,
  });

  LoadState copyWith({
    LoadType? selectedLoadType,
    Map<String, double>? inputs,
    LoadResult? lastResult,
    List<LoadResult>? calculationHistory,
    bool? isLoading,
    String? error,
  }) {
    return LoadState(
      selectedLoadType: selectedLoadType ?? this.selectedLoadType,
      inputs: inputs ?? this.inputs,
      lastResult: lastResult ?? this.lastResult,
      calculationHistory: calculationHistory ?? this.calculationHistory,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class LoadNotifier extends StateNotifier<LoadState> {
  LoadNotifier() : super(const LoadState());

  void selectLoadType(LoadType type) { state = state.copyWith(selectedLoadType: type); }
  void updateInput(String key, double value) {
    final newInputs = Map<String, double>.from(state.inputs)..[key] = value;
    state = state.copyWith(inputs: newInputs);
  }

  LoadResult calculateResidential() {
    final sqFt = state.inputs['squareFootage'] ?? 2000;
    final smallAppliance = state.inputs['smallApplianceCircuits'] ?? 2;
    final laundry = state.inputs['laundryCircuits'] ?? 1;
    final range = state.inputs['rangeLoad'] ?? 12;
    final dryer = state.inputs['dryerLoad'] ?? 5;
    final hvac = state.inputs['hvacLoad'] ?? 0;

    final generalLighting = sqFt * 3;
    final smallApplianceLoad = smallAppliance * 1500;
    final laundryLoad = laundry * 1500;
    final lightingDemand = generalLighting <= 3000 ? generalLighting : 3000 + (generalLighting - 3000) * 0.35;
    final rangeDemand = range * 1000 * (range <= 12 ? 0.8 : range <= 27 ? 0.75 : 0.7);
    final dryerDemand = dryer * 1000;
    final hvacLoad = hvac * 1000;
    final total = lightingDemand + smallApplianceLoad + laundryLoad + rangeDemand + dryerDemand + hvacLoad;
    final amps = total / 240;
    final serviceSize = _getNextStandardService(amps);

    final result = LoadResult(
      timestamp: DateTime.now(),
      loadType: LoadType.residential,
      totalLoad: total,
      serviceSize: serviceSize,
      mainBreaker: serviceSize,
      breakdown: {'generalLighting': generalLighting, 'smallAppliance': smallApplianceLoad, 'laundry': laundryLoad, 'range': rangeDemand, 'dryer': dryerDemand, 'hvac': hvacLoad},
    );

    state = state.copyWith(lastResult: result, calculationHistory: [result, ...state.calculationHistory].take(10).toList());
    return result;
  }

  int _getNextStandardService(double amps) {
    for (final size in AppConstants.breakerSizes) { if (size >= amps) return size; }
    return AppConstants.breakerSizes.last;
  }

  void clearHistory() { state = state.copyWith(calculationHistory: []); }
  void reset() { state = const LoadState(); }
}

final loadProvider = StateNotifierProvider<LoadNotifier, LoadState>((ref) => LoadNotifier());
