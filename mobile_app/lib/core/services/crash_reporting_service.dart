import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import '../utils/logger.dart';

/// Crash reporting service using Firebase Crashlytics
class CrashReportingService {
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  /// Initialize crash reporting
  Future<void> initialize() async {
    try {
      // Enable crash collection in release mode
      await _crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);

      // Pass all uncaught errors to Crashlytics
      FlutterError.onError = _crashlytics.recordFlutterFatalError;

      // Handle async errors
      PlatformDispatcher.instance.onError = (error, stack) {
        _crashlytics.recordError(error, stack, fatal: true);
        return true;
      };

      AppLogger.info('Crash reporting initialized');
    } catch (e) {
      AppLogger.error('Failed to initialize crash reporting', e);
    }
  }

  /// Log a non-fatal error
  Future<void> logError(
    dynamic error,
    StackTrace? stackTrace, {
    String? reason,
  }) async {
    try {
      await _crashlytics.recordError(
        error,
        stackTrace,
        reason: reason,
        fatal: false,
      );
      AppLogger.warning('Non-fatal error logged to Crashlytics');
    } catch (e) {
      AppLogger.error('Failed to log error to Crashlytics', e);
    }
  }

  /// Log a message
  Future<void> log(String message) async {
    try {
      await _crashlytics.log(message);
    } catch (e) {
      AppLogger.error('Failed to log message to Crashlytics', e);
    }
  }

  /// Set user identifier
  Future<void> setUserId(String userId) async {
    try {
      await _crashlytics.setUserIdentifier(userId);
      AppLogger.info('Crashlytics user ID set');
    } catch (e) {
      AppLogger.error('Failed to set user ID in Crashlytics', e);
    }
  }

  /// Set custom key-value pair
  Future<void> setCustomKey(String key, dynamic value) async {
    try {
      await _crashlytics.setCustomKey(key, value);
    } catch (e) {
      AppLogger.error('Failed to set custom key in Crashlytics', e);
    }
  }

  /// Check if crash reporting is enabled
  bool get isCrashCollectionEnabled => !kDebugMode;
}
