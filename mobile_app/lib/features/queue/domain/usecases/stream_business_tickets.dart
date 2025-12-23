import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/ticket.dart';
import '../repositories/queue_repository.dart';

class StreamBusinessTickets {
  final QueueRepository repository;

  StreamBusinessTickets(this.repository);

  Stream<Either<Failure, List<Ticket>>> call(String businessId) {
    return repository.streamTicketsForBusiness(businessId);
  }
}
