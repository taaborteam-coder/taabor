import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/offer.dart';

class OfferModel extends Offer {
  const OfferModel({
    required super.id,
    required super.businessId,
    required super.title,
    required super.description,
    required super.discountType,
    required super.discountValue,
    required super.validFrom,
    required super.validTo,
    required super.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'businessId': businessId,
      'title': title,
      'description': description,
      'discountType': discountType.name,
      'discountValue': discountValue,
      'validFrom': Timestamp.fromDate(validFrom),
      'validTo': Timestamp.fromDate(validTo),
      'isActive': isActive,
    };
  }

  factory OfferModel.fromMap(Map<String, dynamic> map, String docId) {
    return OfferModel(
      id: docId,
      businessId: map['businessId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      discountType: DiscountType.values.firstWhere(
        (e) => e.name == (map['discountType'] ?? 'percentage'),
        orElse: () => DiscountType.percentage,
      ),
      discountValue: (map['discountValue'] as num?)?.toDouble() ?? 0.0,
      validFrom: (map['validFrom'] as Timestamp).toDate(),
      validTo: (map['validTo'] as Timestamp).toDate(),
      isActive: map['isActive'] ?? false,
    );
  }
}
