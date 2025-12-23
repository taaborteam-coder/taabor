import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/rating.dart';
import '../entities/review.dart';

/// Repository interface for ratings and reviews
abstract class RatingRepository {
  /// Add a rating for a business
  Future<Either<Failure, void>> addRating({
    required String businessId,
    required String userId,
    required String userName,
    required int rating,
  });

  /// Get ratings for a business
  Future<Either<Failure, List<RatingEntity>>> getBusinessRatings(
    String businessId,
  );

  /// Get average rating for a business
  Future<Either<Failure, double>> getAverageRating(String businessId);

  /// Add a review for a business
  Future<Either<Failure, void>> addReview({
    required String businessId,
    required String userId,
    required String userName,
    String? userPhotoUrl,
    required int rating,
    required String comment,
    List<String>? imageUrls,
    String? serviceId,
    String? serviceName,
  });

  /// Get reviews for a business
  Future<Either<Failure, List<ReviewEntity>>> getBusinessReviews(
    String businessId, {
    ReviewSortOrder sortOrder = ReviewSortOrder.newest,
    int? limit,
  });

  /// Get user's review for a business
  Future<Either<Failure, ReviewEntity?>> getUserReview(
    String businessId,
    String userId,
  );

  /// Update a review
  Future<Either<Failure, void>> updateReview({
    required String reviewId,
    required int rating,
    required String comment,
    List<String>? imageUrls,
  });

  /// Delete a review
  Future<Either<Failure, void>> deleteReview(String reviewId);

  /// Add merchant reply to a review
  Future<Either<Failure, void>> addMerchantReply({
    required String reviewId,
    required String merchantReply,
  });

  /// Mark review as helpful
  Future<Either<Failure, void>> markAsHelpful(String reviewId, String userId);

  /// Mark review as not helpful
  Future<Either<Failure, void>> markAsNotHelpful(
    String reviewId,
    String userId,
  );

  /// Stream reviews for real-time updates
  Stream<List<ReviewEntity>> streamBusinessReviews(String businessId);
}

/// Enum for review sort order
enum ReviewSortOrder { newest, oldest, highestRated, lowestRated, mostHelpful }
