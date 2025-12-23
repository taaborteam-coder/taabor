import 'package:equatable/equatable.dart';

class Badge extends Equatable {
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final int requiredPoints;
  final DateTime? earnedAt;

  const Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.requiredPoints,
    this.earnedAt,
  });

  bool get isEarned => earnedAt != null;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    iconUrl,
    requiredPoints,
    earnedAt,
  ];
}

class Achievement extends Equatable {
  final String id;
  final String title;
  final String description;
  final String iconUrl;
  final int progress;
  final int target;
  final int rewardPoints;
  final bool isCompleted;
  final DateTime? completedAt;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
    required this.progress,
    required this.target,
    required this.rewardPoints,
    this.isCompleted = false,
    this.completedAt,
  });

  double get progressPercentage => (progress / target * 100).clamp(0, 100);

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    iconUrl,
    progress,
    target,
    rewardPoints,
    isCompleted,
    completedAt,
  ];
}

class LeaderboardEntry extends Equatable {
  final String userId;
  final String userName;
  final String? avatarUrl;
  final int points;
  final int rank;

  const LeaderboardEntry({
    required this.userId,
    required this.userName,
    this.avatarUrl,
    required this.points,
    required this.rank,
  });

  @override
  List<Object?> get props => [userId, userName, avatarUrl, points, rank];
}
