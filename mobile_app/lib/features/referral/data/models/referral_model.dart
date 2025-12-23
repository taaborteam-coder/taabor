import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/referral.dart';

class ReferralModel extends ReferralEntity {
  const ReferralModel({
    required super.id,
    required super.referrerId,
    required super.referredUserId,
    required super.referralCode,
    required super.createdAt,
    super.isRewardClaimed,
    super.rewardPoints,
  });

  factory ReferralModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ReferralModel(
      id: doc.id,
      referrerId: data['referrerId'],
      referredUserId: data['referredUserId'],
      referralCode: data['referralCode'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      isRewardClaimed: data['isRewardClaimed'] ?? false,
      rewardPoints: data['rewardPoints'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'referrerId': referrerId,
      'referredUserId': referredUserId,
      'referralCode': referralCode,
      'createdAt': Timestamp.fromDate(createdAt),
      'isRewardClaimed': isRewardClaimed,
      'rewardPoints': rewardPoints,
    };
  }
}
