import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/appointment.dart';

class AppointmentModel extends Appointment {
  const AppointmentModel({
    required super.id,
    required super.userId,
    required super.businessId,
    required super.serviceId,
    super.employeeId,
    required super.scheduledTime,
    required super.estimatedDuration,
    required super.status,
    required super.totalPrice,
    super.notes,
    required super.createdAt,
    super.confirmedAt,
    super.completedAt,
    super.cancelledAt,
    super.cancellationReason,
  });

  factory AppointmentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppointmentModel(
      id: doc.id,
      userId: data['userId'],
      businessId: data['businessId'],
      serviceId: data['serviceId'],
      employeeId: data['employeeId'],
      scheduledTime: (data['scheduledTime'] as Timestamp).toDate(),
      estimatedDuration: Duration(minutes: data['estimatedDuration']),
      status: AppointmentStatus.values.firstWhere(
        (e) => e.name == data['status'],
      ),
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      notes: data['notes'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      confirmedAt: data['confirmedAt'] != null
          ? (data['confirmedAt'] as Timestamp).toDate()
          : null,
      completedAt: data['completedAt'] != null
          ? (data['completedAt'] as Timestamp).toDate()
          : null,
      cancelledAt: data['cancelledAt'] != null
          ? (data['cancelledAt'] as Timestamp).toDate()
          : null,
      cancellationReason: data['cancellationReason'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'businessId': businessId,
      'serviceId': serviceId,
      'employeeId': employeeId,
      'scheduledTime': Timestamp.fromDate(scheduledTime),
      'estimatedDuration': estimatedDuration.inMinutes,
      'status': status.name,
      'totalPrice': totalPrice,
      'notes': notes,
      'createdAt': Timestamp.fromDate(createdAt),
      'confirmedAt': confirmedAt != null
          ? Timestamp.fromDate(confirmedAt!)
          : null,
      'completedAt': completedAt != null
          ? Timestamp.fromDate(completedAt!)
          : null,
      'cancelledAt': cancelledAt != null
          ? Timestamp.fromDate(cancelledAt!)
          : null,
      'cancellationReason': cancellationReason,
    };
  }
}
