import 'package:equatable/equatable.dart';

class ReferralEntity extends Equatable {
  final String id;
  final String referrerId;
  final String referredUserId;
  final String referralCode;
  final DateTime createdAt;
  final bool isRewardClaimed;
  final int rewardPoints;

  const ReferralEntity({
    required this.id,
    required this.referrerId,
    required this.referredUserId,
    required this.referralCode,
    required this.createdAt,
    this.isRewardClaimed = false,
    this.rewardPoints = 0,
  });

  @override
  List<Object?> get props => [
    id,
    referrerId,
    referredUserId,
    referralCode,
    createdAt,
    isRewardClaimed,
    rewardPoints,
  ];
}
