import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../domain/repositories/rating_repository.dart';
import '../bloc/rating_bloc.dart';
import '../widgets/review_card.dart';

class ReviewsPage extends StatelessWidget {
  final String businessId;
  final String businessName;

  const ReviewsPage({
    super.key,
    required this.businessId,
    required this.businessName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RatingBloc>()
        ..add(LoadBusinessReviews(businessId))
        ..add(LoadAverageRating(businessId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المراجعات'),
          actions: [
            PopupMenuButton<ReviewSortOrder>(
              onSelected: (order) {
                context.read<RatingBloc>().add(ChangeSortOrder(order));
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: ReviewSortOrder.newest,
                  child: Text('الأحدث'),
                ),
                const PopupMenuItem(
                  value: ReviewSortOrder.oldest,
                  child: Text('الأقدم'),
                ),
                const PopupMenuItem(
                  value: ReviewSortOrder.highestRated,
                  child: Text('الأعلى تقييماً'),
                ),
                const PopupMenuItem(
                  value: ReviewSortOrder.lowestRated,
                  child: Text('الأدنى تقييماً'),
                ),
                const PopupMenuItem(
                  value: ReviewSortOrder.mostHelpful,
                  child: Text('الأكثر فائدة'),
                ),
              ],
            ),
          ],
        ),
        body: BlocBuilder<RatingBloc, RatingState>(
          builder: (context, state) {
            if (state is RatingLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is RatingError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<RatingBloc>().add(
                          LoadBusinessReviews(businessId),
                        );
                      },
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            if (state is ReviewsLoaded) {
              if (state.reviews.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.rate_review_outlined,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'لا توجد مراجعات بعد',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'كن أول من يكتب مراجعة!',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<RatingBloc>().add(
                    LoadBusinessReviews(businessId),
                  );
                },
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.reviews.length,
                  separatorBuilder: (_, __) => const Divider(height: 32),
                  itemBuilder: (context, index) {
                    return ReviewCard(review: state.reviews[index]);
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Navigate to add review page
            // Navigator.pushNamed(context, '/add-review', arguments: businessId);
          },
          icon: const Icon(Icons.rate_review),
          label: const Text('إضافة مراجعة'),
        ),
      ),
    );
  }
}
