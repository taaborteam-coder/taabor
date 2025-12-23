import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/rating_repository.dart';

/// Use case for getting average rating
class GetAverageRating {
  final RatingRepository repository;

  GetAverageRating(this.repository);

  Future<Either<Failure, double>> call(String businessId) {
    return repository.getAverageRating(businessId);
  }
}
