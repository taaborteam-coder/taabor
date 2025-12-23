part of 'loyalty_bloc.dart';

abstract class LoyaltyEvent extends Equatable {
  const LoyaltyEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserPoints extends LoyaltyEvent {
  final String userId;

  const LoadUserPoints(this.userId);

  @override
  List<Object?> get props => [userId];
}

class LoadAvailableRewards extends LoyaltyEvent {
  final String? businessId;

  const LoadAvailableRewards({this.businessId});

  @override
  List<Object?> get props => [businessId];
}

class RedeemRewardEvent extends LoyaltyEvent {
  final String userId;
  final String rewardId;

  const RedeemRewardEvent({required this.userId, required this.rewardId});

  @override
  List<Object?> get props => [userId, rewardId];
}

class LoadUserTier extends LoyaltyEvent {
  final String userId;

  const LoadUserTier(this.userId);

  @override
  List<Object?> get props => [userId];
}
