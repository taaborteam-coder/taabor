import '../../domain/entities/analytics_data.dart';

class AnalyticsModel extends AnalyticsData {
  const AnalyticsModel({
    required super.totalBookings,
    required super.todayBookings,
    required super.totalRevenue,
    required super.todayRevenue,
    required super.averageRating,
    required super.totalReviews,
    required super.bookingsByDay,
    required super.revenueByDay,
  });

  factory AnalyticsModel.fromFirestore(Map<String, dynamic> data) {
    return AnalyticsModel(
      totalBookings: data['totalBookings'] ?? 0,
      todayBookings: data['todayBookings'] ?? 0,
      totalRevenue: (data['totalRevenue'] ?? 0).toDouble(),
      todayRevenue: (data['todayRevenue'] ?? 0).toDouble(),
      averageRating: (data['averageRating'] ?? 0).toDouble(),
      totalReviews: data['totalReviews'] ?? 0,
      bookingsByDay: Map<String, int>.from(data['bookingsByDay'] ?? {}),
      revenueByDay: Map<String, double>.from(
        (data['revenueByDay'] ?? {}).map(
          (key, value) => MapEntry(key, (value as num).toDouble()),
        ),
      ),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'totalBookings': totalBookings,
      'todayBookings': todayBookings,
      'totalRevenue': totalRevenue,
      'todayRevenue': todayRevenue,
      'averageRating': averageRating,
      'totalReviews': totalReviews,
      'bookingsByDay': bookingsByDay,
      'revenueByDay': revenueByDay,
    };
  }
}
