import 'package:equatable/equatable.dart';

/// Review entity representing a detailed business review
class ReviewEntity extends Equatable {
  final String id;
  final String businessId;
  final String userId;
  final String userName;
  final String? userPhotoUrl;
  final int rating; // 1-5 stars
  final String comment;
  final List<String> imageUrls;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int helpfulCount;
  final int notHelpfulCount;

  // Merchant reply
  final String? merchantReply;
  final DateTime? merchantReplyDate;

  // Service info (optional)
  final String? serviceId;
  final String? serviceName;

  const ReviewEntity({
    required this.id,
    required this.businessId,
    required this.userId,
    required this.userName,
    this.userPhotoUrl,
    required this.rating,
    required this.comment,
    this.imageUrls = const [],
    required this.createdAt,
    this.updatedAt,
    this.helpfulCount = 0,
    this.notHelpfulCount = 0,
    this.merchantReply,
    this.merchantReplyDate,
    this.serviceId,
    this.serviceName,
  });

  @override
  List<Object?> get props => [
    id,
    businessId,
    userId,
    userName,
    userPhotoUrl,
    rating,
    comment,
    imageUrls,
    createdAt,
    updatedAt,
    helpfulCount,
    notHelpfulCount,
    merchantReply,
    merchantReplyDate,
    serviceId,
    serviceName,
  ];
}
