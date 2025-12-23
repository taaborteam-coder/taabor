import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../bloc/loyalty_bloc.dart';
import '../widgets/points_card.dart';
import '../widgets/tier_card.dart';

class LoyaltyPage extends StatelessWidget {
  final String userId;

  const LoyaltyPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoyaltyBloc>()
        ..add(LoadUserPoints(userId))
        ..add(LoadUserTier(userId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('نقاط الولاء')),
        body: BlocBuilder<LoyaltyBloc, LoyaltyState>(
          builder: (context, state) {
            if (state is LoyaltyLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is LoyaltyError) {
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
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<LoyaltyBloc>()
                  ..add(LoadUserPoints(userId))
                  ..add(LoadUserTier(userId));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Points card
                    if (state is PointsLoaded) PointsCard(points: state.points),

                    const SizedBox(height: 16),

                    // Tier card
                    if (state is TierLoaded) TierCard(tier: state.tier),

                    const SizedBox(height: 24),

                    // Rewards section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'المكافآت المتاحة',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to all rewards
                          },
                          child: const Text('عرض الكل'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Rewards button
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.card_giftcard, size: 32),
                        title: const Text('استكشف المكافآت'),
                        subtitle: const Text('استبدل نقاطك بمكافآت رائعة'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          context.read<LoyaltyBloc>().add(
                            const LoadAvailableRewards(),
                          );
                          // Navigate to rewards page
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // How to earn section
                    const Text(
                      'كيفية كسب النقاط',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildHowToEarnCard(
                      icon: Icons.event_available,
                      title: 'احجز موعد',
                      points: '+10 نقاط',
                    ),
                    _buildHowToEarnCard(
                      icon: Icons.share,
                      title: 'ادع صديق',
                      points: '+50 نقاط',
                    ),
                    _buildHowToEarnCard(
                      icon: Icons.rate_review,
                      title: 'اكتب مراجعة',
                      points: '+5 نقاط',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHowToEarnCard({
    required IconData icon,
    required String title,
    required String points,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        trailing: Text(
          points,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
