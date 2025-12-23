import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/engagement/data/models/loyalty_profile.dart';

class LoyaltyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get profile stream
  Stream<LoyaltyProfile?> getLoyaltyStream(String businessId, String userId) {
    return _firestore
        .collection('loyalty')
        .where('businessId', isEqualTo: businessId)
        .where('userId', isEqualTo: userId)
        .limit(1)
        .snapshots()
        .map((snapshot) {
          if (snapshot.docs.isEmpty) return null;
          return LoyaltyProfile.fromMap(
            snapshot.docs.first.data(),
            snapshot.docs.first.id,
          );
        });
  }

  // Increment visit and check for rewards
  Future<void> incrementVisit(String businessId, String userId) async {
    final query = _firestore
        .collection('loyalty')
        .where('businessId', isEqualTo: businessId)
        .where('userId', isEqualTo: userId)
        .limit(1);

    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      // Create new profile
      await _firestore.collection('loyalty').add({
        'businessId': businessId,
        'userId': userId,
        'points': 1,
        'completedVisits': 1,
        'rewards': [],
      });
    } else {
      final doc = snapshot.docs.first;
      final data = doc.data();
      int currentPoints = data['points'] ?? 0;
      int currentVisits = data['completedVisits'] ?? 0;
      List<dynamic> currentRewards = List.from(data['rewards'] ?? []);

      int newPoints = currentPoints + 1;
      int newVisits = currentVisits + 1;

      // Rule: Every 5 visits = 1 Reward
      if (newVisits % 5 == 0) {
        currentRewards.add(
          'VIP_COUPON_${DateTime.now().millisecondsSinceEpoch}',
        );
      }

      await doc.reference.update({
        'points': newPoints,
        'completedVisits': newVisits,
        'rewards': currentRewards, // Cast if needed
      });
    }
  }
}
