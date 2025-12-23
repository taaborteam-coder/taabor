import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/loyalty_repository.dart';

class GetUserPoints {
  final LoyaltyRepository repository;

  GetUserPoints(this.repository);

  Future<Either<Failure, int>> call(String userId) {
    return repository.getUserPoints(userId);
  }
}
