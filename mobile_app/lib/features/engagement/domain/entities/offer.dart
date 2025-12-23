import 'package:equatable/equatable.dart';

enum DiscountType { percentage, fixed, freebie }

class Offer extends Equatable {
  final String id;
  final String businessId;
  final String title;
  final String description;
  final DiscountType discountType;
  final double discountValue;
  final DateTime validFrom;
  final DateTime validTo;
  final bool isActive;

  const Offer({
    required this.id,
    required this.businessId,
    required this.title,
    required this.description,
    required this.discountType,
    required this.discountValue,
    required this.validFrom,
    required this.validTo,
    required this.isActive,
  });

  bool get isValid {
    final now = DateTime.now();
    return isActive && now.isAfter(validFrom) && now.isBefore(validTo);
  }

  @override
  List<Object?> get props => [
    id,
    businessId,
    title,
    description,
    discountType,
    discountValue,
    validFrom,
    validTo,
    isActive,
  ];
}
