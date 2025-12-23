# Taabor Mobile App - API Documentation

## Overview

This document provides comprehensive API documentation for the Taabor mobile application.

## Architecture

The application follows Clean Architecture with three main layers:

- **Presentation Layer**: UI and state management (BLoC)
- **Domain Layer**: Business logic and use cases
- **Data Layer**: Data sources and repositories

---

## Core Services

### Authentication Service

**Location**: `lib/features/auth/`

#### Sign In

```dart
Future<Either<Failure, String>> signIn(String email, String password)
```

- **Parameters**:
  - `email`: User email address
  - `password`: User password
- **Returns**: `Either<Failure, String>` - User ID on success
- **Errors**: `ServerFailure`, `ValidationFailure`

#### Sign Up

```dart
Future<Either<Failure, String>> signUp(String email, String password, String name)
```

- **Parameters**:
  - `email`: User email
  - `password`: User password (min 8 chars, must contain uppercase and number)
  - `name`: User display name
- **Returns**: User ID on success

#### Sign Out

```dart
Future<Either<Failure, void>> signOut()
```

### Queue Management

**Location**: `lib/features/queue/`

#### Add Ticket

```dart
Future<Either<Failure, Ticket>> addTicket({
  required String userId,
  required String businessId,
})
```

- **Parameters**:
  - `userId`: Current user ID
  - `businessId`: Business to join
- **Returns**: Ticket entity with queue number and estimated wait time

#### Update Ticket Status

```dart
Future<Either<Failure, void>> updateTicketStatus(
  String ticketId,
  TicketStatus status,
)
```

- **Statuses**: `waiting`, `called`, `serving`, `completed`, `cancelled`

#### Stream Tickets

```dart
Stream<List<Ticket>> streamBusinessTickets(String businessId)
```

- **Returns**: Real-time stream of tickets for a business

### Business Discovery

**Location**: `lib/features/home/`

#### Get Businesses

```dart
Future<Either<Failure, List<Business>>> getBusinesses({
  String? category,
  double? latitude,
  double? longitude,
  double? radiusKm,
})
```

- **Parameters**:
  - `category`: Optional filter by category
  - `latitude`, `longitude`: User location
  - `radiusKm`: Search radius

#### Search Businesses

```dart
Future<Either<Failure, List<Business>>> searchBusinesses({
  required String query,
  SearchFilters? filters,
})
```

### Loyalty System

**Location**: `lib/features/loyalty/`

#### Get User Points

```dart
Future<Either<Failure, LoyaltyPoint>> getUserPoints(String userId)
```

- **Returns**: Current points, tier, and rewards

#### Redeem Reward

```dart
Future<Either<Failure, void>> redeemReward({
  required String userId,
  required String rewardId,
})
```

### Payment Processing

**Location**: `lib/features/payment/`

#### Create Payment

```dart
Future<Either<Failure, Payment>> createPayment({
  required String userId,
  required String bookingId,
  required double amount,
  required PaymentMethod method,
})
```

- **Payment Methods**: `cash`, `card`, `wallet`

#### Process Payment

```dart
Future<Either<Failure, Payment>> processPayment(String paymentId)
```

### Chat System

**Location**: `lib/features/chat/`

#### Send Message

```dart
Future<Either<Failure, void>> sendMessage(Message message)
```

#### Stream Messages

```dart
Stream<List<Message>> streamChatMessages(String chatId)
```

### Analytics

**Location**: `lib/features/analytics/`

#### Get Business Analytics

```dart
Future<Either<Failure, AnalyticsData>> getBusinessAnalytics(
  String businessId, {
  DateTime? startDate,
  DateTime? endDate,
})
```

---

## State Management (BLoC)

### Auth BLoC

**Events**:

- `SignInEvent(email, password)`
- `SignUpEvent(email, password, name)`
- `SignOutEvent()`
- `CheckAuthEvent()`

**States**:

- `AuthInitial()`
- `AuthLoading()`
- `Authenticated(userId)`
- `Unauthenticated()`
- `AuthError(message)`

### Queue BLoC

**Events**:

- `AddTicketEvent(businessId)`
- `LoadBusinessTicketsEvent(businessId)`
- `UpdateTicketStatusEvent(ticketId, status)`

**States**:

- `QueueInitial()`
- `QueueLoading()`
- `QueueLoaded(tickets)`
- `TicketAdded(ticket)`
- `QueueError(message)`

---

## Data Models

### Ticket Model

```dart
class Ticket {
  final String id;
  final String businessId;
  final String userId;
  final int queueNumber;
  final TicketStatus status;
  final String createdAt;
  final int? estimatedWaitTime;
}
```

### Business Model

```dart
class Business {
  final String id;
  final String name;
  final String category;
  final String address;
  final String? phone;
  final double? latitude;
  final double? longitude;
  final double? rating;
  final int? currentQueueSize;
}
```

### Payment Model

```dart
class Payment {
  final String id;
  final String userId;
  final String bookingId;
  final double amount;
  final PaymentMethod method;
  final PaymentStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
}
```

---

## Error Handling

All use cases return `Either<Failure, Success>` type:

**Failure Types**:

- `ServerFailure`: Server/network errors
- `CacheFailure`: Local cache errors
- `ValidationFailure`: Input validation errors

**Example Usage**:

```dart
final result = await signIn(email, password);
result.fold(
  (failure) => print('Error: ${failure.message}'),
  (userId) => print('Success: $userId'),
);
```

---

## Firebase Collections

### Users

**Path**: `/users/{userId}`

```json
{
  "email": "user@example.com",
  "name": "John Doe",
  "phone": "07501234567",
  "role": "user",
  "createdAt": "2024-01-01T00:00:00Z",
  "loyaltyPoints": 100,
  "tier": "silver"
}
```

### Businesses

**Path**: `/businesses/{businessId}`

```json
{
  "name": "Business Name",
  "category": "restaurant",
  "address": "123 Street",
  "latitude": 36.1925,
  "longitude": 44.0092,
  "rating": 4.5,
  "currentQueueSize": 5
}
```

### Tickets

**Path**: `/tickets/{ticketId}`

```json
{
  "businessId": "business123",
  "userId": "user123",
  "queueNumber": 5,
  "status": "waiting",
  "createdAt": "2024-01-01T12:00:00Z",
  "estimatedWaitTime": 30
}
```

---

## Performance Best Practices

1. **Pagination**: Use `limit()` and `startAfter()` for large lists
2. **Caching**: Cache frequently accessed data locally
3. **Optimistic Updates**: Update UI immediately, sync in background
4. **Error Recovery**: Implement retry logic for failed operations
5. **Monitoring**: Use Firebase Performance for API call tracking

---

## Versioning

**Current Version**: 1.0.0  
**API Compatibility**: Firebase SDK 10.x+  
**Flutter Version**: 3.10+

---

## Support

For issues or questions:

- GitHub: [taabor/mobile_app](https://github.com/taabor)
- Email: <support@taabor.com>
