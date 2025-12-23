import 'package:cloud_firestore/cloud_firestore.dart';

class QueueItem {
  final String id;
  final String? userId; // Nullable for walk-in customers
  final String customerName;
  final String businessId;
  final DateTime timestamp;
  final String status; // waiting, serving, completed, missed, cancelled
  final bool isPriority; // For emergency cases
  final int ticketNumber;

  QueueItem({
    required this.id,
    this.userId,
    required this.customerName,
    required this.businessId,
    required this.timestamp,
    required this.status,
    this.isPriority = false,
    required this.ticketNumber,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'customerName': customerName,
      'businessId': businessId,
      'timestamp': Timestamp.fromDate(timestamp),
      'status': status,
      'isPriority': isPriority,
      'ticketNumber': ticketNumber,
    };
  }

  // Create from Firestore Document
  factory QueueItem.fromMap(Map<String, dynamic> map, String docId) {
    return QueueItem(
      id: docId,
      userId: map['userId'],
      customerName: map['customerName'] ?? 'Unknown',
      businessId: map['businessId'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      status: map['status'] ?? 'waiting',
      isPriority: map['isPriority'] ?? false,
      ticketNumber: map['ticketNumber'] ?? 0,
    );
  }

  QueueItem copyWith({
    String? id,
    String? userId,
    String? customerName,
    String? businessId,
    DateTime? timestamp,
    String? status,
    bool? isPriority,
    int? ticketNumber,
  }) {
    return QueueItem(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      customerName: customerName ?? this.customerName,
      businessId: businessId ?? this.businessId,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      isPriority: isPriority ?? this.isPriority,
      ticketNumber: ticketNumber ?? this.ticketNumber,
    );
  }
}
