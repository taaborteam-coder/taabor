import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/rating_repository.dart';

/// Use case for adding a rating
class AddRating {
  final RatingRepository repository;

  AddRating(this.repository);

  Future<Either<Failure, void>> call({
    required String businessId,
    required String userId,
    required String userName,
    required int rating,
  }) {
    if (rating < 1 || rating > 5) {
      return Future.value(
        Left(ValidationFailure('Rating must be between 1 and 5')),
      );
    }

    return repository.addRating(
      businessId: businessId,
      userId: userId,
      userName: userName,
      rating: rating,
    );
  }
}
