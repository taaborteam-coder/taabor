import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/business.dart';
import '../entities/service.dart';

abstract class BusinessRepository {
  Future<Either<Failure, List<Business>>> getBusinesses();
  Future<Either<Failure, Business>> getBusinessById(String id);
  Future<Either<Failure, List<Service>>> getServicesForBusiness(
    String businessId,
  );
  Future<Either<Failure, void>> updateBusinessStatus(
    String businessId,
    bool isOpen,
  );
}
