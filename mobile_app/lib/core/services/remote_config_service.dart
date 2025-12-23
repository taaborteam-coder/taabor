import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

abstract class RemoteConfigService {
  Future<void> initialize();
  String getString(String key);
  bool getBool(String key);
  int getInt(String key);
  double getDouble(String key);
}

class RemoteConfigServiceImpl implements RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigServiceImpl({FirebaseRemoteConfig? remoteConfig})
    : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  @override
  Future<void> initialize() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: kDebugMode
              ? const Duration(minutes: 5)
              : const Duration(hours: 12),
        ),
      );

      await _remoteConfig.setDefaults(const {
        'enable_maintenance_mode': false,
        'max_booking_per_user': 3,
        'welcome_message_ar': 'أهلاً بك في طابور',
        'welcome_message_en': 'Welcome to Taabor',
        'welcome_message_ku': 'Bexerbey bo Taabor',
        'app_min_version': '1.0.0',
      });

      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      debugPrint('Remote Config fetch failed: $e');
    }
  }

  @override
  String getString(String key) => _remoteConfig.getString(key);

  @override
  bool getBool(String key) => _remoteConfig.getBool(key);

  @override
  int getInt(String key) => _remoteConfig.getInt(key);

  @override
  double getDouble(String key) => _remoteConfig.getDouble(key);
}
