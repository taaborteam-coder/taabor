import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'qr_scanner_page.dart';
import '../../../../core/di/injection.dart';
import '../../../queue/domain/repositories/queue_repository.dart';
import '../../../home/domain/repositories/business_repository.dart';
import '../../../queue/domain/entities/ticket.dart';
import 'package:dartz/dartz.dart' as dartz;

class MerchantDashboardPage extends StatefulWidget {
  final String businessId;
  final String businessName;

  const MerchantDashboardPage({
    super.key,
    required this.businessId,
    required this.businessName,
  });

  @override
  State<MerchantDashboardPage> createState() => _MerchantDashboardPageState();
}

class _MerchantDashboardPageState extends State<MerchantDashboardPage> {
  late Stream<dartz.Either<dynamic, List<Ticket>>> _ticketsStream;
  bool _isQueueOpen = true; // Default, should fetch real status
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _ticketsStream = sl<QueueRepository>().streamTicketsForBusiness(
      widget.businessId,
    );
    _fetchBusinessStatus();
  }

  Future<void> _fetchBusinessStatus() async {
    final result = await sl<BusinessRepository>().getBusinessById(
      widget.businessId,
    );
    result.fold((failure) {}, (business) {
      if (mounted) {
        setState(() {
          _isQueueOpen = business.isOpen;
        });
      }
    });
  }

  Future<void> _toggleQueueStatus(bool value) async {
    setState(() => _isQueueOpen = value);
    final result = await sl<BusinessRepository>().updateBusinessStatus(
      widget.businessId,
      value,
    );
    result.fold((failure) {
      if (mounted) {
        setState(() => _isQueueOpen = !value); // Revert on failure
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error updating status')));
      }
    }, (_) {});
  }

  Future<void> _callNextCustomer(List<Ticket> tickets) async {
    // 1. Find active ticket(s) and complete them
    final activeTickets = tickets
        .where((t) => t.status == TicketStatus.active)
        .toList();
    for (var ticket in activeTickets) {
      await sl<QueueRepository>().updateTicketStatus(
        ticket.id,
        TicketStatus.completed,
      );
    }

    // 2. Find next pending ticket and activate it
    final pendingTickets = tickets
        .where((t) => t.status == TicketStatus.pending)
        .toList();
    pendingTickets.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    if (pendingTickets.isNotEmpty) {
      final nextTicket = pendingTickets.first;
      await sl<QueueRepository>().updateTicketStatus(
        nextTicket.id,
        TicketStatus.active,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Now Serving Ticket #${nextTicket.ticketNumber}'),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('No customers waiting')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.businessName),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const QRScannerPage()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<dartz.Either<dynamic, List<Ticket>>>(
        stream: _ticketsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }

          final ticketsEither = snapshot.data;
          if (ticketsEither == null) return const SizedBox();

          return ticketsEither.fold(
            (failure) => Center(
              child: Text('Error: $failure'),
            ), // Simplify error display
            (tickets) {
              final waitingCount = tickets
                  .where((t) => t.status == TicketStatus.pending)
                  .length;
              final servedCount = tickets
                  .where((t) => t.status == TicketStatus.completed)
                  .length;

              // Calculate Average Wait Time (Simple Mock/Estimate for now or real if data allows)
              // For real: Average (servedTime - createdAt) for completed tickets.
              // Since Ticket entity might not have servedTime, we'll use estimatedTime or just mock it or 0.
              // Let's calculate based on completed tickets if we had 'completedAt'. We don't.
              // So we will just show 'N/A' or a placeholder.
              // Actually, let's just count 'active' as well.

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'لوحة تحكم التاجر',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryOrange,
                              ),
                        ),
                        Switch(
                          value: _isQueueOpen,
                          onChanged: _toggleQueueStatus,
                          activeTrackColor: Colors.green,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildStatCard(
                      context,
                      icon: Icons.people,
                      label: 'في الانتظار',
                      value: '$waitingCount',
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    _buildStatCard(
                      context,
                      icon: Icons.check_circle,
                      label: 'تم خدمتهم',
                      value: '$servedCount',
                      color: Colors.green,
                    ),
                    const SizedBox(height: 12),
                    _buildStatCard(
                      context,
                      icon: Icons.timer,
                      label: 'حالة الطابور',
                      value: _isQueueOpen ? 'مفتوح' : 'مغلق',
                      color: _isQueueOpen ? Colors.green : Colors.red,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _isQueueOpen
                            ? () => _callNextCustomer(tickets)
                            : null,
                        icon: const Icon(Icons.campaign),
                        label: const Text('نداء التالي'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryOrange,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withValues(alpha: 0.1), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
