import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/ticket.dart';
import '../repositories/queue_repository.dart';

class UpdateTicketStatus {
  final QueueRepository repository;

  UpdateTicketStatus(this.repository);

  Future<Either<Failure, void>> call(
    String ticketId,
    TicketStatus status,
  ) async {
    return await repository.updateTicketStatus(ticketId, status);
  }
}
