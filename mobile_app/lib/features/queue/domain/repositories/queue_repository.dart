import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/ticket.dart';

abstract class QueueRepository {
  Future<Either<Failure, String>> addTicket(Ticket ticket);
  Stream<Either<Failure, List<Ticket>>> streamTicketsForBusiness(
    String businessId,
  );
  Future<Either<Failure, void>> updateTicketStatus(
    String ticketId,
    TicketStatus status,
  );
  Future<Either<Failure, List<Ticket>>> getUserTickets(String userId);
}
