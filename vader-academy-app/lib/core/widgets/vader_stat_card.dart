// File: lib/core/widgets/vader_stat_card.dart
// *heavy breathing* 🫁 Display your metrics of power...

import 'package:flutter/material.dart';
import '../theme/vader_colors.dart';
import '../theme/vader_theme.dart';
import 'vader_card.dart';

/// Lightsaber Progress Bar
class LightsaberProgress extends StatelessWidget {
  final double progress;
  final double height;
  final bool isGlowing;

  const LightsaberProgress({super.key, required this.progress, this.height = 8, this.isGlowing = true});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Stack(children: [
        Container(height: height, color: VaderColors.darkGray),
        FractionallySizedBox(widthFactor: progress.clamp(0.0, 1.0), child: Container(height: height, decoration: BoxDecoration(gradient: VaderColors.lightsaberGradient, boxShadow: isGlowing ? VaderColors.glowShadow : null))),
      ]),
    );
  }
}

/// Circular Progress with Sith styling
class VaderCircularProgress extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final String? label;
  final String? value;
  final Color? color;

  const VaderCircularProgress({super.key, required this.progress, this.size = 120, this.strokeWidth = 8, this.label, this.value, this.color});

  @override
  Widget build(BuildContext context) {
    final displayColor = color ?? VaderColors.redSith;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(alignment: Alignment.center, children: [
        SizedBox(width: size, height: size, child: CircularProgressIndicator(value: 1.0, strokeWidth: strokeWidth, backgroundColor: VaderColors.darkGray, valueColor: const AlwaysStoppedAnimation<Color>(VaderColors.darkGray))),
        SizedBox(width: size, height: size, child: Transform.rotate(angle: -0.5 * 3.14159, child: CircularProgressIndicator(value: progress.clamp(0.0, 1.0), strokeWidth: strokeWidth, backgroundColor: Colors.transparent, valueColor: AlwaysStoppedAnimation<Color>(displayColor), strokeCap: StrokeCap.round))),
        Column(mainAxisSize: MainAxisSize.min, children: [
          if (value != null) Text(value!, style: TextStyle(fontFamily: 'Orbitron', fontSize: 28, fontWeight: FontWeight.bold, color: displayColor)),
          if (label != null) Text(label!, style: const TextStyle(fontFamily: 'Orbitron', fontSize: 12, color: VaderColors.grayMedium)),
        ]),
      ]),
    );
  }
}

/// Stat Row
class VaderStatRow extends StatelessWidget {
  final List<VaderStatItem> stats;

  const VaderStatRow({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: stats.map((stat) => Expanded(child: stat)).toList().intersperse(const SizedBox(width: VaderTheme.spacingM)).toList(),
    );
  }
}

/// Individual stat item
class VaderStatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color? color;

  const VaderStatItem({super.key, required this.label, required this.value, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    final displayColor = color ?? VaderColors.redSith;
    return VaderCard(
      padding: const EdgeInsets.all(12),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        if (icon != null) Icon(icon, color: displayColor, size: 20),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontFamily: 'Orbitron', fontSize: 20, fontWeight: FontWeight.bold, color: displayColor)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontFamily: 'Orbitron', fontSize: 10, color: VaderColors.grayMedium), textAlign: TextAlign.center),
      ]),
    );
  }
}

/// Achievement Badge
class VaderAchievementBadge extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isEarned;
  final DateTime? earnedDate;

  const VaderAchievementBadge({super.key, required this.title, required this.description, required this.icon, this.isEarned = false, this.earnedDate});

  @override
  Widget build(BuildContext context) {
    return VaderCard(
      borderColor: isEarned ? VaderColors.accentGold : VaderColors.grayDark,
      hasGlow: isEarned,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: isEarned ? VaderColors.accentGold.withOpacity(0.2) : VaderColors.grayDark.withOpacity(0.2), shape: BoxShape.circle), child: Icon(icon, color: isEarned ? VaderColors.accentGold : VaderColors.grayMedium, size: 32)),
        const SizedBox(height: 12),
        Text(title, style: TextStyle(fontFamily: 'Orbitron', fontSize: 14, fontWeight: FontWeight.bold, color: isEarned ? VaderColors.accentGold : VaderColors.grayMedium), textAlign: TextAlign.center),
        const SizedBox(height: 4),
        Text(description, style: const TextStyle(fontFamily: 'Roboto', fontSize: 11, color: VaderColors.grayLight), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
        if (earnedDate != null && isEarned) ...[const SizedBox(height: 8), Text('Earned: ${_formatDate(earnedDate!)}', style: const TextStyle(fontFamily: 'Roboto', fontSize: 10, color: VaderColors.grayMedium))],
        if (!isEarned) ...[const SizedBox(height: 8), const Text('🔒 Locked', style: TextStyle(fontFamily: 'Orbitron', fontSize: 10, color: VaderColors.grayDark))],
      ]),
    );
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
