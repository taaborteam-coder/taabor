import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/ticket.dart';

class TicketModel extends Ticket {
  const TicketModel({
    required super.id,
    required super.userId,
    required super.businessId,
    required super.serviceName,
    required super.ticketNumber,
    required super.status,
    required super.type,
    required super.createdAt,
    super.estimatedTime,
  });

  factory TicketModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TicketModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      businessId: data['businessId'] ?? '',
      serviceName: data['serviceName'] ?? '',
      ticketNumber: data['ticketNumber'] ?? 0,
      status: TicketStatus.values.firstWhere(
        (e) => e.name == (data['status'] ?? 'pending'),
        orElse: () => TicketStatus.pending,
      ),
      type: TicketType.values.firstWhere(
        (e) => e.name == (data['type'] ?? 'regular'),
        orElse: () => TicketType.regular,
      ),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      estimatedTime: (data['estimatedTime'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'businessId': businessId,
      'serviceName': serviceName,
      'ticketNumber': ticketNumber,
      'status': status.name,
      'type': type.name,
      'createdAt': createdAt,
      'estimatedTime': estimatedTime,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'businessId': businessId,
      'serviceName': serviceName,
      'ticketNumber': ticketNumber,
      'status': status.name,
      'type': type.name,
      'createdAt': createdAt.toIso8601String(),
      'estimatedTime': estimatedTime?.toIso8601String(),
    };
  }

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      businessId: json['businessId'] ?? '',
      serviceName: json['serviceName'] ?? '',
      ticketNumber: json['ticketNumber'] ?? 0,
      status: TicketStatus.values.firstWhere(
        (e) => e.name == (json['status'] ?? 'pending'),
        orElse: () => TicketStatus.pending,
      ),
      type: TicketType.values.firstWhere(
        (e) => e.name == (json['type'] ?? 'regular'),
        orElse: () => TicketType.regular,
      ),
      createdAt: DateTime.parse(json['createdAt']),
      estimatedTime: json['estimatedTime'] != null
          ? DateTime.parse(json['estimatedTime'])
          : null,
    );
  }
}
