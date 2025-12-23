import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/rating_repository.dart';
import '../models/rating_model.dart';
import '../models/review_model.dart';

/// Remote data source for ratings and reviews
abstract class RatingRemoteDataSource {
  Future<void> addRating({
    required String businessId,
    required String userId,
    required String userName,
    required int rating,
  });

  Future<List<RatingModel>> getBusinessRatings(String businessId);

  Future<double> getAverageRating(String businessId);

  Future<void> addReview({
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

  Future<List<ReviewModel>> getBusinessReviews(
    String businessId, {
    ReviewSortOrder sortOrder = ReviewSortOrder.newest,
    int? limit,
  });

  Future<ReviewModel?> getUserReview(String businessId, String userId);

  Future<void> updateReview({
    required String reviewId,
    required int rating,
    required String comment,
    List<String>? imageUrls,
  });

  Future<void> deleteReview(String reviewId);

  Future<void> addMerchantReply({
    required String reviewId,
    required String merchantReply,
  });

  Future<void> markAsHelpful(String reviewId, String userId);

  Future<void> markAsNotHelpful(String reviewId, String userId);

  Stream<List<ReviewModel>> streamBusinessReviews(String businessId);
}

/// Implementation of rating remote data source
class RatingRemoteDataSourceImpl implements RatingRemoteDataSource {
  final FirebaseFirestore firestore;

  RatingRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> addRating({
    required String businessId,
    required String userId,
    required String userName,
    required int rating,
  }) async {
    final ratingData = RatingModel(
      id: '',
      businessId: businessId,
      userId: userId,
      userName: userName,
      rating: rating,
      createdAt: DateTime.now(),
    );

    // Add or update rating
    await firestore
        .collection('businesses')
        .doc(businessId)
        .collection('ratings')
        .doc(userId)
        .set(ratingData.toFirestore());

    // Update business average rating
    await _updateBusinessAverageRating(businessId);
  }

  @override
  Future<List<RatingModel>> getBusinessRatings(String businessId) async {
    final snapshot = await firestore
        .collection('businesses')
        .doc(businessId)
        .collection('ratings')
        .get();

    return snapshot.docs.map((doc) => RatingModel.fromFirestore(doc)).toList();
  }

  @override
  Future<double> getAverageRating(String businessId) async {
    final ratings = await getBusinessRatings(businessId);
    if (ratings.isEmpty) return 0.0;

    final sum = ratings.fold<int>(0, (prev, rating) => prev + rating.rating);
    return sum / ratings.length;
  }

  @override
  Future<void> addReview({
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
    final reviewRef = firestore.collection('reviews').doc();

    final reviewData = ReviewModel(
      id: reviewRef.id,
      businessId: businessId,
      userId: userId,
      userName: userName,
      userPhotoUrl: userPhotoUrl,
      rating: rating,
      comment: comment,
      imageUrls: imageUrls ?? [],
      createdAt: DateTime.now(),
      serviceId: serviceId,
      serviceName: serviceName,
    );

    await reviewRef.set(reviewData.toFirestore());

    // Also add/update rating
    await addRating(
      businessId: businessId,
      userId: userId,
      userName: userName,
      rating: rating,
    );
  }

  @override
  Future<List<ReviewModel>> getBusinessReviews(
    String businessId, {
    ReviewSortOrder sortOrder = ReviewSortOrder.newest,
    int? limit,
  }) async {
    Query query = firestore
        .collection('reviews')
        .where('businessId', isEqualTo: businessId);

    // Apply sorting
    switch (sortOrder) {
      case ReviewSortOrder.newest:
        query = query.orderBy('createdAt', descending: true);
        break;
      case ReviewSortOrder.oldest:
        query = query.orderBy('createdAt', descending: false);
        break;
      case ReviewSortOrder.highestRated:
        query = query.orderBy('rating', descending: true);
        break;
      case ReviewSortOrder.lowestRated:
        query = query.orderBy('rating', descending: false);
        break;
      case ReviewSortOrder.mostHelpful:
        query = query.orderBy('helpfulCount', descending: true);
        break;
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => ReviewModel.fromFirestore(doc)).toList();
  }

  @override
  Future<ReviewModel?> getUserReview(String businessId, String userId) async {
    final snapshot = await firestore
        .collection('reviews')
        .where('businessId', isEqualTo: businessId)
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;
    return ReviewModel.fromFirestore(snapshot.docs.first);
  }

  @override
  Future<void> updateReview({
    required String reviewId,
    required int rating,
    required String comment,
    List<String>? imageUrls,
  }) async {
    await firestore.collection('reviews').doc(reviewId).update({
      'rating': rating,
      'comment': comment,
      'imageUrls': imageUrls ?? [],
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> deleteReview(String reviewId) async {
    await firestore.collection('reviews').doc(reviewId).delete();
  }

  @override
  Future<void> addMerchantReply({
    required String reviewId,
    required String merchantReply,
  }) async {
    await firestore.collection('reviews').doc(reviewId).update({
      'merchantReply': merchantReply,
      'merchantReplyDate': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> markAsHelpful(String reviewId, String userId) async {
    final reviewRef = firestore.collection('reviews').doc(reviewId);

    // Add user to helpful list
    await firestore
        .collection('reviews')
        .doc(reviewId)
        .collection('helpful')
        .doc(userId)
        .set({'timestamp': FieldValue.serverTimestamp()});

    // Increment helpful count
    await reviewRef.update({'helpfulCount': FieldValue.increment(1)});
  }

  @override
  Future<void> markAsNotHelpful(String reviewId, String userId) async {
    final reviewRef = firestore.collection('reviews').doc(reviewId);

    // Add user to not helpful list
    await firestore
        .collection('reviews')
        .doc(reviewId)
        .collection('notHelpful')
        .doc(userId)
        .set({'timestamp': FieldValue.serverTimestamp()});

    // Increment not helpful count
    await reviewRef.update({'notHelpfulCount': FieldValue.increment(1)});
  }

  @override
  Stream<List<ReviewModel>> streamBusinessReviews(String businessId) {
    return firestore
        .collection('reviews')
        .where('businessId', isEqualTo: businessId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ReviewModel.fromFirestore(doc))
              .toList(),
        );
  }

  /// Helper method to update business average rating
  Future<void> _updateBusinessAverageRating(String businessId) async {
    final avgRating = await getAverageRating(businessId);
    final ratings = await getBusinessRatings(businessId);

    await firestore.collection('businesses').doc(businessId).update({
      'averageRating': avgRating,
      'totalRatings': ratings.length,
    });
  }
}
