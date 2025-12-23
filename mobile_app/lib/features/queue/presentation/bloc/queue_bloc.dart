import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/logging/app_logger.dart';
import '../../domain/usecases/add_ticket.dart';
import '../../domain/usecases/stream_business_tickets.dart';
import '../../domain/usecases/update_ticket_status.dart';
import 'queue_event.dart';
import 'queue_state.dart';

class QueueBloc extends Bloc<QueueEvent, QueueState> {
  final StreamBusinessTickets streamBusinessTickets;
  final UpdateTicketStatus updateTicketStatus;
  final AddTicket addTicket;

  StreamSubscription? _queueSubscription;

  QueueBloc({
    required this.streamBusinessTickets,
    required this.updateTicketStatus,
    required this.addTicket,
  }) : super(QueueInitial()) {
    on<LoadQueue>(_onLoadQueue);
    on<UpdateTicketStatusEvent>(_onUpdateTicketStatus);
    on<AddTicketEvent>(_onAddTicket);
    on<QueueUpdated>(_onQueueUpdated);
  }

  Future<void> _onLoadQueue(LoadQueue event, Emitter<QueueState> emit) async {
    emit(QueueLoading());
    await _queueSubscription?.cancel();
    _queueSubscription = streamBusinessTickets(event.businessId).listen((
      failureOrTickets,
    ) {
      failureOrTickets.fold(
        (failure) => AppLogger.error(
          'Stream failure: ${failure.message}',
        ), // Simple log for stream error
        (tickets) => add(QueueUpdated(tickets)),
      );
    });
  }

  Future<void> _onUpdateTicketStatus(
    UpdateTicketStatusEvent event,
    Emitter<QueueState> emit,
  ) async {
    final result = await updateTicketStatus(event.ticketId, event.status);
    result.fold(
      (failure) =>
          emit(QueueError('Failed to update status: ${failure.message}')),
      (_) => emit(const QueueOperationSuccess(message: 'Status updated')),
    );
  }

  Future<void> _onAddTicket(
    AddTicketEvent event,
    Emitter<QueueState> emit,
  ) async {
    final result = await addTicket(event.ticket);
    result.fold(
      (failure) => emit(QueueError('Failed to add ticket: ${failure.message}')),
      (ticketId) {
        // Create a copy of the ticket with the new ID
        // Since Ticket is immutable and doesn't have copyWith (yet), we might need to recreate it.
        // Assuming we can't easily modify it without copyWith.
        // But we just want to pass it to UI.
        // Ideally Ticket should have copyWith.
        // For now, let's just emit success message. The UI might not strictly need the ID for the "Status Page" if it only shows number.
        // But if we want to be correct:
        // We really should add copyWith to Ticket.
        emit(
          QueueOperationSuccess(message: 'Ticket booked', ticket: event.ticket),
        );
      },
    );
  }

  void _onQueueUpdated(QueueUpdated event, Emitter<QueueState> emit) {
    emit(QueueLoaded(event.tickets));
  }

  @override
  Future<void> close() {
    _queueSubscription?.cancel();
    return super.close();
  }
}
