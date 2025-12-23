import 'package:intl/intl.dart';

/// Date and time utility functions
class DateTimeUtils {
  /// Format DateTime to Arabic date string
  static String formatDate(DateTime date) {
    return DateFormat('yyyy/MM/dd', 'ar').format(date);
  }

  /// Format DateTime to Arabic time string
  static String formatTime(DateTime date) {
    return DateFormat('HH:mm', 'ar').format(date);
  }

  /// Format DateTime to full Arabic string
  static String formatDateTime(DateTime date) {
    return DateFormat('yyyy/MM/dd HH:mm', 'ar').format(date);
  }

  /// Get time ago string in Arabic
  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return formatDate(date);
    } else if (difference.inDays > 0) {
      return 'منذ ${difference.inDays} ${difference.inDays == 1 ? 'يوم' : 'أيام'}';
    } else if (difference.inHours > 0) {
      return 'منذ ${difference.inHours} ${difference.inHours == 1 ? 'ساعة' : 'ساعات'}';
    } else if (difference.inMinutes > 0) {
      return 'منذ ${difference.inMinutes} ${difference.inMinutes == 1 ? 'دقيقة' : 'دقائق'}';
    } else {
      return 'الآن';
    }
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if date is in the past
  static bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// Check if date is in the future
  static bool isFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  DateTimeUtils._();
}

/// String utility functions
class StringUtils {
  /// Check if string is valid email
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Check if string is valid phone number
  static bool isValidPhone(String phone) {
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    return phoneRegex.hasMatch(phone);
  }

  /// Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Truncate string with ellipsis
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Remove extra spaces
  static String removeExtraSpaces(String text) {
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  StringUtils._();
}

/// Number utility functions
class NumberUtils {
  /// Format number with Arabic numerals
  static String formatNumber(num number) {
    return NumberFormat('#,##0', 'ar').format(number);
  }

  /// Format currency (assuming KD - Kuwaiti Dinar)
  static String formatCurrency(double amount) {
    return '${NumberFormat('#,##0.00', 'ar').format(amount)} د.ك';
  }

  /// Format percentage
  static String formatPercentage(double value) {
    return '${NumberFormat('#,##0.#', 'ar').format(value)}%';
  }

  /// Format rating
  static String formatRating(double rating) {
    return NumberFormat('#,##0.0', 'ar').format(rating);
  }

  NumberUtils._();
}

/// Validation utility functions
class ValidationUtils {
  /// Validate email
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'يرجى إدخال البريد الإلكتروني';
    }
    if (!StringUtils.isValidEmail(email)) {
      return 'البريد الإلكتروني غير صحيح';
    }
    return null;
  }

  /// Validate password
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }
    if (password.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    return null;
  }

  /// Validate name
  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'يرجى إدخال الاسم';
    }
    if (name.length < 2) {
      return 'الاسم يجب أن يكون حرفين على الأقل';
    }
    return null;
  }

  /// Validate phone
  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'يرجى إدخال رقم الهاتف';
    }
    if (!StringUtils.isValidPhone(phone)) {
      return 'رقم الهاتف غير صحيح';
    }
    return null;
  }

  ValidationUtils._();
}
