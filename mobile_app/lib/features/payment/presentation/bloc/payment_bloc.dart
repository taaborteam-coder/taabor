import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/payment.dart';
import '../../domain/repositories/payment_repository.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository repository;

  PaymentBloc({required this.repository}) : super(PaymentInitial()) {
    on<CreatePaymentEvent>(_onCreatePayment);
    on<ProcessPaymentEvent>(_onProcessPayment);
    on<LoadUserPaymentsEvent>(_onLoadUserPayments);
  }

  Future<void> _onCreatePayment(
    CreatePaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    final result = await repository.createPayment(
      userId: event.userId,
      bookingId: event.bookingId,
      amount: event.amount,
      method: event.method,
    );
    result.fold(
      (failure) => emit(PaymentError(failure.message)),
      (payment) => emit(PaymentCreated(payment)),
    );
  }

  Future<void> _onProcessPayment(
    ProcessPaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentProcessing());
    final result = await repository.processPayment(event.paymentId);
    result.fold(
      (failure) => emit(PaymentError(failure.message)),
      (payment) => emit(PaymentSuccess(payment)),
    );
  }

  Future<void> _onLoadUserPayments(
    LoadUserPaymentsEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    final result = await repository.getUserPayments(event.userId);
    result.fold(
      (failure) => emit(PaymentError(failure.message)),
      (payments) => emit(PaymentsLoaded(payments)),
    );
  }
}
