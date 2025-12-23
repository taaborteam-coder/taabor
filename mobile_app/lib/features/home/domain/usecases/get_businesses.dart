import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/business.dart';
import '../repositories/business_repository.dart';

class GetBusinesses {
  final BusinessRepository repository;

  GetBusinesses(this.repository);

  Future<Either<Failure, List<Business>>> call() async {
    return await repository.getBusinesses();
  }
}
