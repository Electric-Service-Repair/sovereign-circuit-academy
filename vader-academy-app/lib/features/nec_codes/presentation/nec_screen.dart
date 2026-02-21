// File: lib/features/nec_codes/presentation/nec_screen.dart
// *heavy breathing* 🫁 The NEC Code training module...

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/vader_colors.dart';
import '../../../core/theme/vader_theme.dart';
import '../../../core/widgets/index.dart';
import '../../../core/constants/app_constants.dart';

class NecCodesScreen extends ConsumerStatefulWidget {
  const NecCodesScreen({super.key});

  @override
  ConsumerState<NecCodesScreen> createState() => _NecCodesScreenState();
}

class _NecCodesScreenState extends ConsumerState<NecCodesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: VaderColors.imperialGradient),
        child: SafeArea(
          child: Column(children: [
            _buildAppBar(),
            _buildTabBar(),
            Expanded(child: TabBarView(controller: _tabController, children: [_buildLearnTab(), _buildQuizTab(), _buildReferenceTab()])),
          ]),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(VaderTheme.spacingM),
      decoration: BoxDecoration(color: VaderColors.blackVoid, border: Border(bottom: BorderSide(color: VaderColors.redDark, width: 1))),
      child: Row(children: [
        VaderIconButton(icon: Icons.arrow_back, onPressed: () => Navigator.pop(context), tooltip: 'Back'),
        const SizedBox(width: VaderTheme.spacingM),
        const Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('NEC CODES', style: TextStyle(fontFamily: 'Orbitron', fontSize: 20, fontWeight: FontWeight.bold, color: VaderColors.redSith, letterSpacing: 2)),
            SizedBox(height: 2),
            Text('National Electrical Code 2026', style: TextStyle(fontFamily: 'Orbitron', fontSize: 12, color: VaderColors.grayMedium)),
          ]),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: VaderTheme.spacingM, vertical: VaderTheme.spacingS),
          decoration: BoxDecoration(color: VaderColors.redDark.withOpacity(0.2), borderRadius: BorderRadius.circular(VaderTheme.borderRadiusSmall), border: Border.all(color: VaderColors.redSith, width: 1)),
          child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.star, color: VaderColors.accentGold, size: 16), SizedBox(width: 4), Text('0%', style: TextStyle(fontFamily: 'Orbitron', fontSize: 14, fontWeight: FontWeight.bold, color: VaderColors.accentGold))]),
        ),
      ]),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(color: VaderColors.blackCarbon, border: Border(bottom: BorderSide(color: VaderColors.redDark, width: 1))),
      child: TabBar(
        controller: _tabController,
        indicatorColor: VaderColors.redSith,
        indicatorWeight: 3,
        labelColor: VaderColors.redSith,
        unselectedLabelColor: VaderColors.grayMedium,
        labelStyle: const TextStyle(fontFamily: 'Orbitron', fontSize: 14, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Orbitron', fontSize: 14),
        tabs: const [Tab(icon: Icon(Icons.school), text: 'LEARN'), Tab(icon: Icon(Icons.quiz), text: 'QUIZ'), Tab(icon: Icon(Icons.menu_book), text: 'REFERENCE')],
      ),
    );
  }

  Widget _buildLearnTab() {
    return ListView(padding: const EdgeInsets.all(VaderTheme.spacingM), children: [
      const VaderInfoCard(title: 'NEC Compliance Required', content: 'The National Electrical Code is the standard for safe electrical installation. Mastery is not optional. It is required.', icon: Icons.info_outline),
      const SizedBox(height: VaderTheme.spacingL),
      Row(children: [const Icon(Icons.folder_open, color: VaderColors.redSith, size: 20), const SizedBox(width: VaderTheme.spacingS), const Text('NEC ARTICLES', style: TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.bold, color: VaderColors.silverChrome))]),
      const SizedBox(height: VaderTheme.spacingM),
      ...AppConstants.necCategories.take(10).map((article) => Padding(padding: const EdgeInsets.only(bottom: VaderTheme.spacingM), child: VaderListCard(title: article, subtitle: 'Tap to begin lesson', icon: Icons.article, onTap: () => _showComingSoon(article)))).toList(),
      VaderCard(child: Center(child: Column(children: [const Icon(Icons.more_horiz, color: VaderColors.grayMedium, size: 32), const SizedBox(height: VaderTheme.spacingS), Text('${AppConstants.necCategories.length - 10} more articles available', style: const TextStyle(fontFamily: 'Orbitron', fontSize: 12, color: VaderColors.grayMedium))]))),
    ]);
  }

  Widget _buildQuizTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(VaderTheme.spacingL),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(padding: const EdgeInsets.all(VaderTheme.spacingL * 2), decoration: BoxDecoration(color: VaderColors.darkGray.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: VaderColors.redSith, width: 2)), child: const Icon(Icons.quiz, size: 64, color: VaderColors.redSith)),
          const SizedBox(height: VaderTheme.spacingL),
          const Text('NEC CODE QUIZ', style: TextStyle(fontFamily: 'Orbitron', fontSize: 24, fontWeight: FontWeight.bold, color: VaderColors.redSith)),
          const SizedBox(height: VaderTheme.spacingM),
          const Text('Test your knowledge of the National Electrical Code. Prove your worth.', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: VaderColors.grayLight, height: 1.5)),
          const SizedBox(height: VaderTheme.spacingXL),
          VaderButton(text: 'Start Quiz', onPressed: () => _showComingSoon('NEC Quiz'), icon: Icons.play_arrow),
          const SizedBox(height: VaderTheme.spacingM),
          VaderTextButton(text: 'Practice Mode', onPressed: () => _showComingSoon('Practice Mode')),
        ]),
      ),
    );
  }

  Widget _buildReferenceTab() {
    return ListView(padding: const EdgeInsets.all(VaderTheme.spacingM), children: [
      VaderCard(padding: EdgeInsets.zero, child: TextField(decoration: InputDecoration(hintText: 'Search NEC articles...', hintStyle: const TextStyle(fontFamily: 'Orbitron', color: VaderColors.grayMedium), prefixIcon: const Icon(Icons.search, color: VaderColors.grayLight), border: InputBorder.none, contentPadding: const EdgeInsets.all(VaderTheme.spacingM)), style: const TextStyle(fontFamily: 'Orbitron', color: VaderColors.silverChrome))),
      const SizedBox(height: VaderTheme.spacingL),
      const Text('QUICK REFERENCE', style: TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.bold, color: VaderColors.silverChrome)),
      const SizedBox(height: VaderTheme.spacingM),
      VaderListCard(title: 'Wire Ampacity Tables', subtitle: 'NEC Table 310.16', icon: Icons.table_chart, onTap: () => _showComingSoon('Wire Ampacity')),
      const SizedBox(height: VaderTheme.spacingS),
      VaderListCard(title: 'Conduit Fill Tables', subtitle: 'NEC Chapter 9, Table 1', icon: Icons.view_list, onTap: () => _showComingSoon('Conduit Fill')),
      const SizedBox(height: VaderTheme.spacingS),
      VaderListCard(title: 'Box Fill Calculations', subtitle: 'NEC 314.16', icon: Icons.calculate, onTap: () => _showComingSoon('Box Fill')),
      const SizedBox(height: VaderTheme.spacingS),
      VaderListCard(title: 'Breaker Sizes', subtitle: 'Standard overcurrent protection', icon: Icons.flash_on, onTap: () => _showComingSoon('Breaker Sizes')),
      const SizedBox(height: VaderTheme.spacingS),
      VaderListCard(title: 'Grounding Requirements', subtitle: 'NEC Article 250', icon: Icons.anchor, onTap: () => _showComingSoon('Grounding')),
      const SizedBox(height: VaderTheme.spacingL),
      const VaderInfoCard(title: 'NEC 2026 Edition', content: 'This app references the 2026 National Electrical Code. Always verify with local amendments and AHJ requirements.', icon: Icons.warning_amber_rounded, isWarning: true),
    ]);
  }

  void _showComingSoon(String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: VaderColors.charcoal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(VaderTheme.borderRadiusLarge), side: const BorderSide(color: VaderColors.redDark, width: 1)),
        title: const Text('COMING SOON', style: TextStyle(fontFamily: 'Orbitron', color: VaderColors.redSith)),
        content: Text('$feature is under construction. The dark side does not rush perfection.', style: const TextStyle(fontFamily: 'Roboto', color: VaderColors.grayLight)),
        actions: [VaderTextButton(text: 'Dismiss', onPressed: () => Navigator.pop(context))],
      ),
    );
  }
}
