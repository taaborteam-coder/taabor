part of 'loyalty_bloc.dart';

abstract class LoyaltyState extends Equatable {
  const LoyaltyState();

  @override
  List<Object?> get props => [];
}

class LoyaltyInitial extends LoyaltyState {}

class LoyaltyLoading extends LoyaltyState {}

class PointsLoaded extends LoyaltyState {
  final int points;

  const PointsLoaded(this.points);

  @override
  List<Object?> get props => [points];
}

class RewardsLoaded extends LoyaltyState {
  final List<Reward> rewards;

  const RewardsLoaded(this.rewards);

  @override
  List<Object?> get props => [rewards];
}

class TierLoaded extends LoyaltyState {
  final MembershipTierEntity tier;

  const TierLoaded(this.tier);

  @override
  List<Object?> get props => [tier];
}

class RewardRedeemed extends LoyaltyState {}

class LoyaltyError extends LoyaltyState {
  final String message;

  const LoyaltyError(this.message);

  @override
  List<Object?> get props => [message];
}
