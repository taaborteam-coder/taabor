import 'package:flutter_test/flutter_test.dart';
import 'package:taabor/features/queue/data/models/ticket_model.dart';
import 'package:taabor/features/queue/domain/entities/ticket.dart';

void main() {
  group('TicketModel', () {
    final tDate = DateTime.parse('2024-01-01T12:00:00.000Z');
    final tTicket = TicketModel(
      id: '1',
      businessId: 'business123',
      userId: 'user123',
      serviceName: 'Haircut',
      ticketNumber: 5,
      status: TicketStatus.pending,
      type: TicketType.regular,
      createdAt: tDate,
      estimatedTime: tDate.add(const Duration(minutes: 30)),
    );

    test('should be a subclass of Ticket entity', () {
      expect(tTicket, isA<Ticket>());
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        // Act
        final result = tTicket.toJson();

        // Assert
        final expectedMap = {
          'id': '1',
          'businessId': 'business123',
          'userId': 'user123',
          'serviceName': 'Haircut',
          'ticketNumber': 5,
          'status': 'pending',
          'type': 'regular',
          'createdAt': '2024-01-01T12:00:00.000Z',
          'estimatedTime': '2024-01-01T12:30:00.000Z',
          'isLamassuVerified': false,
        };
        expect(result, expectedMap);
      });
    });

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // Arrange
        final json = {
          'id': '1',
          'businessId': 'business123',
          'userId': 'user123',
          'serviceName': 'Haircut',
          'ticketNumber': 5,
          'status': 'pending',
          'type': 'regular',
          'createdAt': '2024-01-01T12:00:00.000Z',
          'estimatedTime': '2024-01-01T12:30:00.000Z',
          'isLamassuVerified': false,
        };

        // Act
        final result = TicketModel.fromJson(json);

        // Assert
        expect(result, tTicket);
      });
    });

    // NOTE: TicketModel does not have a copyWith method in the provided file content.
    // If copyWith is needed, it should be added to the model.
    // For now, removing copyWith test as the method doesn't exist in the model I viewed.
  });
}
