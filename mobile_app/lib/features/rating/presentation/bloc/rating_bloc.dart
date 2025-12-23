import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/rating_repository.dart';
import '../../domain/usecases/add_rating.dart';
import '../../domain/usecases/add_review.dart';
import '../../domain/usecases/get_business_reviews.dart';
import '../../domain/usecases/get_average_rating.dart';

part 'rating_event.dart';
part 'rating_state.dart';

/// BLoC for managing ratings and reviews
class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final AddRating addRating;
  final AddReview addReview;
  final GetBusinessReviews getBusinessReviews;
  final GetAverageRating getAverageRating;

  RatingBloc({
    required this.addRating,
    required this.addReview,
    required this.getBusinessReviews,
    required this.getAverageRating,
  }) : super(RatingInitial()) {
    on<LoadBusinessReviews>(_onLoadBusinessReviews);
    on<LoadAverageRating>(_onLoadAverageRating);
    on<AddRatingEvent>(_onAddRating);
    on<AddReviewEvent>(_onAddReview);
    on<ChangeSortOrder>(_onChangeSortOrder);
  }

  Future<void> _onLoadBusinessReviews(
    LoadBusinessReviews event,
    Emitter<RatingState> emit,
  ) async {
    emit(RatingLoading());

    final result = await getBusinessReviews(
      event.businessId,
      sortOrder: event.sortOrder,
    );

    result.fold(
      (failure) => emit(RatingError(failure.message)),
      (reviews) => emit(ReviewsLoaded(reviews, event.sortOrder)),
    );
  }

  Future<void> _onLoadAverageRating(
    LoadAverageRating event,
    Emitter<RatingState> emit,
  ) async {
    final result = await getAverageRating(event.businessId);

    result.fold((_) => null, (avg) {
      if (state is ReviewsLoaded) {
        final currentState = state as ReviewsLoaded;
        emit(currentState.copyWith(averageRating: avg));
      }
    });
  }

  Future<void> _onAddRating(
    AddRatingEvent event,
    Emitter<RatingState> emit,
  ) async {
    emit(RatingSubmitting());

    final result = await addRating(
      businessId: event.businessId,
      userId: event.userId,
      userName: event.userName,
      rating: event.rating,
    );

    result.fold(
      (failure) => emit(RatingError(failure.message)),
      (_) => emit(RatingSubmitted()),
    );
  }

  Future<void> _onAddReview(
    AddReviewEvent event,
    Emitter<RatingState> emit,
  ) async {
    emit(RatingSubmitting());

    final result = await addReview(
      businessId: event.businessId,
      userId: event.userId,
      userName: event.userName,
      rating: event.rating,
      comment: event.comment,
      imageUrls: event.imageUrls,
    );

    result.fold(
      (failure) => emit(RatingError(failure.message)),
      (_) => emit(ReviewSubmitted()),
    );
  }

  Future<void> _onChangeSortOrder(
    ChangeSortOrder event,
    Emitter<RatingState> emit,
  ) async {
    if (state is ReviewsLoaded) {
      final currentState = state as ReviewsLoaded;
      add(
        LoadBusinessReviews(
          currentState.reviews.first.businessId,
          event.sortOrder,
        ),
      );
    }
  }
}
