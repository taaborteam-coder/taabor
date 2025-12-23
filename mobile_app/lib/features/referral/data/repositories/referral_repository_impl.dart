import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/referral.dart';
import '../../domain/repositories/referral_repository.dart';
import '../datasources/referral_remote_data_source.dart';

class ReferralRepositoryImpl implements ReferralRepository {
  final ReferralRemoteDataSource remoteDataSource;

  ReferralRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> generateReferralCode(String userId) async {
    try {
      final result = await remoteDataSource.generateReferralCode(userId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> applyReferralCode(
    String userId,
    String referralCode,
  ) async {
    try {
      await remoteDataSource.applyReferralCode(userId, referralCode);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ReferralEntity>>> getUserReferrals(
    String userId,
  ) async {
    try {
      final result = await remoteDataSource.getUserReferrals(userId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, int>> getTotalReferralPoints(String userId) async {
    try {
      final result = await remoteDataSource.getTotalReferralPoints(userId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
