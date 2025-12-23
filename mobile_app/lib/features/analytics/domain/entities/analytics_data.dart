import 'package:equatable/equatable.dart';

class AnalyticsData extends Equatable {
  final int totalBookings;
  final int todayBookings;
  final double totalRevenue;
  final double todayRevenue;
  final double averageRating;
  final int totalReviews;
  final Map<String, int> bookingsByDay;
  final Map<String, double> revenueByDay;

  const AnalyticsData({
    required this.totalBookings,
    required this.todayBookings,
    required this.totalRevenue,
    required this.todayRevenue,
    required this.averageRating,
    required this.totalReviews,
    required this.bookingsByDay,
    required this.revenueByDay,
  });

  @override
  List<Object?> get props => [
    totalBookings,
    todayBookings,
    totalRevenue,
    todayRevenue,
    averageRating,
    totalReviews,
    bookingsByDay,
    revenueByDay,
  ];
}
