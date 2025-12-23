import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/rating.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/rating_repository.dart';
import '../datasources/rating_remote_data_source.dart';

/// Implementation of rating repository
class RatingRepositoryImpl implements RatingRepository {
  final RatingRemoteDataSource remoteDataSource;

  RatingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> addRating({
    required String businessId,
    required String userId,
    required String userName,
    required int rating,
  }) async {
    try {
      await remoteDataSource.addRating(
        businessId: businessId,
        userId: userId,
        userName: userName,
        rating: rating,
      );
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<RatingEntity>>> getBusinessRatings(
    String businessId,
  ) async {
    try {
      final ratings = await remoteDataSource.getBusinessRatings(businessId);
      return Right(ratings);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, double>> getAverageRating(String businessId) async {
    try {
      final avg = await remoteDataSource.getAverageRating(businessId);
      return Right(avg);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
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
  }) async {
    try {
      await remoteDataSource.addReview(
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
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ReviewEntity>>> getBusinessReviews(
    String businessId, {
    ReviewSortOrder sortOrder = ReviewSortOrder.newest,
    int? limit,
  }) async {
    try {
      final reviews = await remoteDataSource.getBusinessReviews(
        businessId,
        sortOrder: sortOrder,
        limit: limit,
      );
      return Right(reviews);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ReviewEntity?>> getUserReview(
    String businessId,
    String userId,
  ) async {
    try {
      final review = await remoteDataSource.getUserReview(businessId, userId);
      return Right(review);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateReview({
    required String reviewId,
    required int rating,
    required String comment,
    List<String>? imageUrls,
  }) async {
    try {
      await remoteDataSource.updateReview(
        reviewId: reviewId,
        rating: rating,
        comment: comment,
        imageUrls: imageUrls,
      );
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteReview(String reviewId) async {
    try {
      await remoteDataSource.deleteReview(reviewId);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addMerchantReply({
    required String reviewId,
    required String merchantReply,
  }) async {
    try {
      await remoteDataSource.addMerchantReply(
        reviewId: reviewId,
        merchantReply: merchantReply,
      );
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> markAsHelpful(
    String reviewId,
    String userId,
  ) async {
    try {
      await remoteDataSource.markAsHelpful(reviewId, userId);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> markAsNotHelpful(
    String reviewId,
    String userId,
  ) async {
    try {
      await remoteDataSource.markAsNotHelpful(reviewId, userId);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Stream<List<ReviewEntity>> streamBusinessReviews(String businessId) {
    return remoteDataSource.streamBusinessReviews(businessId);
  }
}
