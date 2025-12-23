import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/notification.dart';

/// Data model for notification
class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.body,
    required super.type,
    required super.data,
    super.isRead,
    required super.createdAt,
    super.imageUrl,
    super.actionUrl,
  });

  /// Create from Firestore document
  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      type: _parseNotificationType(data['type']),
      data: Map<String, dynamic>.from(data['data'] ?? {}),
      isRead: data['isRead'] ?? false,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      imageUrl: data['imageUrl'],
      actionUrl: data['actionUrl'],
    );
  }

  /// Create from push notification payload
  factory NotificationModel.fromPayload(Map<String, dynamic> payload) {
    return NotificationModel(
      id: payload['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      userId: payload['userId'] ?? '',
      title: payload['title'] ?? '',
      body: payload['body'] ?? '',
      type: _parseNotificationType(payload['type']),
      data: Map<String, dynamic>.from(payload['data'] ?? {}),
      isRead: false,
      createdAt: DateTime.now(),
      imageUrl: payload['imageUrl'],
      actionUrl: payload['actionUrl'],
    );
  }

  /// Convert to Firestore map
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'title': title,
      'body': body,
      'type': type.name,
      'data': data,
      'isRead': isRead,
      'createdAt': Timestamp.fromDate(createdAt),
      'imageUrl': imageUrl,
      'actionUrl': actionUrl,
    };
  }

  /// Parse notification type from string
  static NotificationType _parseNotificationType(dynamic typeValue) {
    if (typeValue == null) return NotificationType.general;

    final typeStr = typeValue.toString();
    try {
      return NotificationType.values.firstWhere(
        (e) => e.name == typeStr,
        orElse: () => NotificationType.general,
      );
    } catch (e) {
      return NotificationType.general;
    }
  }

  /// Copy with method
  NotificationModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? body,
    NotificationType? type,
    Map<String, dynamic>? data,
    bool? isRead,
    DateTime? createdAt,
    String? imageUrl,
    String? actionUrl,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      data: data ?? this.data,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
      actionUrl: actionUrl ?? this.actionUrl,
    );
  }
}
