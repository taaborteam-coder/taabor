import 'package:firebase_analytics/firebase_analytics.dart';
import '../utils/logger.dart';

/// Analytics service for tracking user events and behavior
class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Log user login event
  Future<void> logLogin(String method) async {
    try {
      await _analytics.logLogin(loginMethod: method);
      AppLogger.info('Analytics: Login event logged (method: $method)');
    } catch (e) {
      AppLogger.error('Failed to log login event', e);
    }
  }

  /// Log user signup event
  Future<void> logSignUp(String method) async {
    try {
      await _analytics.logSignUp(signUpMethod: method);
      AppLogger.info('Analytics: SignUp event logged (method: $method)');
    } catch (e) {
      AppLogger.error('Failed to log signup event', e);
    }
  }

  /// Log ticket booking
  Future<void> logTicketBooked({
    required String businessId,
    required String serviceName,
    required double estimatedWaitTime,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'ticket_booked',
        parameters: {
          'business_id': businessId,
          'service_name': serviceName,
          'estimated_wait_minutes': estimatedWaitTime,
        },
      );
      AppLogger.info('Analytics: Ticket booked event logged');
    } catch (e) {
      AppLogger.error('Failed to log ticket booking', e);
    }
  }

  /// Log business view
  Future<void> logBusinessView(String businessId, String businessName) async {
    try {
      await _analytics.logViewItem(
        items: [AnalyticsEventItem(itemId: businessId, itemName: businessName)],
      );
      AppLogger.info('Analytics: Business view logged');
    } catch (e) {
      AppLogger.error('Failed to log business view', e);
    }
  }

  /// Log search
  Future<void> logSearch(String searchTerm) async {
    try {
      await _analytics.logSearch(searchTerm: searchTerm);
      AppLogger.info('Analytics: Search logged (term: $searchTerm)');
    } catch (e) {
      AppLogger.error('Failed to log search', e);
    }
  }

  /// Log offer view
  Future<void> logOfferView(String offerId, String offerTitle) async {
    try {
      await _analytics.logEvent(
        name: 'offer_viewed',
        parameters: {'offer_id': offerId, 'offer_title': offerTitle},
      );
      AppLogger.info('Analytics: Offer view logged');
    } catch (e) {
      AppLogger.error('Failed to log offer view', e);
    }
  }

  /// Log screen view
  Future<void> logScreenView(String screenName) async {
    try {
      await _analytics.logScreenView(screenName: screenName);
      AppLogger.debug('Analytics: Screen view logged ($screenName)');
    } catch (e) {
      AppLogger.error('Failed to log screen view', e);
    }
  }

  /// Set user ID
  Future<void> setUserId(String userId) async {
    try {
      await _analytics.setUserId(id: userId);
      AppLogger.info('Analytics: User ID set');
    } catch (e) {
      AppLogger.error('Failed to set user ID', e);
    }
  }

  /// Set user property
  Future<void> setUserProperty(String name, String value) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
      AppLogger.debug('Analytics: User property set ($name: $value)');
    } catch (e) {
      AppLogger.error('Failed to set user property', e);
    }
  }

  /// Log error event
  Future<void> logError(String errorMessage, String errorType) async {
    try {
      await _analytics.logEvent(
        name: 'app_error',
        parameters: {'error_message': errorMessage, 'error_type': errorType},
      );
      AppLogger.warning('Analytics: Error logged');
    } catch (e) {
      AppLogger.error('Failed to log error event', e);
    }
  }
}
