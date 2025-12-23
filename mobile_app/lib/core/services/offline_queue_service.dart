import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OfflineQueueService {
  final SharedPreferences prefs;
  static const String _queueKey = 'offline_queue';

  OfflineQueueService({required this.prefs});

  // Add operation to queue
  Future<void> addOperation(Map<String, dynamic> operation) async {
    final queue = await getQueue();
    queue.add({...operation, 'timestamp': DateTime.now().toIso8601String()});
    await _saveQueue(queue);
  }

  // Get all queued operations
  Future<List<Map<String, dynamic>>> getQueue() async {
    final jsonString = prefs.getString(_queueKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.cast<Map<String, dynamic>>();
  }

  // Remove operation from queue
  Future<void> removeOperation(int index) async {
    final queue = await getQueue();
    if (index >= 0 && index < queue.length) {
      queue.removeAt(index);
      await _saveQueue(queue);
    }
  }

  // Clear all queue
  Future<void> clearQueue() async {
    await prefs.remove(_queueKey);
  }

  // Save queue
  Future<void> _saveQueue(List<Map<String, dynamic>> queue) async {
    await prefs.setString(_queueKey, json.encode(queue));
  }

  // Get queue count
  Future<int> getQueueCount() async {
    final queue = await getQueue();
    return queue.length;
  }
}
