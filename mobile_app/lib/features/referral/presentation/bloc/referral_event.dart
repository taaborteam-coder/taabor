part of 'referral_bloc.dart';

abstract class ReferralEvent extends Equatable {
  const ReferralEvent();

  @override
  List<Object?> get props => [];
}

class GenerateReferralCode extends ReferralEvent {
  final String userId;

  const GenerateReferralCode(this.userId);

  @override
  List<Object?> get props => [userId];
}

class ApplyReferralCode extends ReferralEvent {
  final String userId;
  final String code;

  const ApplyReferralCode({required this.userId, required this.code});

  @override
  List<Object?> get props => [userId, code];
}

class LoadUserReferrals extends ReferralEvent {
  final String userId;

  const LoadUserReferrals(this.userId);

  @override
  List<Object?> get props => [userId];
}
