import 'package:equatable/equatable.dart';

class Business extends Equatable {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final double rating;
  final String address;
  final bool isOpen;
  final int currentQueueLength;
  final String? phoneNumber;
  final int estimatedWaitTimeMinutes;
  final double latitude;
  final double longitude;

  const Business({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.address,
    required this.isOpen,
    required this.currentQueueLength,
    this.phoneNumber,
    required this.estimatedWaitTimeMinutes,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    category,
    imageUrl,
    rating,
    address,
    isOpen,
    currentQueueLength,
    phoneNumber,
    estimatedWaitTimeMinutes,
    latitude,
    longitude,
  ];
}
