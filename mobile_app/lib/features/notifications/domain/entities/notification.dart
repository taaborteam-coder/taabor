import 'package:equatable/equatable.dart';

/// Notification entity representing a push notification
class NotificationEntity extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String body;
  final NotificationType type;
  final Map<String, dynamic> data;
  final bool isRead;
  final DateTime createdAt;
  final String? imageUrl;
  final String? actionUrl;

  const NotificationEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    required this.data,
    this.isRead = false,
    required this.createdAt,
    this.imageUrl,
    this.actionUrl,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    title,
    body,
    type,
    data,
    isRead,
    createdAt,
    imageUrl,
    actionUrl,
  ];
}

/// Types of notifications
enum NotificationType {
  queueUpdate, // Queue position update
  queueReady, // Your turn is ready
  newBooking, // New booking for merchant
  offerAlert, // Special offer
  general, // General announcement
  rating, // New rating/review
  payment, // Payment notification
  loyalty, // Loyalty points update
}
