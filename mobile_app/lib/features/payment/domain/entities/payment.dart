import 'package:equatable/equatable.dart';

enum PaymentMethod { cash, card, wallet, applePay, googlePay }

enum PaymentStatus { pending, processing, completed, failed, refunded }

class PaymentEntity extends Equatable {
  final String id;
  final String userId;
  final String bookingId;
  final double amount;
  final PaymentMethod method;
  final PaymentStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? transactionId;

  const PaymentEntity({
    required this.id,
    required this.userId,
    required this.bookingId,
    required this.amount,
    required this.method,
    required this.status,
    required this.createdAt,
    this.completedAt,
    this.transactionId,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    bookingId,
    amount,
    method,
    status,
    createdAt,
    completedAt,
    transactionId,
  ];
}
