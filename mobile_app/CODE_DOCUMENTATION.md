# Code Documentation Standards - Taabor

## Overview

This document outlines code documentation standards for the Taabor project.

## General Guidelines

### File Headers

Every Dart file should start with a brief description:

```dart
/// Service for managing user authentication.
///
/// Handles sign in, sign up, and session management using Firebase Auth.
/// Implements the repository pattern with error handling via Either.
class AuthService {
  // ...
}
```

### Class Documentation

```dart
/// Manages queue operations for businesses.
///
/// Provides methods to add tickets, update status, and stream real-time
/// queue updates. All operations return Either<Failure, Success> for
/// consistent error handling.
///
/// Example:
/// ```dart
/// final repository = QueueRepository(dataSource: dataSource);
/// final result = await repository.addTicket(
///   userId: 'user123',
///   businessId: 'business456',
/// );
/// ```
class QueueRepository {
  // ...
}
```

### Method Documentation

```dart
/// Adds a new ticket to the business queue.
///
/// Creates a ticket for the specified [userId] at [businessId].
/// Automatically assigns queue number and calculates wait time.
///
/// Returns [Right(Ticket)] on success or [Left(Failure)] on error.
///
/// Throws:
/// - [ServerException] if Firebase operation fails
/// - [ValidationException] if business doesn't exist
///
/// Example:
/// ```dart
/// final result = await addTicket(
///   userId: 'user123',
///   businessId: 'business456',
/// );
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (ticket) => print('Ticket #${ticket.queueNumber}'),
/// );
/// ```
Future<Either<Failure, Ticket>> addTicket({
  required String userId,
  required String businessId,
}) async {
  // Implementation
}
```

### Parameter Documentation

```dart
/// Searches for businesses based on criteria.
///
/// [query] - Search term for business name or category
/// [category] - Optional category filter
/// [latitude] - User's current latitude for distance calculation
/// [longitude] - User's current longitude
/// [radiusKm] - Maximum search radius in kilometers (default: 10)
Future<List<Business>> searchBusinesses({
  required String query,
  String? category,
  double? latitude,
  double? longitude,
  double radiusKm = 10.0,
}) async {
  // Implementation
}
```

## Layer-Specific Standards

### Domain Layer

#### Entities

```dart
/// Represents a business listing on the platform.
///
/// Immutable entity containing core business information.
/// Uses Equatable for value equality comparison.
class Business extends Equatable {
  /// Unique business identifier
  final String id;
  
  /// Business display name
  final String name;
  
  /// Business category (e.g., 'restaurant', 'salon')
  final String category;
  
  // ...
}
```

#### Use Cases

```dart
/// Use case for retrieving user's active tickets.
///
/// Fetches all tickets for the specified user that are not completed.
/// Results are ordered by creation date (newest first).
///
/// Follows the Clean Architecture use case pattern:
/// - Takes parameters via constructor
/// - Returns Either<Failure, Success>
/// - Single responsibility
class GetUserTickets implements UseCase<List<Ticket>, GetUserTicketsParams> {
  final QueueRepository repository;
  
  GetUserTickets(this.repository);
  
  @override
  Future<Either<Failure, List<Ticket>>> call(GetUserTicketsParams params) async {
    return await repository.getUserTickets(params.userId);
  }
}
```

### Data Layer

#### Models

```dart
/// Data model for Ticket entity.
///
/// Extends Ticket entity and adds serialization methods for Firestore.
/// Handles conversion between Firestore documents and domain entities.
class TicketModel extends Ticket {
  const TicketModel({
    required super.id,
    required super.businessId,
    // ...
  });
  
  /// Creates a TicketModel from Firestore document.
  ///
  /// [doc] - Firestore DocumentSnapshot
  /// Returns TicketModel with data from Firestore
  factory TicketModel.fromFirestore(DocumentSnapshot doc) {
    // ...
  }
  
  /// Converts model to Firestore-compatible map.
  ///
  /// Returns map suitable for Firestore document creation/update
  Map<String, dynamic> toFirestore() {
    // ...
  }
}
```

#### Data Sources

```dart
/// Remote data source for queue operations.
///
/// Handles all Firebase Firestore operations related to tickets.
/// Throws [ServerException] on any Firebase error.
abstract class QueueRemoteDataSource {
  /// Adds a new ticket to Firestore.
  ///
  /// Creates ticket document with auto-generated ID and server timestamp.
  /// Automatically increments queue counter for the business.
  Future<TicketModel> addTicket(String userId, String businessId);
  
  // ...
}
```

### Presentation Layer

#### BLoCs

```dart
/// BLoC managing authentication state.
///
/// Handles auth events (sign in, sign up, sign out) and maintains
/// authentication state. Uses Firebase Auth as backend.
///
/// States:
/// - [AuthInitial] - Initial state
/// - [AuthLoading] - Operation in progress
/// - [Authenticated] - User logged in
/// - [Unauthenticated] - User logged out
/// - [AuthError] - Error occurred
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // ...
}
```

#### Widgets

```dart
/// Custom animated button with loading state.
///
/// Displays a button with scale animation on press and optional
/// loading indicator. Prevents multiple taps while loading.
///
/// Example:
/// ```dart
/// AnimatedButton(
///   text: 'Sign In',
///   icon: Icons.login,
///   isLoading: isLoading,
///   onPressed: () => _handleSignIn(),
/// )
/// ```
class AnimatedButton extends StatefulWidget {
  /// Button text
  final String text;
  
  /// Optional leading icon
  final IconData? icon;
  
  /// Whether button is in loading state
  final bool isLoading;
  
  /// Callback when button is pressed
  final VoidCallback onPressed;
  
  // ...
}
```

## Testing Documentation

```dart
/// Tests for AuthBloc functionality.
///
/// Covers all auth events and state transitions:
/// - Sign in success/failure
/// - Sign up success/failure
/// - Sign out
/// - Initial state
group('AuthBloc', () {
  test('initial state should be AuthInitial', () {
    // ...
  });
  
  // ...
});
```

## TODO Comments

Use standardized TODO format:

```dart
// TODO(username): Add pagination support
// FIXME(username): Handle edge case when business is closed
// HACK(username): Temporary workaround for Firebase issue #123
```

## Deprecation

```dart
/// @deprecated Use [newMethod] instead. Will be removed in v2.0.
@Deprecated('Use newMethod instead')
void oldMethod() {
  // ...
}
```

## Best Practices

1. **Be Concise**: Documentation should be clear but brief
2. **Examples**: Include code examples for complex APIs
3. **Parameters**: Always document parameters and return values
4. **Errors**: Document possible exceptions and failures
5. **Links**: Reference related classes/methods with `[ClassName]`
6. **Update**: Keep documentation in sync with code changes

## Documentation Coverage

Target: **80%+ of public APIs documented**

Check documentation coverage:

```bash
dartdoc --validate-links
```

## References

- [Effective Dart: Documentation](https://dart.dev/guides/language/effective-dart/documentation)
- [DartDoc Guide](https://dart.dev/tools/dartdoc)
