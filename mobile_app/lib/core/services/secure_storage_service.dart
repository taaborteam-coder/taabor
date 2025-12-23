import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

/// Secure storage service for sensitive data
class SecureStorageService {
  final FlutterSecureStorage _storage;
  final Logger _logger;

  SecureStorageService({FlutterSecureStorage? storage, Logger? logger})
    : _storage = storage ?? const FlutterSecureStorage(),
      _logger = logger ?? Logger();

  /// Save auth token
  Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: 'auth_token', value: token);
      _logger.i('Token saved securely');
    } catch (e) {
      _logger.e('Failed to save token', error: e);
    }
  }

  /// Get auth token
  Future<String?> getToken() async {
    try {
      return await _storage.read(key: 'auth_token');
    } catch (e) {
      _logger.e('Failed to read token', error: e);
      return null;
    }
  }

  /// Delete auth token
  Future<void> deleteToken() async {
    try {
      await _storage.delete(key: 'auth_token');
      _logger.i('Token deleted');
    } catch (e) {
      _logger.e('Failed to delete token', error: e);
    }
  }

  /// Save any secure data
  Future<void> save(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      _logger.e('Failed to save $key', error: e);
    }
  }

  /// Read secure data
  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      _logger.e('Failed to read $key', error: e);
      return null;
    }
  }

  /// Delete secure data
  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      _logger.e('Failed to delete $key', error: e);
    }
  }

  /// Clear all secure data
  Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
      _logger.i('All secure data cleared');
    } catch (e) {
      _logger.e('Failed to clear all data', error: e);
    }
  }

  /// Check if key exists
  Future<bool> hasKey(String key) async {
    try {
      final value = await _storage.read(key: key);
      return value != null;
    } catch (e) {
      return false;
    }
  }
}
