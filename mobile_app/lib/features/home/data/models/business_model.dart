import '../../domain/entities/business.dart';

class BusinessModel extends Business {
  const BusinessModel({
    required super.id,
    required super.name,
    required super.category,
    required super.imageUrl,
    required super.rating,
    required super.address,
    required super.isOpen,
    required super.currentQueueLength,
    super.phoneNumber,
    required super.estimatedWaitTimeMinutes,
    required super.latitude,
    required super.longitude,
  });

  factory BusinessModel.fromMap(Map<String, dynamic> map, String id) {
    return BusinessModel(
      id: id,
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      address: map['address'] ?? '',
      isOpen: map['isOpen'] ?? false,
      currentQueueLength: map['currentQueueLength'] ?? 0,
      phoneNumber: map['phoneNumber'],
      estimatedWaitTimeMinutes: (map['estimatedWaitTimeMinutes'] ?? 0) as int,
      latitude: (map['latitude'] ?? 0.0).toDouble(),
      longitude: (map['longitude'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'imageUrl': imageUrl,
      'rating': rating,
      'address': address,
      'isOpen': isOpen,
      'currentQueueLength': currentQueueLength,
      'estimatedWaitTimeMinutes': estimatedWaitTimeMinutes,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
