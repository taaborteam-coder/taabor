import 'package:flutter/material.dart';

enum LamassuMode { icon, floating, full }

class LamassuWidget extends StatelessWidget {
  final LamassuMode mode;
  final double? size;
  final VoidCallback? onTap;

  const LamassuWidget({
    super.key,
    this.mode = LamassuMode.icon,
    this.size,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // If we had a Lottie file, we would use Lottie.asset('assets/lottie/lamassu.json')
    // For now, using the generated gold 3D image as a placeholder for the high-end look.

    final double dimensions = size ?? (mode == LamassuMode.icon ? 24 : 100);

    Widget content = Image.asset(
      'assets/images/lamassu_style.png',
      width: dimensions,
      height: dimensions,
      fit: BoxFit.contain,
    );

    if (mode == LamassuMode.floating) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withValues(alpha: 0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: content,
        ),
      );
    }

    if (mode == LamassuMode.icon) {
      return GestureDetector(onTap: onTap, child: content);
    }

    // Full mode
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Colors.amber.withOpacity(0.2), Colors.transparent],
              ),
            ),
            child: content,
          ),
        ],
      ),
    );
  }
}
