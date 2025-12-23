import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/appointment_model.dart';
import '../../domain/entities/appointment.dart';

abstract class AppointmentRemoteDataSource {
  Future<AppointmentModel> createAppointment(AppointmentModel appointment);
  Future<List<AppointmentModel>> getUserAppointments(
    String userId, {
    AppointmentStatus? status,
  });
  Future<List<AppointmentModel>> getBusinessAppointments(
    String businessId, {
    DateTime? date,
  });
  Future<AppointmentModel> getAppointmentById(String id);
  Future<void> cancelAppointment(String id, String reason);
  Future<AppointmentModel> rescheduleAppointment(String id, DateTime newTime);
  Future<void> confirmAppointment(String id);
  Future<void> completeAppointment(String id);
  Future<List<DateTime>> getAvailableSlots(
    String businessId,
    DateTime date, {
    String? employeeId,
  });
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final FirebaseFirestore firestore;

  AppointmentRemoteDataSourceImpl({required this.firestore});

  @override
  Future<AppointmentModel> createAppointment(
    AppointmentModel appointment,
  ) async {
    final docRef = await firestore
        .collection('appointments')
        .add(appointment.toFirestore());
    final doc = await docRef.get();
    return AppointmentModel.fromFirestore(doc);
  }

  @override
  Future<List<AppointmentModel>> getUserAppointments(
    String userId, {
    AppointmentStatus? status,
  }) async {
    Query query = firestore
        .collection('appointments')
        .where('userId', isEqualTo: userId)
        .orderBy('scheduledTime', descending: true);

    if (status != null) {
      query = query.where('status', isEqualTo: status.name);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => AppointmentModel.fromFirestore(doc))
        .toList();
  }

  @override
  Future<List<AppointmentModel>> getBusinessAppointments(
    String businessId, {
    DateTime? date,
  }) async {
    Query query = firestore
        .collection('appointments')
        .where('businessId', isEqualTo: businessId);

    if (date != null) {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));
      query = query
          .where(
            'scheduledTime',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
          )
          .where('scheduledTime', isLessThan: Timestamp.fromDate(endOfDay));
    }

    query = query.orderBy('scheduledTime');

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => AppointmentModel.fromFirestore(doc))
        .toList();
  }

  @override
  Future<AppointmentModel> getAppointmentById(String id) async {
    final doc = await firestore.collection('appointments').doc(id).get();
    return AppointmentModel.fromFirestore(doc);
  }

  @override
  Future<void> cancelAppointment(String id, String reason) async {
    await firestore.collection('appointments').doc(id).update({
      'status': AppointmentStatus.cancelled.name,
      'cancelledAt': FieldValue.serverTimestamp(),
      'cancellationReason': reason,
    });
  }

  @override
  Future<AppointmentModel> rescheduleAppointment(
    String id,
    DateTime newTime,
  ) async {
    await firestore.collection('appointments').doc(id).update({
      'scheduledTime': Timestamp.fromDate(newTime),
    });
    final doc = await firestore.collection('appointments').doc(id).get();
    return AppointmentModel.fromFirestore(doc);
  }

  @override
  Future<void> confirmAppointment(String id) async {
    await firestore.collection('appointments').doc(id).update({
      'status': AppointmentStatus.confirmed.name,
      'confirmedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> completeAppointment(String id) async {
    await firestore.collection('appointments').doc(id).update({
      'status': AppointmentStatus.completed.name,
      'completedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<List<DateTime>> getAvailableSlots(
    String businessId,
    DateTime date, {
    String? employeeId,
  }) async {
    // Get business operating hours (simplified)
    // In a real app, use: final businessDoc = await firestore.collection('businesses').doc(businessId).get();
    final openTime = 9; // 9 AM
    final closeTime = 18; // 6 PM
    final slotDuration = 30; // 30 minutes

    // Get existing appointments for the day
    final startOfDay = DateTime(date.year, date.month, date.day, openTime);
    final endOfDay = DateTime(date.year, date.month, date.day, closeTime);

    Query query = firestore
        .collection('appointments')
        .where('businessId', isEqualTo: businessId)
        .where(
          'scheduledTime',
          isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
        )
        .where('scheduledTime', isLessThan: Timestamp.fromDate(endOfDay))
        .where(
          'status',
          whereIn: [
            AppointmentStatus.scheduled.name,
            AppointmentStatus.confirmed.name,
            AppointmentStatus.inProgress.name,
          ],
        );

    if (employeeId != null) {
      query = query.where('employeeId', isEqualTo: employeeId);
    }

    final snapshot = await query.get();
    final bookedSlots = snapshot.docs
        .map(
          (doc) =>
              ((doc.data() as Map<String, dynamic>)['scheduledTime']
                      as Timestamp)
                  .toDate(),
        )
        .toList();

    // Generate available slots
    final List<DateTime> availableSlots = [];
    DateTime currentSlot = startOfDay;

    while (currentSlot.isBefore(endOfDay)) {
      // Check if slot is not booked
      final isBooked = bookedSlots.any(
        (booked) =>
            currentSlot.isAfter(
              booked.subtract(Duration(minutes: slotDuration)),
            ) &&
            currentSlot.isBefore(booked.add(Duration(minutes: slotDuration))),
      );

      if (!isBooked && currentSlot.isAfter(DateTime.now())) {
        availableSlots.add(currentSlot);
      }

      currentSlot = currentSlot.add(Duration(minutes: slotDuration));
    }

    return availableSlots;
  }
}
