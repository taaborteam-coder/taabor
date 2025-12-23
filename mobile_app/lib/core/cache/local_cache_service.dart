import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalCacheService {
  final SharedPreferences prefs;

  LocalCacheService({required this.prefs});

  // Save string
  Future<bool> saveString(String key, String value) async {
    return await prefs.setString(key, value);
  }

  // Get string
  String? getString(String key) {
    return prefs.getString(key);
  }

  // Save JSON
  Future<bool> saveJson(String key, Map<String, dynamic> data) async {
    final jsonString = json.encode(data);
    return await prefs.setString(key, jsonString);
  }

  // Get JSON
  Map<String, dynamic>? getJson(String key) {
    final jsonString = prefs.getString(key);
    if (jsonString == null) return null;
    return json.decode(jsonString);
  }

  // Save list
  Future<bool> saveList(String key, List<String> list) async {
    return await prefs.setStringList(key, list);
  }

  // Get list
  List<String>? getList(String key) {
    return prefs.getStringList(key);
  }

  // Save bool
  Future<bool> saveBool(String key, bool value) async {
    return await prefs.setBool(key, value);
  }

  // Get bool
  bool? getBool(String key) {
    return prefs.getBool(key);
  }

  // Save int
  Future<bool> saveInt(String key, int value) async {
    return await prefs.setInt(key, value);
  }

  // Get int
  int? getInt(String key) {
    return prefs.getInt(key);
  }

  // Remove
  Future<bool> remove(String key) async {
    return await prefs.remove(key);
  }

  // Clear all
  Future<bool> clearAll() async {
    return await prefs.clear();
  }

  // Check if exists
  bool hasKey(String key) {
    return prefs.containsKey(key);
  }
}
