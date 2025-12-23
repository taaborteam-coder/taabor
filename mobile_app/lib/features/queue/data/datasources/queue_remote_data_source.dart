import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/logging/app_logger.dart';
import '../models/ticket_model.dart';
import '../../domain/entities/ticket.dart';

abstract class QueueRemoteDataSource {
  Future<String> addTicket(TicketModel ticket);
  Stream<List<TicketModel>> streamTicketsForBusiness(String businessId);
  Future<void> updateTicketStatus(String ticketId, TicketStatus status);
  Future<List<TicketModel>> getUserTickets(String userId);
}

class QueueRemoteDataSourceImpl implements QueueRemoteDataSource {
  final FirebaseFirestore firestore;

  QueueRemoteDataSourceImpl(this.firestore);

  @override
  Future<String> addTicket(TicketModel ticket) async {
    try {
      final data = ticket.toFirestore();
      if (ticket.id.isEmpty) {
        AppLogger.info('Adding new ticket');
        final ref = await firestore.collection('bookings').add(data);
        return ref.id;
      } else {
        AppLogger.info('Setting ticket with ID: ${ticket.id}');
        await firestore.collection('bookings').doc(ticket.id).set(data);
        return ticket.id;
      }
    } catch (e) {
      AppLogger.error('Error adding ticket', e);
      throw ServerException();
    }
  }

  @override
  Stream<List<TicketModel>> streamTicketsForBusiness(String businessId) {
    return firestore
        .collection('bookings')
        .where('businessId', isEqualTo: businessId)
        .orderBy('createdAt')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => TicketModel.fromFirestore(doc))
              .toList();
        })
        .handleError((error) {
          AppLogger.error('Error streaming tickets', error);
          throw ServerException();
        });
  }

  @override
  Future<List<TicketModel>> getUserTickets(String userId) async {
    try {
      final snapshot = await firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => TicketModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      AppLogger.error('Error fetching user tickets', e);
      throw ServerException();
    }
  }

  @override
  Future<void> updateTicketStatus(String ticketId, TicketStatus status) async {
    try {
      AppLogger.info('Updating ticket status: $ticketId to ${status.name}');
      await firestore.collection('bookings').doc(ticketId).update({
        'status': status.name,
      });
    } catch (e) {
      AppLogger.error('Error updating ticket status', e);
      throw ServerException();
    }
  }
}
