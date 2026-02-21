// File: lib/features/nec_codes/providers/nec_provider.dart
// *heavy breathing* 🫁 The NEC state management...

import 'package:flutter_riverpod/flutter_riverpod.dart';

class NecState {
  final Map<String, double> articleProgress;
  final Map<String, bool> articleCompleted;
  final int quizzesTaken;
  final int quizzesPassed;
  final int currentStreak;
  final bool isLoading;
  final String? error;

  const NecState({
    this.articleProgress = const {},
    this.articleCompleted = const {},
    this.quizzesTaken = 0,
    this.quizzesPassed = 0,
    this.currentStreak = 0,
    this.isLoading = false,
    this.error,
  });

  double get overallProgress => articleProgress.isEmpty ? 0.0 : articleProgress.values.fold<double>(0.0, (sum, p) => sum + p) / articleProgress.length;
  int get completedArticles => articleCompleted.values.where((c) => c).length;

  NecState copyWith({
    Map<String, double>? articleProgress,
    Map<String, bool>? articleCompleted,
    int? quizzesTaken,
    int? quizzesPassed,
    int? currentStreak,
    bool? isLoading,
    String? error,
  }) {
    return NecState(
      articleProgress: articleProgress ?? this.articleProgress,
      articleCompleted: articleCompleted ?? this.articleCompleted,
      quizzesTaken: quizzesTaken ?? this.quizzesTaken,
      quizzesPassed: quizzesPassed ?? this.quizzesPassed,
      currentStreak: currentStreak ?? this.currentStreak,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class NecNotifier extends StateNotifier<NecState> {
  NecNotifier() : super(const NecState());

  Future<void> initialize() async {
    state = state.copyWith(isLoading: true);
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to initialize: ${e.toString()}');
    }
  }

  void updateArticleProgress(String articleId, double progress) {
    final newProgress = Map<String, double>.from(state.articleProgress)..[articleId] = progress.clamp(0.0, 1.0);
    state = state.copyWith(articleProgress: newProgress);
  }

  void completeArticle(String articleId) {
    final newCompleted = Map<String, bool>.from(state.articleCompleted)..[articleId] = true;
    final newProgress = Map<String, double>.from(state.articleProgress)..[articleId] = 1.0;
    state = state.copyWith(articleCompleted: newCompleted, articleProgress: newProgress);
  }

  void recordQuizResult(bool passed) {
    state = state.copyWith(quizzesTaken: state.quizzesTaken + 1, quizzesPassed: passed ? state.quizzesPassed + 1 : state.quizzesPassed);
  }

  void resetProgress() {
    state = const NecState();
  }
}

final necProvider = StateNotifierProvider<NecNotifier, NecState>((ref) => NecNotifier());
