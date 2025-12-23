class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://api.taabor.com/v1';
  static const String firebaseUrl = 'https://firestore.googleapis.com/v1';

  // Endpoints
  static const String businesses = '/businesses';
  static const String tickets = '/tickets';
  static const String users = '/users';
  static const String reviews = '/reviews';
  static const String payments = '/payments';
  static const String notifications = '/notifications';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
