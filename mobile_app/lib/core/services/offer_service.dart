import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/engagement/domain/entities/offer.dart';
import '../../features/engagement/data/models/offer.dart' as offer_model;

class OfferService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new offer
  Future<void> addOffer(Offer offer) async {
    // Convert to model for serialization
    final model = offer as offer_model.OfferModel;
    await _firestore.collection('offers').add(model.toMap());
  }

  // Get active offers for a business
  Stream<List<Offer>> getActiveOffers(String businessId) {
    final now = DateTime.now();
    return _firestore
        .collection('offers')
        .where('businessId', isEqualTo: businessId)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => offer_model.OfferModel.fromMap(doc.data(), doc.id))
              .where(
                (offer) =>
                    offer.validFrom.isBefore(now) && offer.validTo.isAfter(now),
              )
              .toList();
        });
  }

  // Get all offers for a business (for management)
  Stream<List<Offer>> getAllOffers(String businessId) {
    return _firestore
        .collection('offers')
        .where('businessId', isEqualTo: businessId)
        .orderBy('validFrom', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => offer_model.OfferModel.fromMap(doc.data(), doc.id))
              .toList();
        });
  }

  // Toggle offer active status
  Future<void> updateOfferStatus(String offerId, bool isActive) async {
    await _firestore.collection('offers').doc(offerId).update({
      'isActive': isActive,
    });
  }

  // Delete offer
  Future<void> deleteOffer(String offerId) async {
    await _firestore.collection('offers').doc(offerId).delete();
  }
}
