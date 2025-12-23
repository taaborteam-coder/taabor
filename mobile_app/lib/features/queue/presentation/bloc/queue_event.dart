import 'package:equatable/equatable.dart';
import '../../domain/entities/ticket.dart';

abstract class QueueEvent extends Equatable {
  const QueueEvent();

  @override
  List<Object?> get props => [];
}

class LoadQueue extends QueueEvent {
  final String businessId;

  const LoadQueue(this.businessId);

  @override
  List<Object?> get props => [businessId];
}

class UpdateTicketStatusEvent extends QueueEvent {
  final String ticketId;
  final TicketStatus status;

  const UpdateTicketStatusEvent(this.ticketId, this.status);

  @override
  List<Object?> get props => [ticketId, status];
}

class AddTicketEvent extends QueueEvent {
  final Ticket ticket;

  const AddTicketEvent(this.ticket);

  @override
  List<Object?> get props => [ticket];
}

class QueueUpdated extends QueueEvent {
  final List<Ticket> tickets;

  const QueueUpdated(this.tickets);

  @override
  List<Object?> get props => [tickets];
}
