import 'package:equatable/equatable.dart';

enum TicketStatus { pending, active, completed, cancelled }

enum TicketType { regular, vip }

class Ticket extends Equatable {
  final String id;
  final String userId;
  final String businessId;
  final String serviceName;
  final int ticketNumber;
  final TicketStatus status;
  final TicketType type;
  final DateTime createdAt;
  final DateTime? estimatedTime;

  const Ticket({
    required this.id,
    required this.userId,
    required this.businessId,
    required this.serviceName,
    required this.ticketNumber,
    required this.status,
    required this.type,
    required this.createdAt,
    this.estimatedTime,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    businessId,
    serviceName,
    ticketNumber,
    status,
    type,
    createdAt,
    estimatedTime,
  ];
}
