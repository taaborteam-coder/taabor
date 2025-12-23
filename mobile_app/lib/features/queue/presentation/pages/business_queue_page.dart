import 'package:flutter/material.dart';
import 'package:taabor/core/services/queue_service.dart';
import 'package:taabor/features/queue/data/models/queue_item.dart';

class BusinessQueuePage extends StatelessWidget {
  final String businessId; // In real app, get this from logged-in user profile
  final QueueService _queueService = QueueService();

  BusinessQueuePage({super.key, required this.businessId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Queue'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Temporary: Add dummy user to test
              _queueService.addToQueue(
                QueueItem(
                  id: '',
                  customerName: 'Customer ${DateTime.now().second}',
                  businessId: businessId,
                  timestamp: DateTime.now(),
                  status: 'waiting',
                  ticketNumber: DateTime.now().second,
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<QueueItem>>(
        stream: _queueService.getQueueStream(businessId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final queue = snapshot.data ?? [];

          if (queue.isEmpty) {
            return const Center(child: Text('Queue is empty'));
          }

          return Column(
            children: [
              // Serving Section
              if (queue.any((item) => item.status == 'serving')) ...[
                _buildServingSection(
                  context,
                  queue.firstWhere((item) => item.status == 'serving'),
                ),
                const Divider(thickness: 2),
              ],

              // Waiting List
              Expanded(
                child: ListView.builder(
                  itemCount: queue
                      .where((item) => item.status == 'waiting')
                      .length,
                  itemBuilder: (context, index) {
                    final waitingItems = queue
                        .where((item) => item.status == 'waiting')
                        .toList();
                    final item = waitingItems[index];
                    return _buildQueueListTile(context, item);
                  },
                ),
              ),

              // Call Next Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () => _queueService.callNext(businessId),
                    child: const Text(
                      'Call Next (Ready Now)',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildServingSection(BuildContext context, QueueItem item) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.green.shade50,
      width: double.infinity,
      child: Column(
        children: [
          const Text(
            'Currently Serving',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Text(
            item.customerName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('#${item.ticketNumber}', style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  Widget _buildQueueListTile(BuildContext context, QueueItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: item.isPriority ? Colors.red : Colors.blue,
          child: Text(
            '${item.ticketNumber}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(item.customerName),
        subtitle: Text(
          'Status: ${item.status} ${item.isPriority ? '(Priority)' : ''}',
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            if (!item.isPriority)
              const PopupMenuItem(
                value: 'emergency',
                child: Text('Mark as Emergency'),
              ),
            const PopupMenuItem(
              value: 'requeue',
              child: Text('Requeue (Move to End)'),
            ),
            const PopupMenuItem(value: 'remove', child: Text('Remove')),
          ],
          onSelected: (value) {
            if (value == 'emergency') {
              _queueService.setEmergencyPriority(item.id);
            } else if (value == 'requeue') {
              _queueService.requeue(item.id);
            } else if (value == 'remove') {
              _queueService.updateStatus(item.id, 'cancelled');
            }
          },
        ),
      ),
    );
  }
}
