import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Custom logger for the application
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  /// Log debug message
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.d(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Log info message
  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Log warning message
  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Log error message
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log fatal error
  static void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  AppLogger._();
}

/// Performance monitoring utility
class PerformanceMonitor {
  static final Map<String, DateTime> _startTimes = {};
  static final Map<String, Duration> _metrics = {};

  /// Start measuring performance for a specific operation
  static void start(String operationName) {
    _startTimes[operationName] = DateTime.now();
    AppLogger.debug('Performance: Started measuring "$operationName"');
  }

  /// Stop measuring and log the duration
  static Duration stop(String operationName) {
    final startTime = _startTimes[operationName];
    if (startTime == null) {
      AppLogger.warning(
        'Performance: No start time found for "$operationName"',
      );
      return Duration.zero;
    }

    final duration = DateTime.now().difference(startTime);
    _metrics[operationName] = duration;
    _startTimes.remove(operationName);

    AppLogger.info(
      'Performance: "$operationName" took ${duration.inMilliseconds}ms',
    );

    return duration;
  }

  /// Get all recorded metrics
  static Map<String, Duration> getMetrics() => Map.from(_metrics);

  /// Clear all metrics
  static void clearMetrics() {
    _metrics.clear();
    _startTimes.clear();
  }

  /// Log slow operations (> threshold)
  static void logSlowOperations({
    Duration threshold = const Duration(seconds: 1),
  }) {
    final slowOps = _metrics.entries
        .where((entry) => entry.value > threshold)
        .toList();

    if (slowOps.isNotEmpty) {
      AppLogger.warning(
        'Slow operations detected: ${slowOps.map((e) => '${e.key}: ${e.value.inMilliseconds}ms').join(', ')}',
      );
    }
  }

  PerformanceMonitor._();
}

/// Memory usage monitoring
class MemoryMonitor {
  /// Log current memory usage
  static void logMemoryUsage() {
    // Note: This is a simple implementation
    // For production, consider using https://pub.dev/packages/vm_service
    if (kDebugMode) {
      AppLogger.debug('Memory monitoring: Check DevTools for detailed stats');
    }
  }

  MemoryMonitor._();
}
