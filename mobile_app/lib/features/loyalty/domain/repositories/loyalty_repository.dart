import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/loyalty_point.dart';
import '../entities/membership_tier.dart';
import '../entities/reward.dart';

/// Repository interface for loyalty system
abstract class LoyaltyRepository {
  /// Get user's total points
  Future<Either<Failure, int>> getUserPoints(String userId);

  /// Get user's points history
  Future<Either<Failure, List<LoyaltyPoint>>> getPointsHistory(String userId);

  /// Get user's membership tier
  Future<Either<Failure, MembershipTierEntity>> getUserTier(String userId);

  /// Add points to user account
  Future<Either<Failure, void>> addPoints({
    required String userId,
    required int points,
    required String source,
    String? referenceId,
  });

  /// Deduct points from user account
  Future<Either<Failure, void>> deductPoints({
    required String userId,
    required int points,
    required String reason,
  });

  /// Get available rewards
  Future<Either<Failure, List<Reward>>> getAvailableRewards({
    String? businessId,
  });

  /// Redeem a reward
  Future<Either<Failure, void>> redeemReward({
    required String userId,
    required String rewardId,
  });

  /// Get user's redeemed rewards
  Future<Either<Failure, List<Reward>>> getUserRedeemedRewards(String userId);

  /// Check if user can redeem reward
  Future<Either<Failure, bool>> canRedeemReward({
    required String userId,
    required String rewardId,
  });
}
