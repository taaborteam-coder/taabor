import 'package:equatable/equatable.dart';

/// Reward entity
class Reward extends Equatable {
  final String id;
  final String title;
  final String description;
  final int pointsCost;
  final String? imageUrl;
  final RewardType type;
  final double? discountValue; // percentage or fixed amount
  final String? businessId; // null = applicable to all businesses
  final DateTime? expiresAt;
  final bool isActive;

  const Reward({
    required this.id,
    required this.title,
    required this.description,
    required this.pointsCost,
    this.imageUrl,
    required this.type,
    this.discountValue,
    this.businessId,
    this.expiresAt,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    pointsCost,
    imageUrl,
    type,
    discountValue,
    businessId,
    expiresAt,
    isActive,
  ];
}

/// Types of rewards
enum RewardType {
  percentageDiscount,
  fixedDiscount,
  freeService,
  priorityBooking,
  other,
}
