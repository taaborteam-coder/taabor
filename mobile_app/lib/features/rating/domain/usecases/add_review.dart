import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/rating_repository.dart';

/// Use case for adding a review
class AddReview {
  final RatingRepository repository;

  AddReview(this.repository);

  Future<Either<Failure, void>> call({
    required String businessId,
    required String userId,
    required String userName,
    String? userPhotoUrl,
    required int rating,
    required String comment,
    List<String>? imageUrls,
    String? serviceId,
    String? serviceName,
  }) {
    // Validation
    if (rating < 1 || rating > 5) {
      return Future.value(
        Left(ValidationFailure('Rating must be between 1 and 5')),
      );
    }

    if (comment.trim().isEmpty) {
      return Future.value(Left(ValidationFailure('Comment cannot be empty')));
    }

    if (comment.length > 500) {
      return Future.value(
        Left(ValidationFailure('Comment must be less than 500 characters')),
      );
    }

    return repository.addReview(
      businessId: businessId,
      userId: userId,
      userName: userName,
      userPhotoUrl: userPhotoUrl,
      rating: rating,
      comment: comment,
      imageUrls: imageUrls,
      serviceId: serviceId,
      serviceName: serviceName,
    );
  }
}
