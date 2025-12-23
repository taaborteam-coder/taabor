import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/service.dart';
import '../repositories/business_repository.dart';

class GetBusinessServices {
  final BusinessRepository repository;

  GetBusinessServices(this.repository);

  Future<Either<Failure, List<Service>>> call(String businessId) async {
    return await repository.getServicesForBusiness(businessId);
  }
}
