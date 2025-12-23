import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/loyalty_point.dart';
import '../../domain/entities/membership_tier.dart';
import '../../domain/entities/reward.dart';
import '../../domain/repositories/loyalty_repository.dart';
import '../datasources/loyalty_remote_data_source.dart';

class LoyaltyRepositoryImpl implements LoyaltyRepository {
  final LoyaltyRemoteDataSource remoteDataSource;

  LoyaltyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, int>> getUserPoints(String userId) async {
    try {
      final points = await remoteDataSource.getUserPoints(userId);
      return Right(points);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<LoyaltyPoint>>> getPointsHistory(
    String userId,
  ) async {
    try {
      final history = await remoteDataSource.getPointsHistory(userId);
      return Right(history);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, MembershipTierEntity>> getUserTier(
    String userId,
  ) async {
    try {
      final points = await remoteDataSource.getUserPoints(userId);
      final tier = MembershipTierEntity.getTierFromPoints(points);

      int? pointsToNext;
      if (tier == MembershipTier.bronze) {
        pointsToNext = MembershipTier.silver.minPoints - points;
      } else if (tier == MembershipTier.silver) {
        pointsToNext = MembershipTier.gold.minPoints - points;
      }

      return Right(
        MembershipTierEntity(
          tier: tier,
          currentPoints: points,
          pointsToNextTier: pointsToNext,
        ),
      );
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addPoints({
    required String userId,
    required int points,
    required String source,
    String? referenceId,
  }) async {
    try {
      await remoteDataSource.addPoints(
        userId: userId,
        points: points,
        source: source,
        referenceId: referenceId,
      );
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deductPoints({
    required String userId,
    required int points,
    required String reason,
  }) async {
    try {
      await remoteDataSource.deductPoints(
        userId: userId,
        points: points,
        reason: reason,
      );
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Reward>>> getAvailableRewards({
    String? businessId,
  }) async {
    try {
      final rewards = await remoteDataSource.getAvailableRewards(
        businessId: businessId,
      );
      return Right(rewards);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> redeemReward({
    required String userId,
    required String rewardId,
  }) async {
    try {
      await remoteDataSource.redeemReward(userId: userId, rewardId: rewardId);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Reward>>> getUserRedeemedRewards(
    String userId,
  ) async {
    try {
      final rewards = await remoteDataSource.getUserRedeemedRewards(userId);
      return Right(rewards);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> canRedeemReward({
    required String userId,
    required String rewardId,
  }) async {
    try {
      final userPoints = await remoteDataSource.getUserPoints(userId);
      final rewards = await remoteDataSource.getAvailableRewards();
      final reward = rewards.firstWhere((r) => r.id == rewardId);

      return Right(userPoints >= reward.pointsCost);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
