import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/repositories/queue_repository.dart';
import '../datasources/queue_remote_data_source.dart';
import '../models/ticket_model.dart';
import '../../../../core/services/offline_service.dart';

class QueueRepositoryImpl implements QueueRepository {
  final QueueRemoteDataSource remoteDataSource;
  final OfflineService offlineService;

  QueueRepositoryImpl(this.remoteDataSource, this.offlineService);

  @override
  Future<Either<Failure, String>> addTicket(Ticket ticket) async {
    try {
      final ticketModel = TicketModel(
        id: ticket.id,
        userId: ticket.userId,
        businessId: ticket.businessId,
        serviceName: ticket.serviceName,
        ticketNumber: ticket.ticketNumber,
        status: ticket.status,
        type: ticket.type,
        createdAt: ticket.createdAt,
        estimatedTime: ticket.estimatedTime,
      );
      final id = await remoteDataSource.addTicket(ticketModel);
      return Right(id);
    } on ServerException {
      return Left(ServerFailure('Failed to add ticket'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Stream<Either<Failure, List<Ticket>>> streamTicketsForBusiness(
    String businessId,
  ) {
    try {
      return remoteDataSource
          .streamTicketsForBusiness(businessId)
          .map((tickets) => Right<Failure, List<Ticket>>(tickets))
          .handleError((error) {
            if (error is ServerException) {
              return Left<Failure, List<Ticket>>(ServerFailure('Server Error'));
            }
            return Left<Failure, List<Ticket>>(
              ServerFailure('Unexpected Error: $error'),
            );
          });
    } catch (e) {
      return Stream.value(Left(ServerFailure('Unexpected Error: $e')));
    }
  }

  @override
  Future<Either<Failure, void>> updateTicketStatus(
    String ticketId,
    TicketStatus status,
  ) async {
    try {
      await remoteDataSource.updateTicketStatus(ticketId, status);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure('Failed to update status'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Ticket>>> getUserTickets(String userId) async {
    try {
      final ticketsModel = await remoteDataSource.getUserTickets(userId);
      // Cache tickets
      for (var ticket in ticketsModel) {
        await offlineService.cacheTicket(ticket.toJson());
      }
      return Right(ticketsModel);
    } on ServerException {
      // Try offline
      try {
        final cached = offlineService.getCachedTickets();
        if (cached.isNotEmpty) {
          final tickets = cached
              .map((e) => TicketModel.fromJson(Map<String, dynamic>.from(e)))
              .toList();
          return Right(tickets);
        }
        return Left(ServerFailure('No internet and no cached data'));
      } catch (e) {
        return Left(ServerFailure('Failed to fetch user tickets'));
      }
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
