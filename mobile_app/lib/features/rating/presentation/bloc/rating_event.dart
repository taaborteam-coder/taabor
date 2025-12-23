part of 'rating_bloc.dart';

abstract class RatingEvent extends Equatable {
  const RatingEvent();

  @override
  List<Object?> get props => [];
}

class LoadBusinessReviews extends RatingEvent {
  final String businessId;
  final ReviewSortOrder sortOrder;

  const LoadBusinessReviews(
    this.businessId, [
    this.sortOrder = ReviewSortOrder.newest,
  ]);

  @override
  List<Object?> get props => [businessId, sortOrder];
}

class LoadAverageRating extends RatingEvent {
  final String businessId;

  const LoadAverageRating(this.businessId);

  @override
  List<Object?> get props => [businessId];
}

class AddRatingEvent extends RatingEvent {
  final String businessId;
  final String userId;
  final String userName;
  final int rating;

  const AddRatingEvent({
    required this.businessId,
    required this.userId,
    required this.userName,
    required this.rating,
  });

  @override
  List<Object?> get props => [businessId, userId, userName, rating];
}

class AddReviewEvent extends RatingEvent {
  final String businessId;
  final String userId;
  final String userName;
  final int rating;
  final String comment;
  final List<String>? imageUrls;

  const AddReviewEvent({
    required this.businessId,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
    this.imageUrls,
  });

  @override
  List<Object?> get props => [
    businessId,
    userId,
    userName,
    rating,
    comment,
    imageUrls,
  ];
}

class ChangeSortOrder extends RatingEvent {
  final ReviewSortOrder sortOrder;

  const ChangeSortOrder(this.sortOrder);

  @override
  List<Object?> get props => [sortOrder];
}
