import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/offer.dart';

abstract class OfferRepository {
  Future<Either<Failure, List<Offer>>> getOffersByBusiness(String businessId);
  Future<Either<Failure, List<Offer>>> getActiveOffers(String businessId);
  Future<Either<Failure, void>> createOffer(Offer offer);
  Future<Either<Failure, void>> updateOffer(Offer offer);
  Future<Either<Failure, void>> deleteOffer(String offerId);
}
