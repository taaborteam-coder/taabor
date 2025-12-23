import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/business.dart';
import '../../domain/entities/service.dart';
import '../../domain/repositories/business_repository.dart';
import '../datasources/business_remote_data_source.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  final BusinessRemoteDataSource remoteDataSource;

  BusinessRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Business>>> getBusinesses() async {
    try {
      final businesses = await remoteDataSource.getBusinesses();
      return Right(businesses);
    } on ServerException {
      return Left(ServerFailure('Failed to fetch businesses'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, Business>> getBusinessById(String id) async {
    try {
      final business = await remoteDataSource.getBusinessById(id);
      return Right(business);
    } on ServerException {
      return Left(ServerFailure('Failed to fetch business'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, List<Service>>> getServicesForBusiness(
    String businessId,
  ) async {
    try {
      final services = await remoteDataSource.getServicesForBusiness(
        businessId,
      );
      return Right(services);
    } on ServerException {
      return Left(ServerFailure('Failed to fetch services'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, void>> updateBusinessStatus(
    String businessId,
    bool isOpen,
  ) async {
    try {
      await remoteDataSource.updateBusinessStatus(businessId, isOpen);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure('Failed to update business status'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error'));
    }
  }
}
