import 'package:equatable/equatable.dart';

class FavoriteEntity extends Equatable {
  final String id;
  final String userId;
  final String businessId;
  final DateTime addedAt;

  const FavoriteEntity({
    required this.id,
    required this.userId,
    required this.businessId,
    required this.addedAt,
  });

  @override
  List<Object?> get props => [id, userId, businessId, addedAt];
}
