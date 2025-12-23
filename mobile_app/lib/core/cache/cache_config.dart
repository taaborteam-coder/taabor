/// Local cache keys
class CacheKeys {
  static const String userProfile = 'user_profile';
  static const String businesses = 'businesses';
  static const String tickets = 'tickets';
  static const String favorites = 'favorites';
  static const String lastSync = 'last_sync';
  static const String theme = 'theme';
  static const String language = 'language';
}

/// Cache durations
class CacheDurations {
  static const Duration businesses = Duration(hours: 1);
  static const Duration userProfile = Duration(days: 1);
  static const Duration tickets = Duration(minutes: 30);
}
