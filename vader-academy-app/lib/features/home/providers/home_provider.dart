// File: lib/features/home/providers/home_provider.dart
// *heavy breathing* 🫁 The Force of state management...

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';

class HomeState {
  final int completedModules;
  final int totalModules;
  final Set<String> completedModuleIds;
  final String? selectedModule;
  final bool isLoading;
  final String? error;
  final int quizzesTaken;
  final int dayStreak;
  final double necProgress;
  final double conduitProgress;
  final double loadProgress;

  const HomeState({
    this.completedModules = 0,
    this.totalModules = 4,
    this.completedModuleIds = const {},
    this.selectedModule,
    this.isLoading = false,
    this.error,
    this.quizzesTaken = 0,
    this.dayStreak = 0,
    this.necProgress = 0.0,
    this.conduitProgress = 0.0,
    this.loadProgress = 0.0,
  });

  double get progress => totalModules > 0 ? completedModules / totalModules : 0.0;
  double get overallProgress {
    final total = necProgress + conduitProgress + loadProgress;
    return total / 3;
  }

  String get progressMessage {
    if (completedModules == 0) return 'Your journey has not begun. Prove your worth.';
    if (completedModules < totalModules) return 'Progress made. But weakness still remains. Continue.';
    return 'The Code is strong with this one. ✨ You have proven your strength.';
  }

  HomeState copyWith({
    int? completedModules,
    int? totalModules,
    Set<String>? completedModuleIds,
    String? selectedModule,
    bool? isLoading,
    String? error,
    int? quizzesTaken,
    int? dayStreak,
    double? necProgress,
    double? conduitProgress,
    double? loadProgress,
  }) {
    return HomeState(
      completedModules: completedModules ?? this.completedModules,
      totalModules: totalModules ?? this.totalModules,
      completedModuleIds: completedModuleIds ?? this.completedModuleIds,
      selectedModule: selectedModule ?? this.selectedModule,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      quizzesTaken: quizzesTaken ?? this.quizzesTaken,
      dayStreak: dayStreak ?? this.dayStreak,
      necProgress: necProgress ?? this.necProgress,
      conduitProgress: conduitProgress ?? this.conduitProgress,
      loadProgress: loadProgress ?? this.loadProgress,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(const HomeState());

  Future<void> initialize() async {
    state = state.copyWith(isLoading: true);
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final savedProgress = await _loadProgress();
      state = state.copyWith(completedModuleIds: savedProgress, completedModules: savedProgress.length, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to initialize: ${e.toString()}');
    }
  }

  void selectModule(String moduleId) {
    state = state.copyWith(selectedModule: moduleId);
  }

  Future<void> completeModule(String moduleId) async {
    state = state.copyWith(isLoading: true);
    try {
      final isValid = await _validateCompletion(moduleId);
      if (!isValid) throw Exception('You are not yet worthy. Complete all requirements.');
      final newCompleted = Set<String>.from(state.completedModuleIds)..add(moduleId);
      state = state.copyWith(completedModuleIds: newCompleted, completedModules: newCompleted.length, isLoading: false);
      await _saveProgress(newCompleted);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  void updateModuleProgress(String moduleId, double progress) {
    switch (moduleId) {
      case AppConstants.moduleNecCodes:
        state = state.copyWith(necProgress: progress.clamp(0.0, 1.0));
        break;
      case AppConstants.moduleConduitBending:
        state = state.copyWith(conduitProgress: progress.clamp(0.0, 1.0));
        break;
      case AppConstants.moduleLoadCalculator:
        state = state.copyWith(loadProgress: progress.clamp(0.0, 1.0));
        break;
    }
  }

  void incrementQuizzesTaken() {
    state = state.copyWith(quizzesTaken: state.quizzesTaken + 1);
  }

  void updateDayStreak(int streak) {
    state = state.copyWith(dayStreak: streak);
  }

  Future<void> resetProgress() async {
    state = state.copyWith(isLoading: true);
    try {
      await _saveProgress({});
      state = const HomeState();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<bool> _validateCompletion(String moduleId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<Set<String>> _loadProgress() async => {};
  Future<void> _saveProgress(Set<String> completedIds) async => Future.delayed(const Duration(milliseconds: 100));
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) => HomeNotifier());

final vaderQuoteProvider = Provider<String>((ref) {
  final quotes = AppConstants.vaderQuotes;
  return quotes[DateTime.now().millisecondsSinceEpoch % quotes.length];
});
