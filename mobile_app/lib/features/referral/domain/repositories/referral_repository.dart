import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/referral.dart';

abstract class ReferralRepository {
  Future<Either<Failure, String>> generateReferralCode(String userId);

  Future<Either<Failure, void>> applyReferralCode(
    String userId,
    String referralCode,
  );

  Future<Either<Failure, List<ReferralEntity>>> getUserReferrals(String userId);

  Future<Either<Failure, int>> getTotalReferralPoints(String userId);
}
