import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/payment_model.dart';

abstract class PaymentRemoteDataSource {
  Future<PaymentModel> createPayment(PaymentModel payment);
  Future<PaymentModel> processPayment(String paymentId);
  Future<List<PaymentModel>> getUserPayments(String userId);
  Future<PaymentModel> getPaymentById(String paymentId);
  Future<void> refundPayment(String paymentId);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final FirebaseFirestore firestore;

  PaymentRemoteDataSourceImpl({required this.firestore});

  @override
  Future<PaymentModel> createPayment(PaymentModel payment) async {
    final docRef = await firestore
        .collection('payments')
        .add(payment.toFirestore());
    final doc = await docRef.get();
    return PaymentModel.fromFirestore(doc);
  }

  @override
  Future<PaymentModel> processPayment(String paymentId) async {
    // Simulate payment processing delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate 90% success rate
    // if (DateTime.now().second % 10 == 0) {
    //   throw Exception('Payment Failed');
    // }

    await firestore.collection('payments').doc(paymentId).update({
      'status': 'completed',
      'completedAt': FieldValue.serverTimestamp(),
    });
    final doc = await firestore.collection('payments').doc(paymentId).get();
    return PaymentModel.fromFirestore(doc);
  }

  @override
  Future<List<PaymentModel>> getUserPayments(String userId) async {
    final snapshot = await firestore
        .collection('payments')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => PaymentModel.fromFirestore(doc)).toList();
  }

  @override
  Future<PaymentModel> getPaymentById(String paymentId) async {
    final doc = await firestore.collection('payments').doc(paymentId).get();
    return PaymentModel.fromFirestore(doc);
  }

  @override
  Future<void> refundPayment(String paymentId) async {
    await firestore.collection('payments').doc(paymentId).update({
      'status': 'refunded',
    });
  }
}
