import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/review.dart';

/// Data model for review
class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.businessId,
    required super.userId,
    required super.userName,
    super.userPhotoUrl,
    required super.rating,
    required super.comment,
    super.imageUrls,
    required super.createdAt,
    super.updatedAt,
    super.helpfulCount,
    super.notHelpfulCount,
    super.merchantReply,
    super.merchantReplyDate,
    super.serviceId,
    super.serviceName,
  });

  /// Create from Firestore document
  factory ReviewModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ReviewModel(
      id: doc.id,
      businessId: data['businessId'] ?? '',
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      userPhotoUrl: data['userPhotoUrl'],
      rating: data['rating'] ?? 0,
      comment: data['comment'] ?? '',
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
      helpfulCount: data['helpfulCount'] ?? 0,
      notHelpfulCount: data['notHelpfulCount'] ?? 0,
      merchantReply: data['merchantReply'],
      merchantReplyDate: data['merchantReplyDate'] != null
          ? (data['merchantReplyDate'] as Timestamp).toDate()
          : null,
      serviceId: data['serviceId'],
      serviceName: data['serviceName'],
    );
  }

  /// Convert to Firestore map
  Map<String, dynamic> toFirestore() {
    return {
      'businessId': businessId,
      'userId': userId,
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
      'rating': rating,
      'comment': comment,
      'imageUrls': imageUrls,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'helpfulCount': helpfulCount,
      'notHelpfulCount': notHelpfulCount,
      'merchantReply': merchantReply,
      'merchantReplyDate': merchantReplyDate != null
          ? Timestamp.fromDate(merchantReplyDate!)
          : null,
      'serviceId': serviceId,
      'serviceName': serviceName,
    };
  }

  /// Copy with method
  ReviewModel copyWith({
    String? id,
    String? businessId,
    String? userId,
    String? userName,
    String? userPhotoUrl,
    int? rating,
    String? comment,
    List<String>? imageUrls,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? helpfulCount,
    int? notHelpfulCount,
    String? merchantReply,
    DateTime? merchantReplyDate,
    String? serviceId,
    String? serviceName,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userPhotoUrl: userPhotoUrl ?? this.userPhotoUrl,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      imageUrls: imageUrls ?? this.imageUrls,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      helpfulCount: helpfulCount ?? this.helpfulCount,
      notHelpfulCount: notHelpfulCount ?? this.notHelpfulCount,
      merchantReply: merchantReply ?? this.merchantReply,
      merchantReplyDate: merchantReplyDate ?? this.merchantReplyDate,
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
    );
  }
}
