import 'package:flutter/material.dart';
import '../../domain/entities/membership_tier.dart';

class TierCard extends StatelessWidget {
  final MembershipTierEntity tier;

  const TierCard({super.key, required this.tier});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_getTierIcon(), color: _getTierColor(), size: 32),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'المستوى الحالي',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      _getTierName(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _getTierColor(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Progress to next tier
            if (tier.pointsToNextTier != null) ...[
              Text(
                'متبقي ${tier.pointsToNextTier} نقطة للمستوى التالي',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: _getProgress(),
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(_getTierColor()),
              ),
            ] else ...[
              const Text(
                '🎉 لقد وصلت لأعلى مستوى!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],

            const SizedBox(height: 16),

            // Benefits
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getTierColor().withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.local_offer, color: _getTierColor()),
                  const SizedBox(width: 8),
                  Text(
                    'خصم ${tier.tier.discountPercentage.toStringAsFixed(0)}% على جميع الحجوزات',
                    style: TextStyle(
                      color: _getTierColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTierName() {
    switch (tier.tier) {
      case MembershipTier.bronze:
        return 'برونزي';
      case MembershipTier.silver:
        return 'فضي';
      case MembershipTier.gold:
        return 'ذهبي';
    }
  }

  IconData _getTierIcon() {
    switch (tier.tier) {
      case MembershipTier.bronze:
        return Icons.military_tech;
      case MembershipTier.silver:
        return Icons.workspace_premium;
      case MembershipTier.gold:
        return Icons.emoji_events;
    }
  }

  Color _getTierColor() {
    switch (tier.tier) {
      case MembershipTier.bronze:
        return Colors.brown;
      case MembershipTier.silver:
        return Colors.grey;
      case MembershipTier.gold:
        return Colors.amber;
    }
  }

  double _getProgress() {
    if (tier.pointsToNextTier == null) return 1.0;

    final nextTierMin = tier.tier == MembershipTier.bronze
        ? MembershipTier.silver.minPoints
        : MembershipTier.gold.minPoints;
    final currentTierMin = tier.tier.minPoints;
    final range = nextTierMin - currentTierMin;
    final progress = tier.currentPoints - currentTierMin;

    return progress / range;
  }
}
