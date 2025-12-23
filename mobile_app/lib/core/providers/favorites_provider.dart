import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  List<String> _favoriteIds = [];

  List<String> get favoriteIds => _favoriteIds;

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteIds = prefs.getStringList('favorite_business_ids') ?? [];
    notifyListeners();
  }

  Future<void> toggleFavorite(String businessId) async {
    final prefs = await SharedPreferences.getInstance();
    if (_favoriteIds.contains(businessId)) {
      _favoriteIds.remove(businessId);
    } else {
      _favoriteIds.add(businessId);
    }
    await prefs.setStringList('favorite_business_ids', _favoriteIds);
    notifyListeners();
  }

  bool isFavorite(String businessId) {
    return _favoriteIds.contains(businessId);
  }
}
