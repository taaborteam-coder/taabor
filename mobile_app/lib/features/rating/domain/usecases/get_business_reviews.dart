import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/review.dart';
import '../repositories/rating_repository.dart';

/// Use case for getting business reviews
class GetBusinessReviews {
  final RatingRepository repository;

  GetBusinessReviews(this.repository);

  Future<Either<Failure, List<ReviewEntity>>> call(
    String businessId, {
    ReviewSortOrder sortOrder = ReviewSortOrder.newest,
    int? limit,
  }) {
    return repository.getBusinessReviews(
      businessId,
      sortOrder: sortOrder,
      limit: limit,
    );
  }
}
