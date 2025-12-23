import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/exceptions.dart';
import '../models/offer.dart';

abstract class OfferRemoteDataSource {
  Future<List<OfferModel>> getOffersByBusiness(String businessId);
  Future<List<OfferModel>> getActiveOffers(String businessId);
  Future<void> createOffer(OfferModel offer);
  Future<void> updateOffer(OfferModel offer);
  Future<void> deleteOffer(String offerId);
}

class OfferRemoteDataSourceImpl implements OfferRemoteDataSource {
  final FirebaseFirestore firestore;

  OfferRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<OfferModel>> getOffersByBusiness(String businessId) async {
    try {
      final snapshot = await firestore
          .collection('offers')
          .where('businessId', isEqualTo: businessId)
          .get();
      return snapshot.docs
          .map((doc) => OfferModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<OfferModel>> getActiveOffers(String businessId) async {
    try {
      final now = Timestamp.now();
      final snapshot = await firestore
          .collection('offers')
          .where('businessId', isEqualTo: businessId)
          .where('isActive', isEqualTo: true)
          .where('validTo', isGreaterThan: now)
          .get();
      return snapshot.docs
          .map((doc) => OfferModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> createOffer(OfferModel offer) async {
    try {
      if (offer.id.isEmpty) {
        await firestore.collection('offers').add(offer.toMap());
      } else {
        await firestore.collection('offers').doc(offer.id).set(offer.toMap());
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateOffer(OfferModel offer) async {
    try {
      await firestore.collection('offers').doc(offer.id).update(offer.toMap());
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteOffer(String offerId) async {
    try {
      await firestore.collection('offers').doc(offerId).delete();
    } catch (e) {
      throw ServerException();
    }
  }
}
