import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../queue/domain/entities/ticket.dart';
import '../../../queue/presentation/bloc/queue_bloc.dart';
import '../../../queue/presentation/bloc/queue_event.dart';
import '../../../queue/presentation/bloc/queue_state.dart';

class BusinessDashboardPage extends StatelessWidget {
  const BusinessDashboardPage({super.key});

  // Hardcoded business ID logic for now
  final String _businessId = '1';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QueueBloc>()..add(LoadQueue(_businessId)),
      child: const BusinessDashboardView(),
    );
  }
}

class BusinessDashboardView extends StatelessWidget {
  const BusinessDashboardView({super.key});

  void _nextTicket(BuildContext context, Ticket? currentTicket) {
    if (currentTicket != null) {
      context.read<QueueBloc>().add(
        UpdateTicketStatusEvent(currentTicket.id, TicketStatus.completed),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة التحكم - صالون الأناقة'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<QueueBloc, QueueState>(
        listener: (context, state) {
          if (state is QueueError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is QueueLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          List<Ticket> tickets = [];
          if (state is QueueLoaded) {
            tickets = state.tickets;
          }

          // Filter for active/pending
          final activeQueue = tickets
              .where(
                (t) =>
                    t.status == TicketStatus.pending ||
                    t.status == TicketStatus.active,
              )
              .toList();

          // Current is the first one in the queue if any
          final currentTicket = activeQueue.isNotEmpty
              ? activeQueue.first
              : null;

          return Column(
            children: [
              // Current Serving Area
              Container(
                padding: const EdgeInsets.all(32),
                color: Colors.deepPurple[50],
                width: double.infinity,
                child: Column(
                  children: [
                    const Text(
                      'الدور الحالي',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      currentTicket?.ticketNumber.toString() ?? '-',
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    Text(
                      currentTicket?.serviceName ?? 'لا يوجد زبائن',
                      style: const TextStyle(fontSize: 20),
                    ),
                    if (currentTicket?.type == TicketType.vip)
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'VIP',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
              ),

              // Action Buttons
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: currentTicket == null
                            ? null
                            : () => _nextTicket(context, currentTicket),
                        icon: const Icon(Icons.check),
                        label: const Text('إكمال واستدعاء التالي'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'قائمة الانتظار',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // Waiting List
              Expanded(
                child: ListView.builder(
                  itemCount: activeQueue.length > 1
                      ? activeQueue.length - 1
                      : 0,
                  itemBuilder: (context, index) {
                    final ticket =
                        activeQueue[index + 1]; // Skip first one (current)
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: ticket.type == TicketType.vip
                            ? Colors.amber[100]
                            : Colors.grey[200],
                        child: Text('${ticket.ticketNumber}'),
                      ),
                      title: Text(ticket.serviceName),
                      subtitle: Text(
                        ticket.type == TicketType.vip
                            ? 'VIP Client'
                            : 'زبون عادي',
                      ),
                      trailing: const Icon(Icons.more_vert),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
