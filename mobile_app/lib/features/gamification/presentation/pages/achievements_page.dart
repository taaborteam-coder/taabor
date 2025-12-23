import 'package:flutter/material.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final achievements = [
      {
        'title': 'المبتدئ',
        'description': 'أول حجز لك',
        'progress': 1,
        'target': 1,
        'completed': true,
      },
      {
        'title': 'المنتظم',
        'description': 'احجز 10 مرات',
        'progress': 7,
        'target': 10,
        'completed': false,
      },
      {
        'title': 'المخلص',
        'description': 'احجز 50 مرة',
        'progress': 7,
        'target': 50,
        'completed': false,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('الإنجازات')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final achievement = achievements[index];
          final progress = achievement['progress'] as int;
          final target = achievement['target'] as int;
          final completed = achievement['completed'] as bool;
          final progressPercent = (progress / target * 100).clamp(0, 100);

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: completed
                            ? Colors.amber
                            : Colors.grey[300],
                        child: Icon(
                          completed ? Icons.star : Icons.star_border,
                          color: completed ? Colors.white : Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              achievement['title'] as String,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              achievement['description'] as String,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      if (completed)
                        const Icon(Icons.check_circle, color: Colors.green),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: progressPercent / 100,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            completed ? Colors.green : Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '$progress/$target',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
