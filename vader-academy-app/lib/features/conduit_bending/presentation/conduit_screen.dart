// File: lib/features/conduit_bending/presentation/conduit_screen.dart
// *heavy breathing* 🫁 The Conduit Bending training module...

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/vader_colors.dart';
import '../../../core/theme/vader_theme.dart';
import '../../../core/widgets/index.dart';
import '../../../core/constants/app_constants.dart';

class ConduitBendingScreen extends ConsumerStatefulWidget {
  const ConduitBendingScreen({super.key});

  @override
  ConsumerState<ConduitBendingScreen> createState() => _ConduitBendingScreenState();
}

class _ConduitBendingScreenState extends ConsumerState<ConduitBendingScreen> {
  String _selectedConduitType = 'EMT';
  double _selectedConduitSize = 0.5;
  String _selectedBendType = '90° Stub-Up';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: VaderColors.imperialGradient),
        child: SafeArea(
          child: CustomScrollView(slivers: [
            SliverToBoxAdapter(child: _buildAppBar()),
            SliverToBoxAdapter(child: _buildInfoBanner()),
            SliverToBoxAdapter(child: _buildBendTypeSelector()),
            SliverToBoxAdapter(child: _buildConduitSelector()),
            SliverToBoxAdapter(child: _buildCalculator()),
            SliverToBoxAdapter(child: _buildBendGuides()),
            const SliverToBoxAdapter(child: SizedBox(height: VaderTheme.spacingXXL)),
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
            Text('CONDUIT BENDING', style: TextStyle(fontFamily: 'Orbitron', fontSize: 20, fontWeight: FontWeight.bold, color: VaderColors.redSith, letterSpacing: 2)),
            SizedBox(height: 2),
            Text('Perfect Bends. Perfect Power.', style: TextStyle(fontFamily: 'Orbitron', fontSize: 12, color: VaderColors.grayMedium)),
          ]),
        ),
      ]),
    );
  }

  Widget _buildInfoBanner() {
    return Padding(padding: const EdgeInsets.all(VaderTheme.spacingM), child: const VaderInfoCard(title: 'Precision Required', content: 'Conduit bending requires exact measurements. A single degree of error can compromise the entire installation. Measure twice, bend once.', icon: Icons.architecture));
  }

  Widget _buildBendTypeSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: VaderTheme.spacingM),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('BEND TYPE', style: TextStyle(fontFamily: 'Orbitron', fontSize: 14, fontWeight: FontWeight.bold, color: VaderColors.redSith, letterSpacing: 1)),
        const SizedBox(height: VaderTheme.spacingM),
        Wrap(
          spacing: VaderTheme.spacingS,
          runSpacing: VaderTheme.spacingS,
          children: AppConstants.conduitBendTypes.map((bendType) {
            final isSelected = _selectedBendType == bendType;
            return ChoiceChip(
              label: Text(bendType, style: TextStyle(fontFamily: 'Orbitron', fontSize: 12, color: isSelected ? VaderColors.blackVoid : VaderColors.silverChrome)),
              selected: isSelected,
              onSelected: (selected) { if (selected) setState(() => _selectedBendType = bendType); },
              selectedColor: VaderColors.redSith,
              backgroundColor: VaderColors.darkGray,
              checkmarkColor: VaderColors.blackVoid,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(VaderTheme.borderRadiusSmall), side: BorderSide(color: isSelected ? VaderColors.redSith : VaderColors.grayDark, width: 1)),
            );
          }).toList(),
        ),
      ]),
    );
  }

  Widget _buildConduitSelector() {
    return Container(
      margin: const EdgeInsets.all(VaderTheme.spacingM),
      padding: const EdgeInsets.all(VaderTheme.spacingM),
      decoration: BoxDecoration(color: VaderColors.blackCarbon, borderRadius: BorderRadius.circular(VaderTheme.borderRadiusLarge), border: Border.all(color: VaderColors.redDark, width: 1)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('CONDUIT SELECTION', style: TextStyle(fontFamily: 'Orbitron', fontSize: 14, fontWeight: FontWeight.bold, color: VaderColors.redSith, letterSpacing: 1)),
        const SizedBox(height: VaderTheme.spacingL),
        Row(children: [
          const Expanded(child: Text('Type:', style: TextStyle(fontFamily: 'Orbitron', fontSize: 14, color: VaderColors.grayLight))),
          DropdownButton<String>(
            value: _selectedConduitType,
            dropdownColor: VaderColors.charcoal,
            underline: const SizedBox(),
            style: const TextStyle(fontFamily: 'Orbitron', fontSize: 14, color: VaderColors.redSith),
            items: AppConstants.conduitTypes.map((type) { final shortName = type.split(' ').first; return DropdownMenuItem(value: shortName, child: Text(shortName)); }).toList(),
            onChanged: (value) { if (value != null) setState(() => _selectedConduitType = value); },
          ),
        ]),
        const SizedBox(height: VaderTheme.spacingM),
        Row(children: [
          const Expanded(child: Text('Size:', style: TextStyle(fontFamily: 'Orbitron', fontSize: 14, color: VaderColors.grayLight))),
          DropdownButton<double>(
            value: _selectedConduitSize,
            dropdownColor: VaderColors.charcoal,
            underline: const SizedBox(),
            style: const TextStyle(fontFamily: 'Orbitron', fontSize: 14, color: VaderColors.redSith),
            items: AppConstants.conduitSizes.map((size) { final displaySize = size >= 1 ? '${size.toInt()}"' : '${(size * 2).toInt()}/2"'; return DropdownMenuItem(value: size, child: Text(displaySize)); }).toList(),
            onChanged: (value) { if (value != null) setState(() => _selectedConduitSize = value); },
          ),
        ]),
      ]),
    );
  }

  Widget _buildCalculator() {
    final bendDeduction = AppConstants.bendDeductions[_selectedConduitSize] ?? 6.0;
    final bendRadius = AppConstants.bendRadius[_selectedConduitSize] ?? 4.0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: VaderTheme.spacingM),
      child: VaderCard(
        hasGlow: true,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: VaderColors.redDark.withOpacity(0.3), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.calculate, color: VaderColors.redSith, size: 24)),
            const SizedBox(width: VaderTheme.spacingM),
            const Expanded(child: Text('BEND CALCULATIONS', style: TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.bold, color: VaderColors.silverChrome))),
          ]),
          const SizedBox(height: VaderTheme.spacingL),
          Container(
            padding: const EdgeInsets.all(VaderTheme.spacingM),
            decoration: BoxDecoration(color: VaderColors.darkGray, borderRadius: BorderRadius.circular(VaderTheme.borderRadiusMedium)),
            child: Column(children: [
              Text(_selectedBendType.toUpperCase(), style: const TextStyle(fontFamily: 'Orbitron', fontSize: 18, fontWeight: FontWeight.bold, color: VaderColors.redSith)),
              const SizedBox(height: VaderTheme.spacingS),
              Text('$_selectedConduitType - ${_formatConduitSize(_selectedConduitSize)}', style: const TextStyle(fontFamily: 'Orbitron', fontSize: 14, color: VaderColors.grayLight)),
            ]),
          ),
          const SizedBox(height: VaderTheme.spacingL),
          VaderStatRow(stats: [
            VaderStatItem(label: 'Bend Deduction', value: '$bendDeduction"', icon: Icons.straighten),
            VaderStatItem(label: 'Bend Radius', value: '$bendRadius"', icon: Icons.circle),
            VaderStatItem(label: 'Multiplier', value: '2.0', icon: Icons.multiplier),
          ]),
          const SizedBox(height: VaderTheme.spacingL),
          Container(
            padding: const EdgeInsets.all(VaderTheme.spacingM),
            decoration: BoxDecoration(color: VaderColors.blackVoid, borderRadius: BorderRadius.circular(VaderTheme.borderRadiusMedium), border: Border.all(color: VaderColors.redDark, width: 1)),
            child: Column(children: [
              const Text('BEND DIAGRAM', style: TextStyle(fontFamily: 'Orbitron', fontSize: 12, color: VaderColors.grayMedium)),
              const SizedBox(height: VaderTheme.spacingM),
              CustomPaint(size: const Size(200, 100), painter: _BendDiagramPainter(bendType: _selectedBendType)),
            ]),
          ),
          const SizedBox(height: VaderTheme.spacingL),
          Row(children: [
            Expanded(child: VaderButton(text: 'Calculate', onPressed: () => _showCalculationDetails(bendDeduction, bendRadius), icon: Icons.calculate)),
            const SizedBox(width: VaderTheme.spacingM),
            Expanded(child: VaderButton(text: 'Practice', onPressed: () => _showComingSoon('Practice Mode'), isOutlined: true, icon: Icons.play_circle_outline)),
          ]),
        ]),
      ),
    );
  }

  Widget _buildBendGuides() {
    return Container(
      margin: const EdgeInsets.all(VaderTheme.spacingM),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('BEND GUIDES', style: TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.bold, color: VaderColors.silverChrome)),
        const SizedBox(height: VaderTheme.spacingM),
        VaderListCard(title: '90° Stub-Up Bend Guide', subtitle: 'Step-by-step instructions', icon: Icons.list, onTap: () => _showComingSoon('Stub-Up Guide')),
        const SizedBox(height: VaderTheme.spacingS),
        VaderListCard(title: 'Offset Bend Calculator', subtitle: 'Calculate offset measurements', icon: Icons.calculate, onTap: () => _showComingSoon('Offset Calculator')),
        const SizedBox(height: VaderTheme.spacingS),
        VaderListCard(title: 'Saddle Bend Tutorial', subtitle: '3-point and 4-point saddles', icon: Icons.video_library, onTap: () => _showComingSoon('Saddle Tutorial')),
        const SizedBox(height: VaderTheme.spacingS),
        VaderListCard(title: 'Bend Allowance Tables', subtitle: 'Reference tables for all sizes', icon: Icons.table_chart, onTap: () => _showComingSoon('Bend Tables')),
      ]),
    );
  }

  String _formatConduitSize(double size) {
    if (size < 1) return '${(size * 2).toInt()}/2"';
    if (size == size.toInt()) return '${size.toInt()}"';
    final whole = size.toInt();
    final fraction = ((size - whole) * 4).round();
    return '$whole-${fraction}/4"';
  }

  void _showCalculationDetails(double bendDeduction, double bendRadius) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: VaderColors.charcoal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(VaderTheme.borderRadiusLarge), side: const BorderSide(color: VaderColors.redDark, width: 1)),
        title: const Text('CALCULATION DETAILS', style: TextStyle(fontFamily: 'Orbitron', color: VaderColors.redSith)),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildDetailRow('Conduit Type', _selectedConduitType),
            _buildDetailRow('Conduit Size', _formatConduitSize(_selectedConduitSize)),
            _buildDetailRow('Bend Type', _selectedBendType),
            const Divider(color: VaderColors.redDark),
            _buildDetailRow('Bend Deduction', '$bendDeduction inches'),
            _buildDetailRow('Minimum Bend Radius', '$bendRadius inches'),
            _buildDetailRow('Gain', '${(bendDeduction * 0.43).toStringAsFixed(2)} inches'),
            const SizedBox(height: VaderTheme.spacingM),
            const VaderInfoCard(title: 'Remember', content: 'Always account for the bender you are using. Different benders may have different take-up values.', icon: Icons.lightbulb_outline),
          ]),
        ),
        actions: [VaderTextButton(text: 'Close', onPressed: () => Navigator.pop(context))],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(fontFamily: 'Orbitron', fontSize: 12, color: VaderColors.grayMedium)),
      Text(value, style: const TextStyle(fontFamily: 'Orbitron', fontSize: 14, fontWeight: FontWeight.bold, color: VaderColors.silverChrome)),
    ]));
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

class _BendDiagramPainter extends CustomPainter {
  final String bendType;
  _BendDiagramPainter({required this.bendType});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = VaderColors.redSith..strokeWidth = 3..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    final centerPaint = Paint()..color = VaderColors.accentGold..strokeWidth = 2..style = PaintingStyle.stroke;
    final path = Path();
    switch (bendType) {
      case '90° Stub-Up':
        path.moveTo(0, size.height - 20);
        path.lineTo(0, size.height / 2);
        path.quadraticBezierTo(0, size.height / 2 - 30, 30, size.height / 2 - 30);
        path.lineTo(size.width - 20, size.height / 2 - 30);
        break;
      case 'Offset Bend':
        path.moveTo(0, size.height / 2);
        path.lineTo(30, size.height / 2);
        path.quadraticBezierTo(45, size.height / 2 - 15, 60, size.height / 2);
        path.lineTo(size.width - 60, size.height / 2);
        path.quadraticBezierTo(size.width - 45, size.height / 2 + 15, size.width - 30, size.height / 2);
        path.lineTo(size.width, size.height / 2);
        break;
      default:
        path.moveTo(0, size.height - 20);
        path.lineTo(size.width, size.height - 20);
    }
    canvas.drawPath(path, paint);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 5, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
