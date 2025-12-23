import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Taabor',
      'login': 'Login',
      'register': 'Register',
      'map': 'Map',
      'change_language': 'Change Language',
      'iraq': 'Iraq',

      // Auth
      'email': 'Email',
      'password': 'Password',
      'confirm_password': 'Confirm Password',
      'create_account': 'Create Account',
      'create_new_account': 'Create New Account',
      'already_have_account': 'Already have an account? Login',
      'join_taabor': 'Join Taabor',

      // Validation
      'required': 'Required',
      'email_required': 'Please enter email',
      'password_required': 'Please enter password',
      'invalid_email': 'Invalid email format',
      'password_min_length': 'Password must be at least 6 characters',
      'passwords_not_match': 'Passwords do not match',

      // Messages
      'account_created': 'Account created! Please login.',
      'login_success': 'Login successful',
      'login_failed': 'Login failed',
      'error_occurred': 'An error occurred',

      // Firebase Errors
      'user_not_found': 'User not found',
      'wrong_password': 'Wrong password',
      'email_already_in_use': 'Email already in use',
      'weak_password': 'Password is too weak',
      'network_error': 'Network error, please try again',
      'invalid_credentials': 'Invalid email or password',
      'too_many_requests': 'Too many attempts, please try again later',
    },
    'ar': {
      'title': 'طابور',
      'login': 'تسجيل الدخول',
      'register': 'تسجيل',
      'map': 'الخريطة',
      'change_language': 'تغيير اللغة',
      'iraq': 'العراق',

      // Auth
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'confirm_password': 'تأكيد كلمة المرور',
      'create_account': 'إنشاء حساب',
      'create_new_account': 'إنشاء حساب جديد',
      'already_have_account': 'لديك حساب بالفعل؟ تسجيل الدخول',
      'join_taabor': 'انضم إلى طابور',

      // Validation
      'required': 'مطلوب',
      'email_required': 'الرجاء إدخال البريد الإلكتروني',
      'password_required': 'الرجاء إدخال كلمة المرور',
      'invalid_email': 'صيغة البريد الإلكتروني غير صحيحة',
      'password_min_length': 'كلمة المرور يجب أن تكون 6 أحرف على الأقل',
      'passwords_not_match': 'كلمات المرور غير متطابقة',

      // Messages
      'account_created': 'تم إنشاء الحساب! يرجى تسجيل الدخول.',
      'login_success': 'تم تسجيل الدخول بنجاح',
      'login_failed': 'فشل تسجيل الدخول',
      'error_occurred': 'حدث خطأ',

      // Firebase Errors
      'user_not_found': 'المستخدم غير موجود',
      'wrong_password': 'كلمة المرور غير صحيحة',
      'email_already_in_use': 'البريد الإلكتروني مستخدم بالفعل',
      'weak_password': 'كلمة المرور ضعيفة جداً',
      'network_error': 'خطأ في الاتصال، يرجى المحاولة مرة أخرى',
      'invalid_credentials': 'البريد الإلكتروني أو كلمة المرور غير صحيحة',
      'too_many_requests': 'محاولات كثيرة جداً، يرجى المحاولة لاحقاً',
    },
    'ku': {
      'title': 'تابۆر',
      'login': 'چوونەژوورەوە',
      'register': 'تۆمارکردن',
      'map': 'نەخشە',
      'change_language': 'گۆڕینی زمان',
      'iraq': 'عێراق',

      // Auth
      'email': 'ئیمەیڵ',
      'password': 'وشەی نهێنی',
      'confirm_password': 'دووبارەکردنەوەی وشەی نهێنی',
      'create_account': 'دروستکردنی هەژمار',
      'create_new_account': 'دروستکردنی هەژماری نوێ',
      'already_have_account': 'هەژمارت هەیە? چوونەژوورەوە',
      'join_taabor': 'بەشداری کردن لە تابۆر',

      // Validation
      'required': 'پێویستە',
      'email_required': 'تکایە ئیمەیڵ بنووسە',
      'password_required': 'تکایە وشەی نهێنی بنووسە',
      'invalid_email': 'شێوەی ئیمەیڵ هەڵەیە',
      'password_min_length': 'وشەی نهێنی دەبێت لانیکەم ٦ پیت بێت',
      'passwords_not_match': 'وشەکانی نهێنی یەک ناگرنەوە',

      // Messages
      'account_created': 'هەژمار دروستکرا! تکایە بچۆژوورەوە.',
      'login_success': 'چوونەژوورەوە سەرکەوتوو بوو',
      'login_failed': 'چوونەژوورەوە سەرکەوتوو نەبوو',
      'error_occurred': 'هەڵەیەک ڕوویدا',

      // Firebase Errors
      'user_not_found': 'بەکارهێنەر نەدۆزرایەوە',
      'wrong_password': 'وشەی نهێنی هەڵەیە',
      'email_already_in_use': 'ئیمەیڵ پێشتر بەکارهاتووە',
      'weak_password': 'وشەی نهێنی زۆر لاوازە',
      'network_error': 'هەڵەی تۆڕ، تکایە دووبارە هەوڵ بدەرەوە',
      'invalid_credentials': 'ئیمەیڵ یان وشەی نهێنی هەڵەیە',
      'too_many_requests': 'هەوڵدانی زۆر، تکایە دواتر دووبارە هەوڵ بدەرەوە',
    },
  };

  String get title {
    return _localizedValues[locale.languageCode]!['title']!;
  }

  String get login {
    return _localizedValues[locale.languageCode]!['login']!;
  }

  String get register {
    return _localizedValues[locale.languageCode]!['register']!;
  }

  String get map {
    return _localizedValues[locale.languageCode]!['map']!;
  }

  String get changeLanguage {
    return _localizedValues[locale.languageCode]!['change_language']!;
  }

  // Auth getters
  String get email => _localizedValues[locale.languageCode]!['email']!;
  String get password => _localizedValues[locale.languageCode]!['password']!;
  String get confirmPassword =>
      _localizedValues[locale.languageCode]!['confirm_password']!;
  String get createAccount =>
      _localizedValues[locale.languageCode]!['create_account']!;
  String get createNewAccount =>
      _localizedValues[locale.languageCode]!['create_new_account']!;
  String get alreadyHaveAccount =>
      _localizedValues[locale.languageCode]!['already_have_account']!;
  String get joinTaabor =>
      _localizedValues[locale.languageCode]!['join_taabor']!;

  // Validation getters
  String get required => _localizedValues[locale.languageCode]!['required']!;
  String get emailRequired =>
      _localizedValues[locale.languageCode]!['email_required']!;
  String get passwordRequired =>
      _localizedValues[locale.languageCode]!['password_required']!;
  String get invalidEmail =>
      _localizedValues[locale.languageCode]!['invalid_email']!;
  String get passwordMinLength =>
      _localizedValues[locale.languageCode]!['password_min_length']!;
  String get passwordsNotMatch =>
      _localizedValues[locale.languageCode]!['passwords_not_match']!;

  // Messages getters
  String get accountCreated =>
      _localizedValues[locale.languageCode]!['account_created']!;
  String get loginSuccess =>
      _localizedValues[locale.languageCode]!['login_success']!;
  String get loginFailed =>
      _localizedValues[locale.languageCode]!['login_failed']!;
  String get errorOccurred =>
      _localizedValues[locale.languageCode]!['error_occurred']!;

  // Firebase Errors getters
  String get userNotFound =>
      _localizedValues[locale.languageCode]!['user_not_found']!;
  String get wrongPassword =>
      _localizedValues[locale.languageCode]!['wrong_password']!;
  String get emailAlreadyInUse =>
      _localizedValues[locale.languageCode]!['email_already_in_use']!;
  String get weakPassword =>
      _localizedValues[locale.languageCode]!['weak_password']!;
  String get networkError =>
      _localizedValues[locale.languageCode]!['network_error']!;
  String get invalidCredentials =>
      _localizedValues[locale.languageCode]!['invalid_credentials']!;
  String get tooManyRequests =>
      _localizedValues[locale.languageCode]!['too_many_requests']!;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
