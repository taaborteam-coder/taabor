import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/referral.dart';
import '../../domain/repositories/referral_repository.dart';

part 'referral_event.dart';
part 'referral_state.dart';

class ReferralBloc extends Bloc<ReferralEvent, ReferralState> {
  final ReferralRepository repository;

  ReferralBloc({required this.repository}) : super(ReferralInitial()) {
    on<GenerateReferralCode>(_onGenerateReferralCode);
    on<ApplyReferralCode>(_onApplyReferralCode);
    on<LoadUserReferrals>(_onLoadUserReferrals);
  }

  Future<void> _onGenerateReferralCode(
    GenerateReferralCode event,
    Emitter<ReferralState> emit,
  ) async {
    emit(ReferralLoading());
    final result = await repository.generateReferralCode(event.userId);
    result.fold(
      (failure) => emit(ReferralError(failure.message)),
      (code) => emit(ReferralCodeGenerated(code)),
    );
  }

  Future<void> _onApplyReferralCode(
    ApplyReferralCode event,
    Emitter<ReferralState> emit,
  ) async {
    emit(ReferralLoading());
    final result = await repository.applyReferralCode(event.userId, event.code);
    result.fold(
      (failure) => emit(ReferralError(failure.message)),
      (_) => emit(ReferralApplied()),
    );
  }

  Future<void> _onLoadUserReferrals(
    LoadUserReferrals event,
    Emitter<ReferralState> emit,
  ) async {
    emit(ReferralLoading());
    final referralsResult = await repository.getUserReferrals(event.userId);
    final pointsResult = await repository.getTotalReferralPoints(event.userId);

    referralsResult.fold((failure) => emit(ReferralError(failure.message)), (
      referrals,
    ) {
      pointsResult.fold(
        (failure) => emit(ReferralError(failure.message)),
        (points) => emit(ReferralsLoaded(referrals, points)),
      );
    });
  }
}
