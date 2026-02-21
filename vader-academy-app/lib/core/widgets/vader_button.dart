// File: lib/core/widgets/vader_button.dart
// *heavy breathing* 🫁 The button of power...

import 'package:flutter/material.dart';
import '../theme/vader_colors.dart';

/// Vader Button - Glove-friendly, dark side approved
class VaderButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDestructive;
  final IconData? icon;
  final double? width;
  final double height;
  final bool isOutlined;

  const VaderButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isDestructive = false,
    this.icon,
    this.width,
    this.height = 56,
    this.isOutlined = false,
  });

  @override
  State<VaderButton> createState() => _VaderButtonState();
}

class _VaderButtonState extends State<VaderButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.onPressed != null && !widget.isLoading;
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(scale: _scaleAnimation.value, child: child),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isEnabled ? _handleTap : null,
            onTapDown: (_) => _handleTapDown(),
            onTapUp: (_) => _handleTapUp(),
            onTapCancel: () => _handleTapUp(),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                gradient: widget.isOutlined ? null : (isEnabled ? (widget.isDestructive ? const LinearGradient(colors: [VaderColors.error, VaderColors.redDark]) : VaderColors.lightsaberGradient) : const LinearGradient(colors: [VaderColors.grayDark, VaderColors.grayMedium])),
                color: widget.isOutlined ? Colors.transparent : null,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: isEnabled ? (widget.isDestructive ? VaderColors.error : VaderColors.redSith) : VaderColors.grayMedium, width: 2),
                boxShadow: isEnabled && !widget.isDestructive && !widget.isOutlined ? VaderColors.glowShadow : null,
              ),
              child: Center(
                child: widget.isLoading
                    ? SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(VaderColors.blackVoid)))
                    : Row(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                        if (widget.icon != null) ...[Icon(widget.icon, color: isEnabled ? VaderColors.blackVoid : VaderColors.grayLight, size: 20), const SizedBox(width: 8)],
                        Text(widget.text.toUpperCase(), style: TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.bold, color: widget.isOutlined ? (isEnabled ? VaderColors.redSith : VaderColors.grayLight) : (isEnabled ? VaderColors.blackVoid : VaderColors.grayLight), letterSpacing: 1)),
                      ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleTapDown() {
    if (widget.onPressed != null && !widget.isLoading) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp() {
    if (_isPressed) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTap() {
    if (widget.onPressed != null && !widget.isLoading) {
      widget.onPressed!();
    }
  }
}

/// Vader Icon Button
class VaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool isDestructive;
  final double size;
  final bool isSelected;

  const VaderIconButton({super.key, required this.icon, this.onPressed, this.tooltip, this.isDestructive = false, this.size = 48, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;
    final Widget button = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: isEnabled ? (isDestructive ? VaderColors.error.withOpacity(0.2) : (isSelected ? VaderColors.redSith.withOpacity(0.3) : VaderColors.redDark.withOpacity(0.2))) : VaderColors.grayDark.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isEnabled ? (isDestructive ? VaderColors.error : (isSelected ? VaderColors.redSith : VaderColors.redSith)) : VaderColors.grayDark, width: 2),
          ),
          child: Icon(icon, color: isEnabled ? (isDestructive ? VaderColors.error : (isSelected ? VaderColors.redSith : VaderColors.redSith)) : VaderColors.grayMedium, size: 24),
        ),
      ),
    );
    return tooltip != null ? Tooltip(message: tooltip!, child: button) : button;
  }
}

/// Vader Text Button
class VaderTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isDestructive;
  final IconData? icon;

  const VaderTextButton({super.key, required this.text, this.onPressed, this.isDestructive = false, this.icon});

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: 18, color: isEnabled ? (isDestructive ? VaderColors.error : VaderColors.redSith) : VaderColors.grayMedium), const SizedBox(width: 8)],
            Text(text.toUpperCase(), style: TextStyle(fontFamily: 'Orbitron', fontSize: 14, fontWeight: FontWeight.w600, color: isEnabled ? (isDestructive ? VaderColors.error : VaderColors.redSith) : VaderColors.grayMedium, letterSpacing: 1)),
          ],
        ),
      ),
    );
  }
}
