import 'package:hive_flutter/hive_flutter.dart';
import '../logging/app_logger.dart';

class OfflineService {
  static const String ticketBoxName = 'tickets';
  static const String businessBoxName = 'businesses';

  Future<void> initialize() async {
    try {
      await Hive.initFlutter();
      await Hive.openBox(ticketBoxName);
      await Hive.openBox(businessBoxName);
      AppLogger.info('Hive initialized successfully');
    } catch (e) {
      AppLogger.error('Error initializing Hive', e);
    }
  }

  Future<void> cacheTicket(Map<String, dynamic> ticketData) async {
    try {
      final box = Hive.box(ticketBoxName);
      await box.put(ticketData['id'], ticketData);
    } catch (e) {
      AppLogger.error('Error caching ticket', e);
    }
  }

  List<Map<dynamic, dynamic>> getCachedTickets() {
    try {
      final box = Hive.box(ticketBoxName);
      return box.values.toList().cast<Map<dynamic, dynamic>>();
    } catch (e) {
      AppLogger.error('Error fetching cached tickets', e);
      return [];
    }
  }
}
