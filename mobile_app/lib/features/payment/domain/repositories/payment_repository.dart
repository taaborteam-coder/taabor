import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/payment.dart';

abstract class PaymentRepository {
  Future<Either<Failure, PaymentEntity>> createPayment({
    required String userId,
    required String bookingId,
    required double amount,
    required PaymentMethod method,
  });

  Future<Either<Failure, PaymentEntity>> processPayment(String paymentId);

  Future<Either<Failure, List<PaymentEntity>>> getUserPayments(String userId);

  Future<Either<Failure, PaymentEntity>> getPaymentById(String paymentId);

  Future<Either<Failure, void>> refundPayment(String paymentId);
}
