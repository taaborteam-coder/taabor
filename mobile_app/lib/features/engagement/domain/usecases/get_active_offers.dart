import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/offer.dart';
import '../repositories/offer_repository.dart';

class GetActiveOffers {
  final OfferRepository repository;

  GetActiveOffers(this.repository);

  Future<Either<Failure, List<Offer>>> call(String businessId) async {
    return await repository.getActiveOffers(businessId);
  }
}
