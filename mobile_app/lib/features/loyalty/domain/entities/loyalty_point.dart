import 'package:equatable/equatable.dart';

/// Loyalty point entity
class LoyaltyPoint extends Equatable {
  final String id;
  final String userId;
  final int points;
  final String source; // 'booking', 'referral', 'bonus'
  final String? referenceId; // booking ID, referral code, etc.
  final DateTime earnedAt;
  final DateTime? expiresAt;

  const LoyaltyPoint({
    required this.id,
    required this.userId,
    required this.points,
    required this.source,
    this.referenceId,
    required this.earnedAt,
    this.expiresAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    points,
    source,
    referenceId,
    earnedAt,
    expiresAt,
  ];
}
