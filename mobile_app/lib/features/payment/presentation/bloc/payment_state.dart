part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentProcessing extends PaymentState {}

class PaymentCreated extends PaymentState {
  final PaymentEntity payment;
  const PaymentCreated(this.payment);
  @override
  List<Object?> get props => [payment];
}

class PaymentSuccess extends PaymentState {
  final PaymentEntity payment;
  const PaymentSuccess(this.payment);
  @override
  List<Object?> get props => [payment];
}

class PaymentsLoaded extends PaymentState {
  final List<PaymentEntity> payments;
  const PaymentsLoaded(this.payments);
  @override
  List<Object?> get props => [payments];
}

class PaymentError extends PaymentState {
  final String message;
  const PaymentError(this.message);
  @override
  List<Object?> get props => [message];
}
