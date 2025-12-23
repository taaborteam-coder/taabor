import '../../features/home/data/models/business_model.dart';
import '../../features/queue/data/models/ticket_model.dart';
import '../../features/queue/domain/entities/ticket.dart';

class InMemoryStore {
  static final InMemoryStore _instance = InMemoryStore._internal();
  factory InMemoryStore() => _instance;
  InMemoryStore._internal();

  // Mock Database Tables
  final List<BusinessModel> businesses = [
    BusinessModel(
      id: '1',
      name: 'صالون الأناقة',
      category: 'صالون حلاقة',
      imageUrl: 'https://placeholder.com/150',
      rating: 4.5,
      address: 'بغداد، المنصور',
      isOpen: true,
      currentQueueLength: 3,
      estimatedWaitTimeMinutes: 45,
      latitude: 33.3152, // Baghdad
      longitude: 44.3661,
    ),
    BusinessModel(
      id: '2',
      name: 'عيادة الدكتورة سارة',
      category: 'عيادة أسنان',
      imageUrl: 'https://placeholder.com/150',
      rating: 4.9,
      address: 'أربيل، شارع 100',
      isOpen: true,
      currentQueueLength: 5,
      estimatedWaitTimeMinutes: 90,
      latitude: 36.1901, // Erbil
      longitude: 44.0091,
    ),
  ];

  final List<TicketModel> tickets = [
    TicketModel(
      id: 't1',
      userId: 'u1',
      businessId: '1',
      serviceName: 'حلاقة شعر',
      ticketNumber: 4,
      status: TicketStatus.active,
      type: TicketType.regular,
      createdAt: DateTime.now(),
    ),
    TicketModel(
      id: 't2',
      userId: 'u2',
      businessId: '1',
      serviceName: 'حلاقة ذقن',
      ticketNumber: 5,
      status: TicketStatus.pending,
      type: TicketType.regular,
      createdAt: DateTime.now().add(const Duration(minutes: 5)),
    ),
  ];

  // Methods
  void addTicket(TicketModel ticket) {
    tickets.add(ticket);
    // Update business queue length
    final index = businesses.indexWhere((b) => b.id == ticket.businessId);
    if (index != -1) {
      // logic to update wait time would go here
    }
  }

  void completeCurrentTicket(String businessId) {
    // Find active ticket for business
    final activeIndex = tickets.indexWhere(
      (t) => t.businessId == businessId,
    ); // Simplified queue logic
    if (activeIndex != -1) {
      tickets.removeAt(activeIndex);
    }
  }
}
