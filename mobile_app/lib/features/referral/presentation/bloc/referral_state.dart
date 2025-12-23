part of 'referral_bloc.dart';

abstract class ReferralState extends Equatable {
  const ReferralState();

  @override
  List<Object?> get props => [];
}

class ReferralInitial extends ReferralState {}

class ReferralLoading extends ReferralState {}

class ReferralCodeGenerated extends ReferralState {
  final String code;

  const ReferralCodeGenerated(this.code);

  @override
  List<Object?> get props => [code];
}

class ReferralApplied extends ReferralState {}

class ReferralsLoaded extends ReferralState {
  final List<ReferralEntity> referrals;
  final int totalPoints;

  const ReferralsLoaded(this.referrals, this.totalPoints);

  @override
  List<Object?> get props => [referrals, totalPoints];
}

class ReferralError extends ReferralState {
  final String message;

  const ReferralError(this.message);

  @override
  List<Object?> get props => [message];
}
