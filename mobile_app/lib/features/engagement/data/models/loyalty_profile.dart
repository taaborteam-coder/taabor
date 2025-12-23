class LoyaltyProfile {
  final String id;
  final String businessId;
  final String userId;
  final int points;
  final int completedVisits;
  final List<String> rewards;

  LoyaltyProfile({
    required this.id,
    required this.businessId,
    required this.userId,
    required this.points,
    required this.completedVisits,
    required this.rewards,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'businessId': businessId,
      'userId': userId,
      'points': points,
      'completedVisits': completedVisits,
      'rewards': rewards,
    };
  }

  factory LoyaltyProfile.fromMap(Map<String, dynamic> map, String docId) {
    return LoyaltyProfile(
      id: docId,
      businessId: map['businessId'] ?? '',
      userId: map['userId'] ?? '',
      points: map['points'] ?? 0,
      completedVisits: map['completedVisits'] ?? 0,
      rewards: List<String>.from(map['rewards'] ?? []),
    );
  }
}
