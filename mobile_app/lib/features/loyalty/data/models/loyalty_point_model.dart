import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/loyalty_point.dart';

class LoyaltyPointModel extends LoyaltyPoint {
  const LoyaltyPointModel({
    required super.id,
    required super.userId,
    required super.points,
    required super.source,
    super.referenceId,
    required super.earnedAt,
    super.expiresAt,
  });

  factory LoyaltyPointModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LoyaltyPointModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      points: data['points'] ?? 0,
      source: data['source'] ?? '',
      referenceId: data['referenceId'],
      earnedAt: (data['earnedAt'] as Timestamp).toDate(),
      expiresAt: data['expiresAt'] != null
          ? (data['expiresAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'points': points,
      'source': source,
      'referenceId': referenceId,
      'earnedAt': Timestamp.fromDate(earnedAt),
      'expiresAt': expiresAt != null ? Timestamp.fromDate(expiresAt!) : null,
    };
  }
}
