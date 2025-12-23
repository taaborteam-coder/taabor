import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:taabor/features/queue/data/datasources/queue_remote_data_source.dart';
import 'package:taabor/features/queue/data/repositories/queue_repository_impl.dart';
import 'package:taabor/features/queue/data/models/ticket_model.dart';
import 'package:taabor/features/queue/domain/entities/ticket.dart';
import 'package:taabor/core/error/exceptions.dart';
import 'package:taabor/core/error/failures.dart';
import 'package:taabor/core/services/offline_service.dart';

@GenerateMocks([QueueRemoteDataSource, OfflineService])
import 'queue_repository_test.mocks.dart';

void main() {
  late QueueRepositoryImpl repository;
  late MockQueueRemoteDataSource mockDataSource;
  late MockOfflineService mockOfflineService;

  setUp(() {
    mockDataSource = MockQueueRemoteDataSource();
    mockOfflineService = MockOfflineService();
    repository = QueueRepositoryImpl(mockDataSource, mockOfflineService);
  });

  group('QueueRepository', () {
    final testTicket = TicketModel(
      id: '1',
      businessId: 'business123',
      userId: 'user123',
      ticketNumber: 1,
      serviceName: 'Service A',
      type: TicketType.regular,
      status: TicketStatus.pending,
      createdAt: DateTime(2024, 1, 1),
    );

    group('addTicket', () {
      test('should return ticket ID when adding is successful', () async {
        // Arrange
        when(mockDataSource.addTicket(any)).thenAnswer((_) async => '1');

        // Act
        final result = await repository.addTicket(testTicket);

        // Assert
        expect(result, const Right('1'));
        verify(mockDataSource.addTicket(testTicket));
      });

      test('should return ServerFailure when adding fails', () async {
        // Arrange
        when(mockDataSource.addTicket(any)).thenThrow(ServerException());

        // Act
        final result = await repository.addTicket(testTicket);

        // Assert
        expect(result, Left(ServerFailure('Failed to add ticket')));
      });
    });

    group('updateTicketStatus', () {
      test('should call data source to update status', () async {
        // Arrange
        when(
          mockDataSource.updateTicketStatus(any, any),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await repository.updateTicketStatus(
          '1',
          TicketStatus.active,
        );

        // Assert
        expect(result, const Right(null));
        verify(mockDataSource.updateTicketStatus('1', TicketStatus.active));
      });
    });
  });
}
