import 'package:equatable/equatable.dart';

/// Membership tier levels
enum MembershipTier { bronze, silver, gold }

extension MembershipTierExtension on MembershipTier {
  String get displayName {
    switch (this) {
      case MembershipTier.bronze:
        return 'Bronze';
      case MembershipTier.silver:
        return 'Silver';
      case MembershipTier.gold:
        return 'Gold';
    }
  }

  int get minPoints {
    switch (this) {
      case MembershipTier.bronze:
        return 0;
      case MembershipTier.silver:
        return 100;
      case MembershipTier.gold:
        return 500;
    }
  }

  double get discountPercentage {
    switch (this) {
      case MembershipTier.bronze:
        return 0.0;
      case MembershipTier.silver:
        return 5.0;
      case MembershipTier.gold:
        return 10.0;
    }
  }
}

/// Membership tier entity
class MembershipTierEntity extends Equatable {
  final MembershipTier tier;
  final int currentPoints;
  final int? pointsToNextTier;

  const MembershipTierEntity({
    required this.tier,
    required this.currentPoints,
    this.pointsToNextTier,
  });

  @override
  List<Object?> get props => [tier, currentPoints, pointsToNextTier];

  /// Get tier based on points
  static MembershipTier getTierFromPoints(int points) {
    if (points >= MembershipTier.gold.minPoints) {
      return MembershipTier.gold;
    } else if (points >= MembershipTier.silver.minPoints) {
      return MembershipTier.silver;
    } else {
      return MembershipTier.bronze;
    }
  }
}
