import 'package:equatable/equatable.dart';

class SearchFilters extends Equatable {
  final String? category;
  final double? minRating;
  final double? maxDistance; // in km
  final bool? isOpen;
  final List<String>? services;

  const SearchFilters({
    this.category,
    this.minRating,
    this.maxDistance,
    this.isOpen,
    this.services,
  });

  SearchFilters copyWith({
    String? category,
    double? minRating,
    double? maxDistance,
    bool? isOpen,
    List<String>? services,
  }) {
    return SearchFilters(
      category: category ?? this.category,
      minRating: minRating ?? this.minRating,
      maxDistance: maxDistance ?? this.maxDistance,
      isOpen: isOpen ?? this.isOpen,
      services: services ?? this.services,
    );
  }

  @override
  List<Object?> get props => [
    category,
    minRating,
    maxDistance,
    isOpen,
    services,
  ];
}
