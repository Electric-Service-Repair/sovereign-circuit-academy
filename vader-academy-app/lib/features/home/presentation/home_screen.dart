// File: lib/features/home/presentation/home_screen.dart
// *heavy breathing* 🫁 The command center of your training...

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/vader_colors.dart';
import '../../../core/theme/vader_theme.dart';
import '../../../core/widgets/index.dart';
import '../../../core/constants/app_constants.dart';
import '../providers/home_provider.dart';
import '../../nec_codes/presentation/nec_screen.dart';
import '../../conduit_bending/presentation/conduit_screen.dart';
import '../../load_calculator/presentation/load_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    final vaderQuote = ref.watch(vaderQuoteProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: VaderColors.imperialGradient),
        child: SafeArea(
          child: CustomScrollView(slivers: [
            SliverToBoxAdapter(child: _buildHeader(vaderQuote)),
            SliverToBoxAdapter(child: _buildWelcomeSection(homeState)),
            SliverToBoxAdapter(child: _buildStatsOverview(homeState)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(VaderTheme.spacingM),
                child: Text('TRAINING MODULES', style: TextStyle(fontFamily: 'Orbitron', fontSize: 18, fontWeight: FontWeight.bold, color: VaderColors.redSith, letterSpacing: 2)),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: VaderTheme.spacingM),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final module = TrainingModules.all[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: VaderTheme.spacingM),
                      child: VaderModuleCard(
                        title: module.name,
                        description: module.description,
                        icon: module.icon,
                        progress: module.id == AppConstants.moduleNecCodes ? homeState.necProgress : module.id == AppConstants.moduleConduitBending ? homeState.conduitProgress : module.id == AppConstants.moduleLoadCalculator ? homeState.loadProgress : 0.0,
                        onTap: () => _navigateToModule(module.id),
                      ),
                    );
                  },
                  childCount: TrainingModules.all.length,
                ),
              ),
            ),
            SliverToBoxAdapter(child: _buildDailyChallenge()),
            SliverToBoxAdapter(child: _buildRecentActivity()),
            const SliverToBoxAdapter(child: SizedBox(height: VaderTheme.spacingXXL)),
          ]),
        ),
      ),
    );
  }

  Widget _buildHeader(String quote) {
    return Container(
      padding: const EdgeInsets.all(VaderTheme.spacingM),
      decoration: BoxDecoration(gradient: VaderColors.headerGradient, border: Border(bottom: BorderSide(color: VaderColors.redDark.withOpacity(0.3), width: 1))),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(AppConstants.appName.toUpperCase(), style: TextStyle(fontFamily: 'Orbitron', fontSize: 24, fontWeight: FontWeight.bold, color: VaderColors.redSith, letterSpacing: 2)),
              const SizedBox(height: 4),
              const Text('Electrical Training Empire', style: TextStyle(fontFamily: 'Orbitron', fontSize: 12, color: VaderColors.grayMedium, letterSpacing: 1)),
            ]),
            VaderIconButton(icon: Icons.notifications_outlined, onPressed: () {}, tooltip: 'Notifications'),
          ],
        ),
        const SizedBox(height: VaderTheme.spacingM),
        Container(
          padding: const EdgeInsets.all(VaderTheme.spacingM),
          decoration: BoxDecoration(color: VaderColors.darkGray.withOpacity(0.5), borderRadius: BorderRadius.circular(VaderTheme.borderRadiusMedium), border: Border.all(color: VaderColors.redDark.withOpacity(0.3), width: 1)),
          child: Row(children: [
            const Icon(Icons.format_quote, color: VaderColors.redSith, size: 24),
            const SizedBox(width: VaderTheme.spacingM),
            Expanded(child: Text(quote, style: const TextStyle(fontFamily: 'Orbitron', fontSize: 12, color: VaderColors.grayLight, fontStyle: FontStyle.italic))),
          ]),
        ),
      ]),
    );
  }

  Widget _buildWelcomeSection(HomeState state) {
    final progressPercent = (state.overallProgress * 100).toInt();
    return Container(
      margin: const EdgeInsets.all(VaderTheme.spacingM),
      padding: const EdgeInsets.all(VaderTheme.spacingL),
      decoration: BoxDecoration(gradient: VaderColors.cardGradient, borderRadius: BorderRadius.circular(VaderTheme.borderRadiusLarge), border: Border.all(color: VaderColors.redDark, width: 1), boxShadow: VaderColors.cardShadow),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.school, color: VaderColors.redSith, size: 28),
          const SizedBox(width: VaderTheme.spacingM),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Welcome, Apprentice', style: TextStyle(fontFamily: 'Orbitron', fontSize: 20, fontWeight: FontWeight.bold, color: VaderColors.silverChrome)),
              const SizedBox(height: 4),
              Text(state.progressMessage, style: const TextStyle(fontFamily: 'Orbitron', fontSize: 12, color: VaderColors.grayLight)),
            ]),
          ),
        ]),
        const SizedBox(height: VaderTheme.spacingL),
        Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('OVERALL PROGRESS', style: TextStyle(fontFamily: 'Orbitron', fontSize: 10, color: VaderColors.grayMedium, letterSpacing: 1)),
              const SizedBox(height: 8),
              ClipRRect(borderRadius: BorderRadius.circular(VaderTheme.borderRadiusSmall), child: LinearProgressIndicator(value: state.overallProgress, backgroundColor: VaderColors.darkGray, valueColor: const AlwaysStoppedAnimation<Color>(VaderColors.redSith), minHeight: 8)),
            ]),
          ),
          const SizedBox(width: VaderTheme.spacingM),
          Text('$progressPercent%', style: const TextStyle(fontFamily: 'Orbitron', fontSize: 24, fontWeight: FontWeight.bold, color: VaderColors.redSith)),
        ]),
      ]),
    );
  }

  Widget _buildStatsOverview(HomeState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: VaderTheme.spacingM),
      child: VaderStatRow(stats: [
        VaderStatItem(label: 'Modules', value: '${state.completedModules}/${state.totalModules}', icon: Icons.folder),
        VaderStatItem(label: 'Quizzes', value: '${state.quizzesTaken}', icon: Icons.quiz),
        VaderStatItem(label: 'Streak', value: '${state.dayStreak}', icon: Icons.local_fire_department, color: VaderColors.accentGold),
      ]),
    );
  }

  Widget _buildDailyChallenge() {
    return Container(
      margin: const EdgeInsets.all(VaderTheme.spacingM),
      padding: const EdgeInsets.all(VaderTheme.spacingL),
      decoration: BoxDecoration(gradient: LinearGradient(colors: [VaderColors.redDark.withOpacity(0.3), VaderColors.blackCarbon]), borderRadius: BorderRadius.circular(VaderTheme.borderRadiusLarge), border: Border.all(color: VaderColors.redSith, width: 1)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: VaderColors.accentGold.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.emoji_events, color: VaderColors.accentGold, size: 24)),
          const SizedBox(width: VaderTheme.spacingM),
          const Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('DAILY CHALLENGE', style: TextStyle(fontFamily: 'Orbitron', fontSize: 14, fontWeight: FontWeight.bold, color: VaderColors.accentGold, letterSpacing: 1)),
              SizedBox(height: 4),
              Text('NEC Article 210 - Branch Circuits', style: TextStyle(fontFamily: 'Orbitron', fontSize: 12, color: VaderColors.grayLight)),
            ]),
          ),
        ]),
        const SizedBox(height: VaderTheme.spacingM),
        VaderButton(text: 'Start Challenge', onPressed: () {}, icon: Icons.play_arrow),
      ]),
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      margin: const EdgeInsets.all(VaderTheme.spacingM),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('RECENT ACTIVITY', style: TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.bold, color: VaderColors.silverChrome, letterSpacing: 1)),
        const SizedBox(height: VaderTheme.spacingM),
        VaderListCard(title: 'NEC Article 100 Quiz', subtitle: 'Completed with 85% accuracy', icon: Icons.check_circle, isComplete: true, trailing: const Text('2h ago', style: TextStyle(fontFamily: 'Orbitron', fontSize: 11, color: VaderColors.grayMedium))),
        const SizedBox(height: VaderTheme.spacingS),
        VaderListCard(title: '90° Stub-Up Bend', subtitle: 'Practice session completed', icon: Icons.architecture, isComplete: true, trailing: const Text('5h ago', style: TextStyle(fontFamily: 'Orbitron', fontSize: 11, color: VaderColors.grayMedium))),
        const SizedBox(height: VaderTheme.spacingS),
        VaderListCard(title: 'Load Calculation Basics', subtitle: 'Lesson 3 of 15', icon: Icons.play_circle_outline, trailing: const Text('1d ago', style: TextStyle(fontFamily: 'Orbitron', fontSize: 11, color: VaderColors.grayMedium))),
      ]),
    );
  }

  void _navigateToModule(String moduleId) {
    switch (moduleId) {
      case AppConstants.moduleNecCodes:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const NecCodesScreen()));
        break;
      case AppConstants.moduleConduitBending:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ConduitBendingScreen()));
        break;
      case AppConstants.moduleLoadCalculator:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadCalculatorScreen()));
        break;
      default:
        _showComingSoon();
    }
  }

  void _showComingSoon() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: VaderColors.charcoal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(VaderTheme.borderRadiusLarge), side: const BorderSide(color: VaderColors.redDark, width: 1)),
        title: const Text('COMING SOON', style: TextStyle(fontFamily: 'Orbitron', color: VaderColors.redSith)),
        content: const Text('This module is under construction. The dark side does not rush perfection.', style: TextStyle(fontFamily: 'Roboto', color: VaderColors.grayLight)),
        actions: [VaderTextButton(text: 'Dismiss', onPressed: () => Navigator.pop(context))],
      ),
    );
  }
}
