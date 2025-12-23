import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/offer.dart';
import '../../domain/repositories/offer_repository.dart';
import '../datasources/offer_remote_data_source.dart';
import '../models/offer.dart';

class OfferRepositoryImpl implements OfferRepository {
  final OfferRemoteDataSource remoteDataSource;

  OfferRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Offer>>> getOffersByBusiness(
    String businessId,
  ) async {
    try {
      final offers = await remoteDataSource.getOffersByBusiness(businessId);
      return Right(offers);
    } on ServerException {
      return Left(ServerFailure('Failed to fetch offers'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, List<Offer>>> getActiveOffers(
    String businessId,
  ) async {
    try {
      final offers = await remoteDataSource.getActiveOffers(businessId);
      return Right(offers);
    } on ServerException {
      return Left(ServerFailure('Failed to fetch active offers'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, void>> createOffer(Offer offer) async {
    try {
      final offerModel = OfferModel(
        id: offer.id,
        businessId: offer.businessId,
        title: offer.title,
        description: offer.description,
        discountType: offer.discountType,
        discountValue: offer.discountValue,
        validFrom: offer.validFrom,
        validTo: offer.validTo,
        isActive: offer.isActive,
      );
      await remoteDataSource.createOffer(offerModel);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure('Failed to create offer'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, void>> updateOffer(Offer offer) async {
    try {
      final offerModel = OfferModel(
        id: offer.id,
        businessId: offer.businessId,
        title: offer.title,
        description: offer.description,
        discountType: offer.discountType,
        discountValue: offer.discountValue,
        validFrom: offer.validFrom,
        validTo: offer.validTo,
        isActive: offer.isActive,
      );
      await remoteDataSource.updateOffer(offerModel);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure('Failed to update offer'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteOffer(String offerId) async {
    try {
      await remoteDataSource.deleteOffer(offerId);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure('Failed to delete offer'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error'));
    }
  }
}
