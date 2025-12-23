import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/notification.dart';

/// Repository interface for notifications
abstract class NotificationRepository {
  /// Get all notifications for a user
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(
    String userId,
  );

  /// Get unread notifications count
  Future<Either<Failure, int>> getUnreadCount(String userId);

  /// Mark notification as read
  Future<Either<Failure, void>> markAsRead(String notificationId);

  /// Mark all notifications as read
  Future<Either<Failure, void>> markAllAsRead(String userId);

  /// Delete a notification
  Future<Either<Failure, void>> deleteNotification(String notificationId);

  /// Delete all notifications
  Future<Either<Failure, void>> deleteAllNotifications(String userId);

  /// Stream of new notifications
  Stream<NotificationEntity> watchNotifications(String userId);

  /// Save FCM token for push notifications
  Future<Either<Failure, void>> saveFcmToken(String userId, String token);
}
