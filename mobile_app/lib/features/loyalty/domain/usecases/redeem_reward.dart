import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/loyalty_repository.dart';

class RedeemReward {
  final LoyaltyRepository repository;

  RedeemReward(this.repository);

  Future<Either<Failure, void>> call({
    required String userId,
    required String rewardId,
  }) async {
    // Check if user can redeem
    final canRedeem = await repository.canRedeemReward(
      userId: userId,
      rewardId: rewardId,
    );

    return canRedeem.fold((failure) => Left(failure), (can) {
      if (!can) {
        return Future.value(Left(ValidationFailure('Insufficient points')));
      }
      return repository.redeemReward(userId: userId, rewardId: rewardId);
    });
  }
}
