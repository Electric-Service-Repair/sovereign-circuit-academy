// File: lib/core/widgets/vader_card.dart
// *heavy breathing* 🫁 The card of imperial knowledge...

import 'package:flutter/material.dart';
import '../theme/vader_colors.dart';
import '../theme/vader_theme.dart';

/// Vader Card - Container for dark side content
class VaderCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool isElevated;
  final bool hasGlow;
  final Color? borderColor;
  final double borderRadius;
  final Color? backgroundColor;
  final Gradient? gradient;

  const VaderCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.isElevated = true,
    this.hasGlow = false,
    this.borderColor,
    this.borderRadius = VaderTheme.borderRadiusLarge,
    this.backgroundColor,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? VaderColors.blackCarbon,
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor ?? VaderColors.redDark, width: 1),
        boxShadow: [...(isElevated ? VaderColors.cardShadow : []), ...(hasGlow ? VaderColors.glowShadow : [])],
      ),
      child: child,
    );
    if (onTap != null) {
      return InkWell(onTap: onTap, borderRadius: BorderRadius.circular(borderRadius), child: card);
    }
    return card;
  }
}

/// Vader Info Card
class VaderInfoCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData? icon;
  final bool isWarning;
  final bool isError;
  final bool isSuccess;

  const VaderInfoCard({super.key, required this.title, required this.content, this.icon, this.isWarning = false, this.isError = false, this.isSuccess = false});

  @override
  Widget build(BuildContext context) {
    final Color accentColor = isError ? VaderColors.error : isWarning ? VaderColors.warning : isSuccess ? VaderColors.success : VaderColors.redSith;
    final IconData displayIcon = icon ?? (isError ? Icons.error_outline : isWarning ? Icons.warning_amber_rounded : isSuccess ? Icons.check_circle_outline : Icons.info_outline);
    return VaderCard(
      borderColor: accentColor,
      hasGlow: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: accentColor.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Icon(displayIcon, color: accentColor, size: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.bold, color: accentColor)),
                const SizedBox(height: 8),
                Text(content, style: const TextStyle(fontFamily: 'Roboto', fontSize: 14, color: VaderColors.grayLight, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Vader Stat Card
class VaderStatCard extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final IconData? icon;
  final Color? valueColor;
  final double? progress;
  final bool showGlow;

  const VaderStatCard({super.key, required this.label, required this.value, this.unit, this.icon, this.valueColor, this.progress, this.showGlow = false});

  @override
  Widget build(BuildContext context) {
    return VaderCard(
      padding: const EdgeInsets.all(12),
      hasGlow: showGlow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [if (icon != null) ...[Icon(icon, size: 16, color: VaderColors.grayMedium), const SizedBox(width: 4)], Text(label, style: const TextStyle(fontFamily: 'Orbitron', fontSize: 12, color: VaderColors.grayMedium))]),
          const SizedBox(height: 8),
          Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
            Text(value, style: TextStyle(fontFamily: 'Orbitron', fontSize: 24, fontWeight: FontWeight.bold, color: valueColor ?? VaderColors.redSith)),
            if (unit != null) ...[const SizedBox(width: 4), Text(unit!, style: const TextStyle(fontFamily: 'Orbitron', fontSize: 14, color: VaderColors.grayLight))],
          ]),
          if (progress != null) ...[const SizedBox(height: 8), ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: progress, backgroundColor: VaderColors.darkGray, valueColor: const AlwaysStoppedAnimation<Color>(VaderColors.redSith), minHeight: 4))],
        ],
      ),
    );
  }
}

/// Vader List Card
class VaderListCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isComplete;

  const VaderListCard({super.key, required this.title, this.subtitle, this.icon, this.trailing, this.onTap, this.isSelected = false, this.isComplete = false});

  @override
  Widget build(BuildContext context) {
    return VaderCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      borderColor: isSelected ? VaderColors.redSith : isComplete ? VaderColors.success : VaderColors.redDark,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if (icon != null) ...[Icon(icon, color: isSelected ? VaderColors.redSith : isComplete ? VaderColors.success : VaderColors.grayLight, size: 24), const SizedBox(width: 12)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.bold, color: isSelected ? VaderColors.redSith : isComplete ? VaderColors.success : VaderColors.silverChrome)),
                  if (subtitle != null) ...[const SizedBox(height: 4), Text(subtitle!, style: const TextStyle(fontFamily: 'Roboto', fontSize: 12, color: VaderColors.grayMedium))],
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

/// Vader Module Card
class VaderModuleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final double progress;
  final VoidCallback? onTap;
  final bool isLocked;

  const VaderModuleCard({super.key, required this.title, required this.description, required this.icon, this.progress = 0.0, this.onTap, this.isLocked = false});

  @override
  Widget build(BuildContext context) {
    final opacity = isLocked ? 0.5 : 1.0;
    return VaderCard(
      onTap: isLocked ? null : onTap,
      hasGlow: !isLocked && progress > 0,
      child: Opacity(
        opacity: opacity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: VaderColors.redDark.withOpacity(0.3), borderRadius: BorderRadius.circular(8)), child: Icon(isLocked ? Icons.lock_outline : icon, color: isLocked ? VaderColors.grayMedium : VaderColors.redSith, size: 28)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(title, style: const TextStyle(fontFamily: 'Orbitron', fontSize: 18, fontWeight: FontWeight.bold, color: VaderColors.silverChrome)),
                    const SizedBox(height: 4),
                    Text(description, style: const TextStyle(fontFamily: 'Roboto', fontSize: 12, color: VaderColors.grayLight), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ]),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: progress, backgroundColor: VaderColors.darkGray, valueColor: const AlwaysStoppedAnimation<Color>(VaderColors.redSith), minHeight: 6))),
              const SizedBox(width: 12),
              Text('${(progress * 100).toInt()}%', style: const TextStyle(fontFamily: 'Orbitron', fontSize: 12, fontWeight: FontWeight.bold, color: VaderColors.redSith)),
            ]),
          ],
        ),
      ),
    );
  }
}
