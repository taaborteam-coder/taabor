part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
  @override
  List<Object?> get props => [];
}

class CreatePaymentEvent extends PaymentEvent {
  final String userId;
  final String bookingId;
  final double amount;
  final PaymentMethod method;

  const CreatePaymentEvent({
    required this.userId,
    required this.bookingId,
    required this.amount,
    required this.method,
  });

  @override
  List<Object?> get props => [userId, bookingId, amount, method];
}

class ProcessPaymentEvent extends PaymentEvent {
  final String paymentId;

  const ProcessPaymentEvent(this.paymentId);

  @override
  List<Object?> get props => [paymentId];
}

class LoadUserPaymentsEvent extends PaymentEvent {
  final String userId;

  const LoadUserPaymentsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}
