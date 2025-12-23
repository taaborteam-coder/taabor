import 'package:flutter/services.dart';

class HapticFeedbackService {
  // Light impact
  static void light() {
    HapticFeedback.lightImpact();
  }

  // Medium impact
  static void medium() {
    HapticFeedback.mediumImpact();
  }

  // Heavy impact
  static void heavy() {
    HapticFeedback.heavyImpact();
  }

  // Selection click
  static void selection() {
    HapticFeedback.selectionClick();
  }

  // Vibrate (for notifications)
  static void vibrate() {
    HapticFeedback.vibrate();
  }

  // Success feedback
  static void success() {
    HapticFeedback.mediumImpact();
  }

  // Error feedback
  static void error() {
    HapticFeedback.heavyImpact();
    Future.delayed(const Duration(milliseconds: 100), () {
      HapticFeedback.heavyImpact();
    });
  }

  // Warning feedback
  static void warning() {
    HapticFeedback.lightImpact();
    Future.delayed(const Duration(milliseconds: 100), () {
      HapticFeedback.lightImpact();
    });
  }
}
