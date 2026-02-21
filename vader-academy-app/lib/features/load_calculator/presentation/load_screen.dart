// File: lib/features/load_calculator/presentation/load_screen.dart
// *heavy breathing* 🫁 The Load Calculator training module...

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/vader_colors.dart';
import '../../../core/theme/vader_theme.dart';
import '../../../core/widgets/index.dart';
import '../../../core/constants/app_constants.dart';

class LoadCalculatorScreen extends ConsumerStatefulWidget {
  const LoadCalculatorScreen({super.key});

  @override
  ConsumerState<LoadCalculatorScreen> createState() => _LoadCalculatorScreenState();
}

class _LoadCalculatorScreenState extends ConsumerState<LoadCalculatorScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _squareFootage = 2000;
  int _smallApplianceCircuits = 2;
  int _laundryCircuits = 1;
  double _rangeLoad = 12.0;
  double _dryerLoad = 5.0;
  bool _hasHVAC = true;
  double _hvacLoad = 15.0;

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
    final calculations = _calculateResidentialLoad();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: VaderColors.imperialGradient),
        child: SafeArea(
          child: Column(children: [_buildAppBar(), _buildTabBar(), Expanded(child: TabBarView(controller: _tabController, children: [_buildResidentialTab(calculations), _buildCommercialTab(), _buildReferenceTab()]))]),
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
            Text('LOAD CALCULATOR', style: TextStyle(fontFamily: 'Orbitron', fontSize: 20, fontWeight: FontWeight.bold, color: VaderColors.redSith, letterSpacing: 2)),
            SizedBox(height: 2),
            Text('NEC Article 220 Compliance', style: TextStyle(fontFamily: 'Orbitron', fontSize: 12, color: VaderColors.grayMedium)),
          ]),
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
        tabs: const [Tab(icon: Icon(Icons.home), text: 'RESIDENTIAL'), Tab(icon: Icon(Icons.business), text: 'COMMERCIAL'), Tab(icon: Icon(Icons.menu_book), text: 'REFERENCE')],
      ),
    );
  }

  Widget _buildResidentialTab(LoadCalculations calculations) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(VaderTheme.spacingM),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const VaderInfoCard(title: 'NEC Article 220', content: 'Branch-circuit, feeder, and service load calculations must follow NEC requirements. The Force must have room to breathe.', icon: Icons.info_outline),
        const SizedBox(height: VaderTheme.spacingL),
        const Text('BUILDING SPECIFICATIONS', style: TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.bold, color: VaderColors.silverChrome)),
        const SizedBox(height: VaderTheme.spacingM),
        VaderCard(
          child: Column(children: [
            _buildInputRow(label: 'Square Footage', value: _squareFootage, unit: 'sq ft', min: 500, max: 10000, onChanged: (value) => setState(() => _squareFootage = value)),
            const Divider(color: VaderColors.redDark),
            _buildInputRow(label: 'Small Appliance Circuits', value: _smallApplianceCircuits.toDouble(), unit: 'circuits', min: 0, max: 10, isInteger: true, onChanged: (value) => setState(() => _smallApplianceCircuits = value.toInt())),
            const Divider(color: VaderColors.redDark),
            _buildInputRow(label: 'Laundry Circuits', value: _laundryCircuits.toDouble(), unit: 'circuits', min: 0, max: 5, isInteger: true, onChanged: (value) => setState(() => _laundryCircuits = value.toInt())),
          ]),
        ),
        const SizedBox(height: VaderTheme.spacingL),
        const Text('APPLIANCE LOADS', style: TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.bold, color: VaderColors.silverChrome)),
        const SizedBox(height: VaderTheme.spacingM),
        VaderCard(
          child: Column(children: [
            _buildInputRow(label: 'Range Load', value: _rangeLoad, unit: 'kW', min: 0, max: 50, onChanged: (value) => setState(() => _rangeLoad = value)),
            const Divider(color: VaderColors.redDark),
            _buildInputRow(label: 'Dryer Load', value: _dryerLoad, unit: 'kW', min: 0, max: 20, onChanged: (value) => setState(() => _dryerLoad = value)),
            const Divider(color: VaderColors.redDark),
            SwitchListTile(
              title: const Text('HVAC System', style: TextStyle(fontFamily: 'Orbitron', fontSize: 14, color: VaderColors.silverChrome)),
              value: _hasHVAC,
              onChanged: (value) => setState(() => _hasHVAC = value),
              activeColor: VaderColors.redSith,
            ),
            if (_hasHVAC) ...[const Divider(color: VaderColors.redDark), _buildInputRow(label: 'HVAC Load', value: _hvacLoad, unit: 'kW', min: 0, max: 50, onChanged: (value) => setState(() => _hvacLoad = value))],
          ]),
        ),
        const SizedBox(height: VaderTheme.spacingL),
        const Text('CALCULATION RESULTS', style: TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.bold, color: VaderColors.redSith)),
        const SizedBox(height: VaderTheme.spacingM),
        VaderCard(
          hasGlow: true,
          child: Column(children: [
            _buildResultRow(label: 'General Lighting Load', value: calculations.generalLighting, unit: 'VA'),
            const Divider(color: VaderColors.redDark),
            _buildResultRow(label: 'Small Appliance Load', value: calculations.smallAppliance, unit: 'VA'),
            const Divider(color: VaderColors.redDark),
            _buildResultRow(label: 'Laundry Load', value: calculations.laundry, unit: 'VA'),
            const Divider(color: VaderColors.redDark),
            _buildResultRow(label: 'Range Load (Demand)', value: calculations.rangeDemand, unit: 'VA'),
            const Divider(color: VaderColors.redDark),
            _buildResultRow(label: 'Dryer Load (Demand)', value: calculations.dryerDemand, unit: 'VA'),
            if (_hasHVAC) ...[const Divider(color: VaderColors.redDark), _buildResultRow(label: 'HVAC Load', value: calculations.hvac, unit: 'VA')],
            const Divider(color: VaderColors.redDark),
            Container(
              padding: const EdgeInsets.all(VaderTheme.spacingM),
              decoration: BoxDecoration(color: VaderColors.redDark.withOpacity(0.2), borderRadius: BorderRadius.circular(VaderTheme.borderRadiusMedium)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('TOTAL CALCULATED LOAD', style: TextStyle(fontFamily: 'Orbitron', fontSize: 14, fontWeight: FontWeight.bold, color: VaderColors.redSith)),
                Text('${calculations.totalLoad.toStringAsFixed(0)} VA', style: const TextStyle(fontFamily: 'Orbitron', fontSize: 20, fontWeight: FontWeight.bold, color: VaderColors.redSith)),
              ]),
            ),
            const SizedBox(height: VaderTheme.spacingM),
            VaderStatRow(stats: [
              VaderStatItem(label: 'Service Size', value: calculations.serviceSize, icon: Icons.bolt),
              VaderStatItem(label: 'Main Breaker', value: '${calculations.mainBreaker}A', icon: Icons.flash_on),
            ]),
          ]),
        ),
        const SizedBox(height: VaderTheme.spacingL),
        Row(children: [
          Expanded(child: VaderButton(text: 'Recalculate', onPressed: () => setState(() {}), icon: Icons.refresh)),
          const SizedBox(width: VaderTheme.spacingM),
          Expanded(child: VaderButton(text: 'Save', onPressed: () => _showComingSoon('Save Calculation'), isOutlined: true, icon: Icons.save)),
        ]),
      ]),
    );
  }

  Widget _buildInputRow({required String label, required double value, required String unit, required double min, required double max, required ValueChanged<double> onChanged, bool isInteger = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: VaderTheme.spacingM, vertical: VaderTheme.spacingS),
      child: Row(children: [
        Expanded(child: Text(label, style: const TextStyle(fontFamily: 'Orbitron', fontSize: 14, color: VaderColors.grayLight))),
        VaderIconButton(icon: Icons.remove, onPressed: value > min ? () => onChanged(value - (isInteger ? 1 : 100)) : null, size: 40),
        const SizedBox(width: VaderTheme.spacingS),
        SizedBox(
          width: 100,
          child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.bold, color: VaderColors.redSith),
            decoration: InputDecoration(suffixText: unit, suffixStyle: const TextStyle(fontFamily: 'Orbitron', fontSize: 12, color: VaderColors.grayMedium), border: InputBorder.none, contentPadding: EdgeInsets.zero),
            controller: TextEditingController(text: isInteger ? value.toInt().toString() : value.toString()),
          ),
        ),
        const SizedBox(width: VaderTheme.spacingS),
        VaderIconButton(icon: Icons.add, onPressed: value < max ? () => onChanged(value + (isInteger ? 1 : 100)) : null, size: 40),
      ]),
    );
  }

  Widget _buildResultRow({required String label, required double value, required String unit}) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: VaderTheme.spacingM, vertical: VaderTheme.spacingS), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(fontFamily: 'Orbitron', fontSize: 14, color: VaderColors.grayLight)),
      Text('${value.toStringAsFixed(0)} $unit', style: const TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.bold, color: VaderColors.silverChrome)),
    ]));
  }

  Widget _buildCommercialTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(VaderTheme.spacingL),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(padding: const EdgeInsets.all(VaderTheme.spacingL * 2), decoration: BoxDecoration(color: VaderColors.darkGray.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: VaderColors.redSith, width: 2)), child: const Icon(Icons.business, size: 64, color: VaderColors.redSith)),
          const SizedBox(height: VaderTheme.spacingL),
          const Text('COMMERCIAL LOAD CALC', style: TextStyle(fontFamily: 'Orbitron', fontSize: 24, fontWeight: FontWeight.bold, color: VaderColors.redSith)),
          const SizedBox(height: VaderTheme.spacingM),
          const Text('Commercial load calculations coming soon. NEC Article 220 Part III.', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Roboto', fontSize: 14, color: VaderColors.grayLight, height: 1.5)),
          const SizedBox(height: VaderTheme.spacingXL),
          VaderButton(text: 'Notify When Ready', onPressed: () => _showComingSoon('Commercial Calculator'), icon: Icons.notifications),
        ]),
      ),
    );
  }

  Widget _buildReferenceTab() {
    return ListView(padding: const EdgeInsets.all(VaderTheme.spacingM), children: [
      VaderCard(padding: EdgeInsets.zero, child: TextField(decoration: InputDecoration(hintText: 'Search NEC tables...', hintStyle: const TextStyle(fontFamily: 'Orbitron', color: VaderColors.grayMedium), prefixIcon: const Icon(Icons.search, color: VaderColors.grayLight), border: InputBorder.none, contentPadding: const EdgeInsets.all(VaderTheme.spacingM)), style: const TextStyle(fontFamily: 'Orbitron', color: VaderColors.silverChrome))),
      const SizedBox(height: VaderTheme.spacingL),
      const Text('QUICK REFERENCE TABLES', style: TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.bold, color: VaderColors.silverChrome)),
      const SizedBox(height: VaderTheme.spacingM),
      VaderListCard(title: 'General Lighting Loads', subtitle: 'NEC Table 220.12', icon: Icons.lightbulb, onTap: () => _showComingSoon('Lighting Loads')),
      const SizedBox(height: VaderTheme.spacingS),
      VaderListCard(title: 'Appliance Demand Factors', subtitle: 'NEC 220.53', icon: Icons.kitchen, onTap: () => _showComingSoon('Demand Factors')),
      const SizedBox(height: VaderTheme.spacingS),
      VaderListCard(title: 'Range Demand Table', subtitle: 'NEC Table 220.55', icon: Icons.stove, onTap: () => _showComingSoon('Range Table')),
      const SizedBox(height: VaderTheme.spacingS),
      VaderListCard(title: 'Dryer Demand Table', subtitle: 'NEC Table 220.54', icon: Icons.local_laundry_service, onTap: () => _showComingSoon('Dryer Table')),
      const SizedBox(height: VaderTheme.spacingS),
      VaderListCard(title: 'HVAC Load Factors', subtitle: 'NEC 220.82', icon: Icons.ac_unit, onTap: () => _showComingSoon('HVAC Factors')),
      const SizedBox(height: VaderTheme.spacingS),
      VaderListCard(title: 'Wire Ampacity Tables', subtitle: 'NEC Table 310.16', icon: Icons.cable, onTap: () => _showComingSoon('Ampacity')),
      const SizedBox(height: VaderTheme.spacingL),
      const VaderInfoCard(title: 'NEC 2026 Edition', content: 'All calculations follow NEC 2026 Article 220 requirements. Always verify with local amendments.', icon: Icons.warning_amber_rounded, isWarning: true),
    ]);
  }

  LoadCalculations _calculateResidentialLoad() {
    final generalLighting = _squareFootage * 3;
    final smallAppliance = _smallApplianceCircuits * 1500;
    final laundry = _laundryCircuits * 1500;
    final rangeDemand = _rangeLoad * 1000 * _getRangeDemandFactor(_rangeLoad);
    final dryerDemand = _dryerLoad * 1000;
    final hvac = _hasHVAC ? _hvacLoad * 1000 : 0;
    final totalLoad = generalLighting + smallAppliance + laundry + rangeDemand + dryerDemand + hvac;
    final amps = totalLoad / 240;
    final serviceSize = _getNextStandardService(amps);
    return LoadCalculations(generalLighting: generalLighting, smallAppliance: smallAppliance, laundry: laundry, rangeDemand: rangeDemand, dryerDemand: dryerDemand, hvac: hvac, totalLoad: totalLoad, serviceSize: serviceSize, mainBreaker: serviceSize);
  }

  double _getRangeDemandFactor(double kW) {
    if (kW <= 12) return 0.8;
    if (kW <= 27) return 0.75;
    return 0.7;
  }

  int _getNextStandardService(double amps) {
    final standardSizes = [100, 125, 150, 200, 225, 250, 300, 400, 600];
    for (final size in standardSizes) { if (size >= amps) return size; }
    return 600;
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

class LoadCalculations {
  final double generalLighting, smallAppliance, laundry, rangeDemand, dryerDemand, hvac, totalLoad;
  final int serviceSize, mainBreaker;
  const LoadCalculations({required this.generalLighting, required this.smallAppliance, required this.laundry, required this.rangeDemand, required this.dryerDemand, required this.hvac, required this.totalLoad, required this.serviceSize, required this.mainBreaker});
}
