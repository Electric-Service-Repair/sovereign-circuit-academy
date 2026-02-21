// File: lib/features/conduit_bending/providers/conduit_provider.dart
// *heavy breathing* 🫁 The Force of conduit mastery...

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';

class ConduitState {
  final String selectedConduitType;
  final double selectedConduitSize;
  final String selectedBendType;
  final Map<String, double> bendProgress;
  final int practiceSessions;
  final int perfectBends;
  final bool isLoading;
  final String? error;

  const ConduitState({
    this.selectedConduitType = 'EMT',
    this.selectedConduitSize = 0.5,
    this.selectedBendType = '90° Stub-Up',
    this.bendProgress = const {},
    this.practiceSessions = 0,
    this.perfectBends = 0,
    this.isLoading = false,
    this.error,
  });

  double get overallProgress => bendProgress.isEmpty ? 0.0 : bendProgress.values.fold<double>(0.0, (sum, p) => sum + p) / bendProgress.length;
  double get accuracy => practiceSessions > 0 ? perfectBends / practiceSessions : 0.0;

  ConduitState copyWith({
    String? selectedConduitType,
    double? selectedConduitSize,
    String? selectedBendType,
    Map<String, double>? bendProgress,
    int? practiceSessions,
    int? perfectBends,
    bool? isLoading,
    String? error,
  }) {
    return ConduitState(
      selectedConduitType: selectedConduitType ?? this.selectedConduitType,
      selectedConduitSize: selectedConduitSize ?? this.selectedConduitSize,
      selectedBendType: selectedBendType ?? this.selectedBendType,
      bendProgress: bendProgress ?? this.bendProgress,
      practiceSessions: practiceSessions ?? this.practiceSessions,
      perfectBends: perfectBends ?? this.perfectBends,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ConduitNotifier extends StateNotifier<ConduitState> {
  ConduitNotifier() : super(const ConduitState());

  void selectConduitType(String type) { state = state.copyWith(selectedConduitType: type); }
  void selectConduitSize(double size) { state = state.copyWith(selectedConduitSize: size); }
  void selectBendType(String type) { state = state.copyWith(selectedBendType: type); }

  void updateBendProgress(String bendType, double progress) {
    final newProgress = Map<String, double>.from(state.bendProgress)..[bendType] = progress.clamp(0.0, 1.0);
    state = state.copyWith(bendProgress: newProgress);
  }

  void recordPracticeSession(bool isPerfect) {
    state = state.copyWith(practiceSessions: state.practiceSessions + 1, perfectBends: isPerfect ? state.perfectBends + 1 : state.perfectBends);
  }

  double getBendDeduction() => AppConstants.bendDeductions[state.selectedConduitSize] ?? 6.0;
  double getBendRadius() => AppConstants.bendRadius[state.selectedConduitSize] ?? 4.0;

  void resetProgress() { state = const ConduitState(); }
}

final conduitProvider = StateNotifierProvider<ConduitNotifier, ConduitState>((ref) => ConduitNotifier());
