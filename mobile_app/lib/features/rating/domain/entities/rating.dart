import 'package:equatable/equatable.dart';

/// Rating entity representing a business rating
class RatingEntity extends Equatable {
  final String id;
  final String businessId;
  final String userId;
  final String userName;
  final int rating; // 1-5 stars
  final DateTime createdAt;
  final DateTime? updatedAt;

  const RatingEntity({
    required this.id,
    required this.businessId,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    businessId,
    userId,
    userName,
    rating,
    createdAt,
    updatedAt,
  ];
}
