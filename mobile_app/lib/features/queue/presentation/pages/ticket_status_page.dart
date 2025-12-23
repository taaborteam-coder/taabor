import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/notification_service.dart';
import '../../domain/entities/ticket.dart';
import '../bloc/queue_bloc.dart';
import '../bloc/queue_event.dart';
import '../bloc/queue_state.dart';

class TicketStatusPage extends StatelessWidget {
  final Ticket ticket;
  final String businessName;

  const TicketStatusPage({
    super.key,
    required this.ticket,
    required this.businessName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QueueBloc>()..add(LoadQueue(ticket.businessId)),
      child: TicketStatusView(ticket: ticket, businessName: businessName),
    );
  }
}

class TicketStatusView extends StatefulWidget {
  final Ticket ticket;
  final String businessName;

  const TicketStatusView({
    super.key,
    required this.ticket,
    required this.businessName,
  });

  @override
  State<TicketStatusView> createState() => _TicketStatusViewState();
}

class _TicketStatusViewState extends State<TicketStatusView> {
  int _peopleAhead = 0;
  bool _notificationSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التذكرة الحالية')),
      body: BlocListener<QueueBloc, QueueState>(
        listener: (context, state) {
          if (state is QueueLoaded) {
            // Calculate people ahead
            // Logic: Count tickets with status 'pending' (or 'serving') that were created before my ticket
            // OR just ticketNumber < myTicketNumber if they are sequential and reset daily.
            // Let's assume ticketNumber is sequential.

            final myNum = widget.ticket.ticketNumber;
            // Filter: pending/serving tickets with number < myNum
            final ahead = state.tickets.where((t) {
              return (t.status == TicketStatus.pending ||
                      t.status == TicketStatus.active) &&
                  t.ticketNumber < myNum;
            }).length;

            setState(() {
              _peopleAhead = ahead;
            });

            // Notification Logic
            if (_peopleAhead <= 2 && _peopleAhead > 0 && !_notificationSent) {
              sl<NotificationService>().showNotification(
                id: 1, // Unique ID for this notification type
                title: 'انتبه! دورك اقترب',
                body:
                    'بقي أمامك $_peopleAhead أشخاص فقط في ${widget.businessName}',
              );
              _notificationSent = true;
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Text(
                        widget.businessName,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.ticket.ticketNumber.toString(),
                        style: const TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'رقم دورك',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Divider(height: 48),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('الأشخاص قبلك:'),
                          Text(
                            '$_peopleAhead',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('الوقت المتوقع:'),
                          Text(
                            '${_peopleAhead * 5} دقيقة', // Est. 5 mins per person
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('العودة للقائمة الرئيسية'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Cancel Dialog logic (omitted for now)
                },
                child: const Text(
                  'إلغاء الحجز',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
