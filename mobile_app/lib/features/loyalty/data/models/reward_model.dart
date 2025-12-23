import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/reward.dart';

class RewardModel extends Reward {
  const RewardModel({
    required super.id,
    required super.title,
    required super.description,
    required super.pointsCost,
    super.imageUrl,
    required super.type,
    super.discountValue,
    super.businessId,
    super.expiresAt,
    super.isActive,
  });

  factory RewardModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RewardModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      pointsCost: data['pointsCost'] ?? 0,
      imageUrl: data['imageUrl'],
      type: _parseRewardType(data['type']),
      discountValue: data['discountValue']?.toDouble(),
      businessId: data['businessId'],
      expiresAt: data['expiresAt'] != null
          ? (data['expiresAt'] as Timestamp).toDate()
          : null,
      isActive: data['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'pointsCost': pointsCost,
      'imageUrl': imageUrl,
      'type': type.name,
      'discountValue': discountValue,
      'businessId': businessId,
      'expiresAt': expiresAt != null ? Timestamp.fromDate(expiresAt!) : null,
      'isActive': isActive,
    };
  }

  static RewardType _parseRewardType(dynamic typeValue) {
    if (typeValue == null) return RewardType.other;
    final typeStr = typeValue.toString();
    return RewardType.values.firstWhere(
      (e) => e.name == typeStr,
      orElse: () => RewardType.other,
    );
  }
}
