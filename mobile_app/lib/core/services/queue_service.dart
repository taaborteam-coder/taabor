import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/queue/data/models/queue_item.dart';
import 'package:taabor/core/services/loyalty_service.dart';

class QueueService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LoyaltyService _loyaltyService = LoyaltyService();

  // Add a customer to the queue with sequential ticket number
  Future<void> addToQueue(QueueItem item) async {
    await _firestore.runTransaction((transaction) async {
      // Reference to the business queue to find the last ticket
      final query = await _firestore
          .collection('queue')
          .where('businessId', isEqualTo: item.businessId)
          .orderBy('ticketNumber', descending: true)
          .limit(1)
          .get();

      int nextTicket = 1;
      if (query.docs.isNotEmpty) {
        final lastTicket = query.docs.first.data()['ticketNumber'] as int?;
        if (lastTicket != null) {
          nextTicket = lastTicket + 1;
        }
      }

      // Create new document reference
      final newDocRef = _firestore.collection('queue').doc();

      // Update item with new ID and Ticket Number
      final newItem = QueueItem(
        id: newDocRef.id,
        businessId: item.businessId,
        userId: item.userId,
        customerName: item.customerName,
        timestamp:
            DateTime.now(), // Ensure server time ideally, but client is ok for MVP
        status: 'waiting',
        ticketNumber: nextTicket,
        isPriority: item.isPriority,
      );

      transaction.set(newDocRef, newItem.toMap());
    });
  }

  // Stream of queue items for a specific business
  Stream<List<QueueItem>> getQueueStream(String businessId) {
    return _firestore
        .collection('queue')
        .where('businessId', isEqualTo: businessId)
        .where(
          'status',
          whereIn: ['waiting', 'serving'],
        ) // Show waiting and current
        .orderBy('isPriority', descending: true) // Priority first
        .orderBy('timestamp', descending: false) // Then by time (FCFS)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => QueueItem.fromMap(doc.data(), doc.id))
              .toList();
        });
  }

  // Call the next customer (Ready Now)
  Future<void> callNext(String businessId) async {
    // 1. Find currently serving and mark as completed
    final servingSnapshot = await _firestore
        .collection('queue')
        .where('businessId', isEqualTo: businessId)
        .where('status', isEqualTo: 'serving')
        .get();

    for (var doc in servingSnapshot.docs) {
      await doc.reference.update({'status': 'completed'});

      // Trigger Loyalty Update
      final data = doc.data();
      if (data['userId'] != null) {
        // We use a lazy import or separate instance to avoid circular dependency if possible,
        // but simple instantiation is fine here.
        // Importing LoyaltyService requires adding import at top.
        await _triggerLoyalty(businessId, data['userId']);
      }
    }

    // 2. Find next waiting and mark as serving
    final waitingSnapshot = await _firestore
        .collection('queue')
        .where('businessId', isEqualTo: businessId)
        .where('status', isEqualTo: 'waiting')
        .orderBy('isPriority', descending: true)
        .orderBy('timestamp', descending: false)
        .limit(1)
        .get();

    if (waitingSnapshot.docs.isNotEmpty) {
      await waitingSnapshot.docs.first.reference.update({'status': 'serving'});
    }
  }

  Future<void> _triggerLoyalty(String businessId, String userId) async {
    await _loyaltyService.incrementVisit(businessId, userId);
  }

  // Set Emergency Priority
  Future<void> setEmergencyPriority(String itemId) async {
    await _firestore.collection('queue').doc(itemId).update({
      'isPriority': true,
    });
  }

  // Requeue: Move to end of line
  Future<void> requeue(String itemId) async {
    await _firestore.collection('queue').doc(itemId).update({
      'status': 'waiting',
      'timestamp': Timestamp.now(), // Refresh time to move to end
      'isPriority':
          false, // Reset priority if they missed their turn? Optional.
    });
  }

  // Mark as Missed/Cancelled
  Future<void> updateStatus(String itemId, String newStatus) async {
    await _firestore.collection('queue').doc(itemId).update({
      'status': newStatus,
    });
  }
}
