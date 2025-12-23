import 'package:equatable/equatable.dart';

enum AppointmentStatus {
  scheduled,
  confirmed,
  inProgress,
  completed,
  cancelled,
  noShow,
}

class Appointment extends Equatable {
  final String id;
  final String userId;
  final String businessId;
  final String serviceId;
  final String? employeeId;
  final DateTime scheduledTime;
  final Duration estimatedDuration;
  final AppointmentStatus status;
  final double totalPrice;
  final String? notes;
  final DateTime createdAt;
  final DateTime? confirmedAt;
  final DateTime? completedAt;
  final DateTime? cancelledAt;
  final String? cancellationReason;

  const Appointment({
    required this.id,
    required this.userId,
    required this.businessId,
    required this.serviceId,
    this.employeeId,
    required this.scheduledTime,
    required this.estimatedDuration,
    required this.status,
    required this.totalPrice,
    this.notes,
    required this.createdAt,
    this.confirmedAt,
    this.completedAt,
    this.cancelledAt,
    this.cancellationReason,
  });

  bool get canCancel =>
      status == AppointmentStatus.scheduled ||
      status == AppointmentStatus.confirmed;

  bool get canReschedule =>
      status == AppointmentStatus.scheduled ||
      status == AppointmentStatus.confirmed;

  @override
  List<Object?> get props => [
    id,
    userId,
    businessId,
    serviceId,
    employeeId,
    scheduledTime,
    estimatedDuration,
    status,
    totalPrice,
    notes,
    createdAt,
    confirmedAt,
    completedAt,
    cancelledAt,
    cancellationReason,
  ];
}
