import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/referral_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class ReferralRemoteDataSource {
  Future<String> generateReferralCode(String userId);
  Future<void> applyReferralCode(String userId, String referralCode);
  Future<List<ReferralModel>> getUserReferrals(String userId);
  Future<int> getTotalReferralPoints(String userId);
}

class ReferralRemoteDataSourceImpl implements ReferralRemoteDataSource {
  final FirebaseFirestore firestore;

  ReferralRemoteDataSourceImpl({required this.firestore});

  @override
  Future<String> generateReferralCode(String userId) async {
    // Determine if user already has a code
    final userDoc = await firestore.collection('users').doc(userId).get();
    if (userDoc.exists && userDoc.data()?['referralCode'] != null) {
      return userDoc.data()!['referralCode'];
    }

    // Generate new code
    // Logic: First 4 chars of name + random string
    final code =
        '${userId.substring(0, 4)}-${const Uuid().v4().substring(0, 4)}'
            .toUpperCase();

    await firestore.collection('users').doc(userId).update({
      'referralCode': code,
    });

    return code;
  }

  @override
  Future<void> applyReferralCode(String userId, String referralCode) async {
    // 1. Validate code exists
    final snapshot = await firestore
        .collection('users')
        .where('referralCode', isEqualTo: referralCode)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      throw ServerException(); // Code invalid
    }

    final referrerId = snapshot.docs.first.id;

    if (referrerId == userId) {
      throw ServerException(); // Cannot refer self
    }

    // 2. Create referral record
    final referral = ReferralModel(
      id: const Uuid().v4(),
      referrerId: referrerId,
      referredUserId: userId,
      referralCode: referralCode,
      createdAt: DateTime.now(),
      rewardPoints: 50, // Default reward points
      isRewardClaimed: false,
    );

    await firestore
        .collection('referrals')
        .doc(referral.id)
        .set(referral.toFirestore());

    // 3. Mark usage for user to prevent double usage (optional implementation detail)
  }

  @override
  Future<List<ReferralModel>> getUserReferrals(String userId) async {
    final snapshot = await firestore
        .collection('referrals')
        .where('referrerId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => ReferralModel.fromFirestore(doc))
        .toList();
  }

  @override
  Future<int> getTotalReferralPoints(String userId) async {
    final snapshot = await firestore
        .collection('referrals')
        .where('referrerId', isEqualTo: userId)
        .get();

    int total = 0;
    for (var doc in snapshot.docs) {
      final data = doc.data();
      total += (data['rewardPoints'] as num).toInt();
    }
    return total;
  }
}
