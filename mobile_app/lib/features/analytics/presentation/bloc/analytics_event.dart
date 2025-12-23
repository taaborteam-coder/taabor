part of 'analytics_bloc.dart';

abstract class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();

  @override
  List<Object?> get props => [];
}

class LoadAnalytics extends AnalyticsEvent {
  final String businessId;
  final DateTime? startDate;
  final DateTime? endDate;

  const LoadAnalytics({required this.businessId, this.startDate, this.endDate});

  @override
  List<Object?> get props => [businessId, startDate, endDate];
}
