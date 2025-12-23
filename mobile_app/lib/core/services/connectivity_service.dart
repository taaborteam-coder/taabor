import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  // Stream of connectivity status
  Stream<bool> get connectivityStream {
    return _connectivity.onConnectivityChanged.map(
      (results) => _isConnected(results),
    );
  }

  // Check if currently connected
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return _isConnected(results);
  }

  // Start listening to connectivity changes
  void startMonitoring(Function(bool isConnected) onConnectivityChanged) {
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      onConnectivityChanged(_isConnected(results));
    });
  }

  // Stop listening
  void stopMonitoring() {
    _subscription?.cancel();
  }

  // Helper to check if connected
  bool _isConnected(List<ConnectivityResult> results) {
    // If results contain anything other than none, we're connected
    return results.any((result) => result != ConnectivityResult.none);
  }

  void dispose() {
    _subscription?.cancel();
  }
}
