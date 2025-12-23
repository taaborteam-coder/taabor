import 'package:flutter/material.dart';
import 'package:taabor/core/services/queue_service.dart';
import 'package:taabor/core/services/notification_service.dart';
import 'package:taabor/core/services/loyalty_service.dart';
import 'package:taabor/features/queue/data/models/queue_item.dart';
import 'package:taabor/features/engagement/data/models/loyalty_profile.dart';
import 'package:taabor/features/engagement/presentation/widgets/rating_dialog.dart';

class CustomerQueuePage extends StatefulWidget {
  final String businessId;
  final String userId;
  final bool isTestMode; // For testing without real auth if needed

  const CustomerQueuePage({
    super.key,
    required this.businessId,
    required this.userId,
    this.isTestMode = false,
  });

  @override
  State<CustomerQueuePage> createState() => _CustomerQueuePageState();
}

class _CustomerQueuePageState extends State<CustomerQueuePage> {
  final QueueService _queueService = QueueService();
  final NotificationService _notificationService = NotificationService();
  final LoyaltyService _loyaltyService = LoyaltyService();

  // Reminder settings
  bool _notify10Min = false;
  bool _notify30Min = false;
  bool _hasNotified10 = false;
  bool _hasNotified30 = false;

  // Simulation consts
  final int averageServiceTimeMin = 3;

  @override
  void initState() {
    super.initState();
    _notificationService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Queue Status')),
      body: StreamBuilder<List<QueueItem>>(
        stream: _queueService.getQueueStream(widget.businessId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final queue = snapshot.data ?? [];

          // Find my position
          final myIndex = queue.indexWhere(
            (item) => item.userId == widget.userId && item.status == 'waiting',
          );
          final isServingMe = queue.any(
            (item) => item.userId == widget.userId && item.status == 'serving',
          );

          if (isServingMe) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 80),
                  SizedBox(height: 20),
                  Text(
                    'It\'s your turn!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Please proceed to the counter.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }

          if (myIndex == -1) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('You are not in the queue.'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _queueService.addToQueue(
                        QueueItem(
                          id: '',
                          userId: widget.userId,
                          customerName: 'Me (${widget.userId.substring(0, 4)})',
                          businessId: widget.businessId,
                          timestamp: DateTime.now(),
                          status: 'waiting',
                          ticketNumber:
                              DateTime.now().minute, // Simple dummy ticket
                        ),
                      );
                    },
                    child: const Text('Join Queue Now'),
                  ),
                ],
              ),
            );
          }

          // Calculation
          // People ahead includes everyone with index < myIndex (waiting only is filtered in stream usually, but let's be safe)
          // In the stream logic 'getQueueStream', we returned serving items too if we removed restriction,
          // but let's assume index is 0-based within waiting list.

          final peopleAhead = myIndex;
          final estimatedWaitTime = peopleAhead * averageServiceTimeMin;

          // Check Completion
          _checkCompletion(queue);

          // Check Reminders
          _checkReminders(estimatedWaitTime);

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Info Card
                Card(
                  elevation: 4,
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Text(
                          'Your Position',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        Text(
                          '${myIndex + 1}',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        const Text(
                          'Estimated Wait Time',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        Text(
                          '$estimatedWaitTime mins',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const Text(
                          '(Approx. 3 mins per person)',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Loyalty Card
                StreamBuilder<LoyaltyProfile?>(
                  stream: _loyaltyService.getLoyaltyStream(
                    widget.businessId,
                    widget.userId,
                  ),
                  builder: (context, loyaltySnapshot) {
                    final loyalty = loyaltySnapshot.data;
                    final visits = loyalty?.completedVisits ?? 0;
                    final nextRewardAt = ((visits ~/ 5) + 1) * 5;
                    final progress = (visits % 5) / 5.0;

                    return Card(
                      elevation: 3,
                      color: Colors.amber.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.card_giftcard,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Loyalty Rewards',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Visits: $visits / $nextRewardAt to next reward',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.grey.shade300,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.amber,
                              ),
                            ),
                            if (loyalty != null &&
                                loyalty.rewards.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              const Text(
                                'Available Rewards:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              ...loyalty.rewards.map(
                                (reward) => Chip(
                                  label: Text(reward),
                                  backgroundColor: Colors.green.shade100,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),
                const Text(
                  'Reminders',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SwitchListTile(
                  title: const Text('Notify me 10 mins before'),
                  value: _notify10Min,
                  onChanged: (val) {
                    setState(() {
                      _notify10Min = val;
                      _hasNotified10 = false; // Reset if toggled on again
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Notify me 30 mins before'),
                  value: _notify30Min,
                  onChanged: (val) {
                    setState(() {
                      _notify30Min = val;
                      _hasNotified30 = false;
                    });
                  },
                ),

                const Spacer(),
                OutlinedButton(
                  onPressed: () {
                    // Leave queue logic would go here
                    final myItem = queue[myIndex];
                    _queueService.updateStatus(myItem.id, 'cancelled');
                  },
                  child: const Text(
                    'Leave Queue',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  bool _hasRated = false;

  void _checkCompletion(List<QueueItem> queue) {
    if (_hasRated) return;

    final myCompletedItem = queue.firstWhere(
      (item) => item.userId == widget.userId && item.status == 'completed',
      orElse: () => QueueItem(
        id: '',
        customerName: '',
        businessId: '',
        timestamp: DateTime.now(),
        status: 'none',
        ticketNumber: 0,
      ),
    );

    if (myCompletedItem.status == 'completed') {
      // Use microtask to avoid setState during build
      Future.microtask(() {
        if (mounted && !_hasRated) {
          setState(() {
            _hasRated = true; // Mark shown so we don't spam
          });
          showDialog(
            context: context,
            builder: (_) => RatingDialog(
              businessId: widget.businessId,
              userId: widget.userId,
            ),
          );
        }
      });
    }
  }

  void _checkReminders(int waitTime) {
    if (_notify10Min && waitTime <= 10 && !_hasNotified10) {
      _notificationService.showNotification(
        id: 1,
        title: 'Queue Alert',
        body: 'Your turn is coming up in approx 10 mins!',
      );
      _hasNotified10 = true; // Prevent spam
    }

    if (_notify30Min && waitTime <= 30 && waitTime > 10 && !_hasNotified30) {
      _notificationService.showNotification(
        id: 2,
        title: 'Queue Alert',
        body: 'Your turn is in about 30 mins.',
      );
      _hasNotified30 = true;
    }
  }
}
