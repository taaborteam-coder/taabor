import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/membership_tier.dart';
import '../models/loyalty_point_model.dart';
import '../models/reward_model.dart';

abstract class LoyaltyRemoteDataSource {
  Future<int> getUserPoints(String userId);
  Future<List<LoyaltyPointModel>> getPointsHistory(String userId);
  Future<void> addPoints({
    required String userId,
    required int points,
    required String source,
    String? referenceId,
  });
  Future<void> deductPoints({
    required String userId,
    required int points,
    required String reason,
  });
  Future<List<RewardModel>> getAvailableRewards({String? businessId});
  Future<void> redeemReward({required String userId, required String rewardId});
  Future<List<RewardModel>> getUserRedeemedRewards(String userId);
}

class LoyaltyRemoteDataSourceImpl implements LoyaltyRemoteDataSource {
  final FirebaseFirestore firestore;

  LoyaltyRemoteDataSourceImpl({required this.firestore});

  @override
  Future<int> getUserPoints(String userId) async {
    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('loyalty_points')
        .get();

    int totalPoints = 0;
    final now = DateTime.now();

    for (final doc in snapshot.docs) {
      final point = LoyaltyPointModel.fromFirestore(doc);
      // Only count non-expired points
      if (point.expiresAt == null || point.expiresAt!.isAfter(now)) {
        totalPoints += point.points;
      }
    }

    return totalPoints;
  }

  @override
  Future<List<LoyaltyPointModel>> getPointsHistory(String userId) async {
    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('loyalty_points')
        .orderBy('earnedAt', descending: true)
        .limit(50)
        .get();

    return snapshot.docs
        .map((doc) => LoyaltyPointModel.fromFirestore(doc))
        .toList();
  }

  @override
  Future<void> addPoints({
    required String userId,
    required int points,
    required String source,
    String? referenceId,
  }) async {
    final pointData = LoyaltyPointModel(
      id: '',
      userId: userId,
      points: points,
      source: source,
      referenceId: referenceId,
      earnedAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(days: 365)), // 1 year expiry
    );

    await firestore
        .collection('users')
        .doc(userId)
        .collection('loyalty_points')
        .add(pointData.toFirestore());

    // Update user's total points
    final totalPoints = await getUserPoints(userId);
    final tier = MembershipTierEntity.getTierFromPoints(totalPoints);

    await firestore.collection('users').doc(userId).update({
      'totalPoints': totalPoints,
      'membershipTier': tier.name,
    });
  }

  @override
  Future<void> deductPoints({
    required String userId,
    required int points,
    required String reason,
  }) async {
    // Add negative points
    await addPoints(
      userId: userId,
      points: -points,
      source: 'redemption',
      referenceId: reason,
    );
  }

  @override
  Future<List<RewardModel>> getAvailableRewards({String? businessId}) async {
    Query query = firestore
        .collection('rewards')
        .where('isActive', isEqualTo: true);

    if (businessId != null) {
      query = query.where('businessId', isEqualTo: businessId);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => RewardModel.fromFirestore(doc)).toList();
  }

  @override
  Future<void> redeemReward({
    required String userId,
    required String rewardId,
  }) async {
    final rewardDoc = await firestore.collection('rewards').doc(rewardId).get();
    final reward = RewardModel.fromFirestore(rewardDoc);

    // Deduct points
    await deductPoints(
      userId: userId,
      points: reward.pointsCost,
      reason: 'Redeemed: ${reward.title}',
    );

    // Add to redeemed rewards
    await firestore
        .collection('users')
        .doc(userId)
        .collection('redeemed_rewards')
        .add({
          'rewardId': rewardId,
          'redeemedAt': FieldValue.serverTimestamp(),
          ...reward.toFirestore(),
        });
  }

  @override
  Future<List<RewardModel>> getUserRedeemedRewards(String userId) async {
    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('redeemed_rewards')
        .orderBy('redeemedAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => RewardModel.fromFirestore(doc)).toList();
  }
}
