import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:taabor/features/queue/domain/repositories/queue_repository.dart';
import 'package:taabor/features/queue/domain/usecases/add_ticket.dart';
import 'package:taabor/features/queue/domain/entities/ticket.dart';
import 'package:taabor/core/error/failures.dart';

@GenerateMocks([QueueRepository])
import 'queue_test.mocks.dart';

void main() {
  late AddTicket addTicket;
  late MockQueueRepository mockRepository;

  setUp(() {
    mockRepository = MockQueueRepository();
    addTicket = AddTicket(mockRepository);
  });

  group('AddTicket UseCase', () {
    final testTicket = Ticket(
      id: '1',
      businessId: 'business123',
      userId: 'user123',
      ticketNumber: 1,
      serviceName: 'Service A',
      type: TicketType.regular,
      status: TicketStatus.pending,
      createdAt: DateTime(2024, 1, 1),
    );

    test('should add ticket through repository', () async {
      // Arrange
      when(
        mockRepository.addTicket(any),
      ).thenAnswer((_) async => const Right('1'));

      // Act
      final result = await addTicket(testTicket);

      // Assert
      expect(result, const Right('1'));
      verify(mockRepository.addTicket(testTicket));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return ServerFailure when repository fails', () async {
      // Arrange
      when(
        mockRepository.addTicket(any),
      ).thenAnswer((_) async => Left(ServerFailure()));

      // Act
      final result = await addTicket(testTicket);

      // Assert
      expect(result, Left(ServerFailure()));
      verify(mockRepository.addTicket(testTicket));
    });
  });
}
