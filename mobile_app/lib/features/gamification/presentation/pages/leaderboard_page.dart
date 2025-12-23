import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final leaderboard = List.generate(
      20,
      (index) => {
        'rank': index + 1,
        'name': 'مستخدم ${index + 1}',
        'points': 1000 - (index * 50),
      },
    );

    return Scaffold(
      appBar: AppBar(title: const Text('لوحة المتصدرين')),
      body: Column(
        children: [
          // Top 3
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber[700]!, Colors.amber[300]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _TopPlayerCard(
                  rank: 2,
                  name: leaderboard[1]['name'] as String,
                  points: leaderboard[1]['points'] as int,
                  color: Colors.grey,
                ),
                _TopPlayerCard(
                  rank: 1,
                  name: leaderboard[0]['name'] as String,
                  points: leaderboard[0]['points'] as int,
                  color: Colors.amber,
                  isFirst: true,
                ),
                _TopPlayerCard(
                  rank: 3,
                  name: leaderboard[2]['name'] as String,
                  points: leaderboard[2]['points'] as int,
                  color: Colors.brown,
                ),
              ],
            ),
          ),

          // Others
          Expanded(
            child: ListView.builder(
              itemCount: leaderboard.length - 3,
              itemBuilder: (context, index) {
                final player = leaderboard[index + 3];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Text(
                      '${player['rank']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(player['name'] as String),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${player['points']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TopPlayerCard extends StatelessWidget {
  final int rank;
  final String name;
  final int points;
  final Color color;
  final bool isFirst;

  const _TopPlayerCard({
    required this.rank,
    required this.name,
    required this.points,
    required this.color,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isFirst)
          const Icon(Icons.emoji_events, color: Colors.white, size: 40),
        const SizedBox(height: 8),
        CircleAvatar(
          radius: isFirst ? 40 : 30,
          backgroundColor: color,
          child: Text(
            '$rank',
            style: TextStyle(
              color: Colors.white,
              fontSize: isFirst ? 24 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$points نقطة',
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
