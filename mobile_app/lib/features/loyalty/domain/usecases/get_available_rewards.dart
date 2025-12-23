import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/reward.dart';
import '../repositories/loyalty_repository.dart';

class GetAvailableRewards {
  final LoyaltyRepository repository;

  GetAvailableRewards(this.repository);

  Future<Either<Failure, List<Reward>>> call({String? businessId}) {
    return repository.getAvailableRewards(businessId: businessId);
  }
}
