import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/notification_repository.dart';

/// Use case for getting unread notifications count
class GetUnreadCount {
  final NotificationRepository repository;

  GetUnreadCount(this.repository);

  Future<Either<Failure, int>> call(String userId) {
    return repository.getUnreadCount(userId);
  }
}
