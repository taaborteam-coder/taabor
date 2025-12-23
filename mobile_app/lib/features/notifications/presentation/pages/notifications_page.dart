import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/notification.dart';
import '../bloc/notification_bloc.dart';
import '../widgets/notification_card.dart';

/// Page to display user notifications
class NotificationsPage extends StatelessWidget {
  final String userId;

  const NotificationsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NotificationBloc>()
        ..add(LoadNotifications(userId))
        ..add(LoadUnreadCount(userId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الإشعارات'),
          actions: [
            BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                if (state is NotificationLoaded &&
                    state.notifications.isNotEmpty) {
                  return TextButton(
                    onPressed: () {
                      context.read<NotificationBloc>().add(
                        MarkAllAsRead(userId),
                      );
                    },
                    child: const Text('تعليم الكل كمقروء'),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is NotificationError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<NotificationBloc>().add(
                          LoadNotifications(userId),
                        );
                      },
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            if (state is NotificationLoaded) {
              if (state.notifications.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_off_outlined,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'لا توجد إشعارات',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<NotificationBloc>().add(
                    LoadNotifications(userId),
                  );
                },
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.notifications.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final notification = state.notifications[index];
                    return NotificationCard(
                      notification: notification,
                      onTap: () {
                        if (!notification.isRead) {
                          context.read<NotificationBloc>().add(
                            MarkNotificationAsRead(notification.id),
                          );
                        }
                        _handleNotificationTap(context, notification);
                      },
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _handleNotificationTap(
    BuildContext context,
    NotificationEntity notification,
  ) {
    // Navigate based on notification type
    switch (notification.type) {
      case NotificationType.queueUpdate:
      case NotificationType.queueReady:
        // Navigate to ticket status page
        final ticketId = notification.data['ticketId'];
        if (ticketId != null) {
          // Navigator.pushNamed(context, '/ticket-status', arguments: ticketId);
        }
        break;
      case NotificationType.newBooking:
        // Navigate to merchant dashboard
        // Navigator.pushNamed(context, '/merchant-dashboard');
        break;
      case NotificationType.offerAlert:
        // Navigate to offers page
        final businessId = notification.data['businessId'];
        if (businessId != null) {
          // Navigator.pushNamed(context, '/business-details', arguments: businessId);
        }
        break;
      default:
        break;
    }
  }
}
