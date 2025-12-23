part of 'rating_bloc.dart';

abstract class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object?> get props => [];
}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class ReviewsLoaded extends RatingState {
  final List<ReviewEntity> reviews;
  final ReviewSortOrder sortOrder;
  final double? averageRating;

  const ReviewsLoaded(this.reviews, this.sortOrder, {this.averageRating});

  @override
  List<Object?> get props => [reviews, sortOrder, averageRating];

  ReviewsLoaded copyWith({
    List<ReviewEntity>? reviews,
    ReviewSortOrder? sortOrder,
    double? averageRating,
  }) {
    return ReviewsLoaded(
      reviews ?? this.reviews,
      sortOrder ?? this.sortOrder,
      averageRating: averageRating ?? this.averageRating,
    );
  }
}

class RatingSubmitting extends RatingState {}

class RatingSubmitted extends RatingState {}

class ReviewSubmitted extends RatingState {}

class RatingError extends RatingState {
  final String message;

  const RatingError(this.message);

  @override
  List<Object?> get props => [message];
}
