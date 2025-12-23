import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/membership_tier.dart';
import '../../domain/entities/reward.dart';
import '../../domain/usecases/get_user_points.dart';
import '../../domain/usecases/get_available_rewards.dart';
import '../../domain/usecases/redeem_reward.dart';
import '../../domain/repositories/loyalty_repository.dart';

part 'loyalty_event.dart';
part 'loyalty_state.dart';

class LoyaltyBloc extends Bloc<LoyaltyEvent, LoyaltyState> {
  final GetUserPoints getUserPoints;
  final GetAvailableRewards getAvailableRewards;
  final RedeemReward redeemReward;
  final LoyaltyRepository repository;

  LoyaltyBloc({
    required this.getUserPoints,
    required this.getAvailableRewards,
    required this.redeemReward,
    required this.repository,
  }) : super(LoyaltyInitial()) {
    on<LoadUserPoints>(_onLoadUserPoints);
    on<LoadAvailableRewards>(_onLoadAvailableRewards);
    on<RedeemRewardEvent>(_onRedeemReward);
    on<LoadUserTier>(_onLoadUserTier);
  }

  Future<void> _onLoadUserPoints(
    LoadUserPoints event,
    Emitter<LoyaltyState> emit,
  ) async {
    emit(LoyaltyLoading());

    final result = await getUserPoints(event.userId);

    result.fold(
      (failure) => emit(LoyaltyError(failure.message)),
      (points) => emit(PointsLoaded(points)),
    );
  }

  Future<void> _onLoadAvailableRewards(
    LoadAvailableRewards event,
    Emitter<LoyaltyState> emit,
  ) async {
    emit(LoyaltyLoading());

    final result = await getAvailableRewards(businessId: event.businessId);

    result.fold(
      (failure) => emit(LoyaltyError(failure.message)),
      (rewards) => emit(RewardsLoaded(rewards)),
    );
  }

  Future<void> _onRedeemReward(
    RedeemRewardEvent event,
    Emitter<LoyaltyState> emit,
  ) async {
    emit(LoyaltyLoading());

    final result = await redeemReward(
      userId: event.userId,
      rewardId: event.rewardId,
    );

    result.fold(
      (failure) => emit(LoyaltyError(failure.message)),
      (_) => emit(RewardRedeemed()),
    );
  }

  Future<void> _onLoadUserTier(
    LoadUserTier event,
    Emitter<LoyaltyState> emit,
  ) async {
    final result = await repository.getUserTier(event.userId);

    result.fold((failure) => emit(LoyaltyError(failure.message)), (tier) {
      if (state is PointsLoaded) {
        emit(TierLoaded(tier));
      }
    });
  }
}
