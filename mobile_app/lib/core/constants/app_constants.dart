/// App-wide constants and configuration values
class AppConstants {
  // App Info
  static const String appName = 'Taabor';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'نظام ذكي لإدارة الطوابير والحجوزات';

  // API & Backend
  static const String firebaseProjectId = 'taabor-app';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;

  // Timeouts
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const Duration shortTimeout = Duration(seconds: 10);
  static const Duration longTimeout = Duration(minutes: 2);

  // Cache
  static const Duration cacheTimeout = Duration(hours: 1);
  static const int maxCacheSize = 100;

  // UI
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  static const double borderRadius = 12.0;
  static const double smallBorderRadius = 8.0;
  static const double largeBorderRadius = 16.0;

  // Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Validation
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 128;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;

  // Ticket
  static const int maxTicketQueueLength = 100;
  static const Duration ticketTimeout = Duration(hours: 4);

  // Business
  static const double minRating = 0.0;
  static const double maxRating = 5.0;
  static const int maxSearchRadius = 50; // km

  // Offer
  static const double maxDiscountPercentage = 100.0;
  static const int maxActiveOffersPerBusiness = 10;

  // Error messages (Arabic)
  static const String networkError = 'خطأ في الاتصال بالإنترنت';
  static const String serverError = 'خطأ في الخادم';
  static const String unknownError = 'حدث خطأ غير متوقع';
  static const String authError = 'خطأ في المصادقة';
  static const String permissionError = 'لا تملك الصلاحيات الكافية';

  // Success messages (Arabic)
  static const String loginSuccess = 'تم تسجيل الدخول بنجاح';
  static const String registerSuccess = 'تم إنشاء الحساب بنجاح';
  static const String ticketBooked = 'تم حجز التذكرة بنجاح';
  static const String profileUpdated = 'تم تحديث الملف الشخصي';

  // Storage keys
  static const String keyAuthToken = 'auth_token';
  static const String keyUserId = 'user_id';
  static const String keyLanguage = 'language';
  static const String keyThemeMode = 'theme_mode';

  // Regular expressions
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

  // Private constructor to prevent instantiation
  AppConstants._();
}

/// User roles
class UserRoles {
  static const String customer = 'customer';
  static const String businessOwner = 'business_owner';
  static const String admin = 'admin';

  UserRoles._();
}

/// Route names
class Routes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String businessDetails = '/business-details';
  static const String ticketStatus = '/ticket-status';
  static const String profile = '/profile';
  static const String offers = '/offers';
  static const String map = '/map';

  Routes._();
}
