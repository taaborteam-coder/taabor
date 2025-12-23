import 'package:equatable/equatable.dart';
import '../../domain/entities/ticket.dart';

abstract class QueueState extends Equatable {
  const QueueState();

  @override
  List<Object?> get props => [];
}

class QueueInitial extends QueueState {}

class QueueLoading extends QueueState {}

class QueueLoaded extends QueueState {
  final List<Ticket> tickets;

  const QueueLoaded(this.tickets);

  @override
  List<Object?> get props => [tickets];
}

class QueueError extends QueueState {
  final String message;

  const QueueError(this.message);

  @override
  List<Object?> get props => [message];
}

class QueueOperationSuccess extends QueueState {
  final String message;
  final Ticket? ticket;

  const QueueOperationSuccess({this.message = '', this.ticket});

  @override
  List<Object?> get props => [message, ticket];
}
