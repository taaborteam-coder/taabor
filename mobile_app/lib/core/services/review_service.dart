import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/engagement/data/models/review.dart';

class ReviewService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addReview(Review review) async {
    await _firestore.collection('reviews').add(review.toMap());
  }

  Stream<List<Review>> getBusinessReviews(String businessId) {
    return _firestore
        .collection('reviews')
        .where('businessId', isEqualTo: businessId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Review.fromMap(doc.data(), doc.id))
              .toList();
        });
  }
}
