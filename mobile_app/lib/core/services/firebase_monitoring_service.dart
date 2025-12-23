import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';

class FirebaseMonitoringService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;
  static final FirebasePerformance _performance = FirebasePerformance.instance;

  // Initialize Firebase monitoring
  static Future<void> initialize() async {
    // Enable analytics
    await _analytics.setAnalyticsCollectionEnabled(true);

    // Configure Crashlytics
    FlutterError.onError = (errorDetails) {
      _crashlytics.recordFlutterFatalError(errorDetails);
    };

    // Pass all uncaught asynchronous errors
    PlatformDispatcher.instance.onError = (error, stack) {
      _crashlytics.recordError(error, stack, fatal: true);
      return true;
    };

    // Enable performance monitoring
    await _performance.setPerformanceCollectionEnabled(true);
  }

  // Analytics events
  static Future<void> logEvent({
    required String name,
    Map<String, Object?>? parameters,
  }) async {
    await _analytics.logEvent(
      name: name,
      parameters: parameters?.cast<String, Object>(),
    );
  }

  static Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
  }

  static Future<void> logLogin(String method) async {
    await _analytics.logLogin(loginMethod: method);
  }

  static Future<void> logSignUp(String method) async {
    await _analytics.logSignUp(signUpMethod: method);
  }

  static Future<void> logBooking({
    required String businessId,
    required String businessName,
  }) async {
    await _analytics.logEvent(
      name: 'booking_created',
      parameters: {'business_id': businessId, 'business_name': businessName},
    );
  }

  static Future<void> logSearch(String searchTerm) async {
    await _analytics.logSearch(searchTerm: searchTerm);
  }

  // Crashlytics
  static Future<void> logError(
    dynamic exception,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
  }) async {
    await _crashlytics.recordError(
      exception,
      stack,
      reason: reason,
      fatal: fatal,
    );
  }

  static Future<void> setUserIdentifier(String userId) async {
    await _crashlytics.setUserIdentifier(userId);
    await _analytics.setUserId(id: userId);
  }

  static Future<void> setCustomKey(String key, Object value) async {
    await _crashlytics.setCustomKey(key, value);
  }

  // Performance monitoring
  static Future<T> tracePerformance<T>({
    required String traceName,
    required Future<T> Function() operation,
  }) async {
    final trace = _performance.newTrace(traceName);
    await trace.start();
    try {
      final result = await operation();
      await trace.stop();
      return result;
    } catch (e) {
      await trace.stop();
      rethrow;
    }
  }

  static Future<HttpMetric> startHttpMetric({
    required String url,
    required String method,
  }) async {
    final metric = _performance.newHttpMetric(
      url,
      HttpMethod.values.firstWhere(
        (m) =>
            m.toString().split('.').last.toUpperCase() == method.toUpperCase(),
        orElse: () => HttpMethod.Get,
      ),
    );
    await metric.start();
    return metric;
  }

  static Future<void> stopHttpMetric(
    HttpMetric metric, {
    int? responseCode,
    int? requestPayloadSize,
    int? responsePayloadSize,
  }) async {
    if (responseCode != null) metric.httpResponseCode = responseCode;
    if (requestPayloadSize != null) {
      metric.requestPayloadSize = requestPayloadSize;
    }
    if (responsePayloadSize != null) {
      metric.responsePayloadSize = responsePayloadSize;
    }
    await metric.stop();
  }
}
