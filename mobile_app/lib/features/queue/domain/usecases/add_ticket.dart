import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/ticket.dart';
import '../repositories/queue_repository.dart';

class AddTicket {
  final QueueRepository repository;

  AddTicket(this.repository);

  Future<Either<Failure, String>> call(Ticket ticket) async {
    return await repository.addTicket(ticket);
  }
}
