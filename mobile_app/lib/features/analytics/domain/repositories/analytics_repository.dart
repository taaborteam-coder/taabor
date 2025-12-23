import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/analytics_data.dart';

abstract class AnalyticsRepository {
  Future<Either<Failure, AnalyticsData>> getBusinessAnalytics(
    String businessId, {
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<Either<Failure, Map<String, dynamic>>> getRevenueReport(
    String businessId,
    DateTime startDate,
    DateTime endDate,
  );

  Future<Either<Failure, Map<String, dynamic>>> getBookingReport(
    String businessId,
    DateTime startDate,
    DateTime endDate,
  );

  Future<Either<Failure, List<Map<String, dynamic>>>> getPeakHours(
    String businessId,
  );
}
