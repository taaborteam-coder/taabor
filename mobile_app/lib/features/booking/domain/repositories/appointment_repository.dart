import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/appointment.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, Appointment>> createAppointment({
    required String userId,
    required String businessId,
    required String serviceId,
    String? employeeId,
    required DateTime scheduledTime,
    String? notes,
  });

  Future<Either<Failure, List<Appointment>>> getUserAppointments(
    String userId, {
    AppointmentStatus? status,
  });

  Future<Either<Failure, List<Appointment>>> getBusinessAppointments(
    String businessId, {
    DateTime? date,
  });

  Future<Either<Failure, Appointment>> getAppointmentById(String id);

  Future<Either<Failure, void>> cancelAppointment(String id, String reason);

  Future<Either<Failure, Appointment>> rescheduleAppointment(
    String id,
    DateTime newTime,
  );

  Future<Either<Failure, void>> confirmAppointment(String id);

  Future<Either<Failure, void>> completeAppointment(String id);

  Future<Either<Failure, List<DateTime>>> getAvailableSlots(
    String businessId,
    DateTime date, {
    String? employeeId,
  });
}
