import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/notification.dart';
import '../../domain/usecases/get_notifications.dart';
import '../../domain/usecases/get_unread_count.dart';
import '../../domain/usecases/mark_as_read.dart';

part 'notification_event.dart';
part 'notification_state.dart';

/// BLoC for managing notifications
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotifications getNotifications;
  final GetUnreadCount getUnreadCount;
  final MarkAsRead markAsRead;

  NotificationBloc({
    required this.getNotifications,
    required this.getUnreadCount,
    required this.markAsRead,
  }) : super(NotificationInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<LoadUnreadCount>(_onLoadUnreadCount);
    on<MarkNotificationAsRead>(_onMarkAsRead);
    on<MarkAllAsRead>(_onMarkAllAsRead);
  }

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());

    final result = await getNotifications(event.userId);

    result.fold(
      (failure) => emit(NotificationError('فشل تحميل الإشعارات')),
      (notifications) => emit(NotificationLoaded(notifications)),
    );
  }

  Future<void> _onLoadUnreadCount(
    LoadUnreadCount event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await getUnreadCount(event.userId);

    result.fold(
      (failure) => null, // Silently fail for badge count
      (count) {
        if (state is NotificationLoaded) {
          final currentState = state as NotificationLoaded;
          emit(currentState.copyWith(unreadCount: count));
        }
      },
    );
  }

  Future<void> _onMarkAsRead(
    MarkNotificationAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await markAsRead(event.notificationId);

    result.fold((failure) => null, (_) {
      if (state is NotificationLoaded) {
        final currentState = state as NotificationLoaded;
        final updatedNotifications = currentState.notifications.map((n) {
          if (n.id == event.notificationId) {
            return NotificationEntity(
              id: n.id,
              userId: n.userId,
              title: n.title,
              body: n.body,
              type: n.type,
              data: n.data,
              isRead: true,
              createdAt: n.createdAt,
              imageUrl: n.imageUrl,
              actionUrl: n.actionUrl,
            );
          }
          return n;
        }).toList();

        emit(currentState.copyWith(notifications: updatedNotifications));
      }
    });
  }

  Future<void> _onMarkAllAsRead(
    MarkAllAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    // TODO: Implement mark all as read
  }
}
