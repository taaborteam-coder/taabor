import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'firebase_options.dart';

import 'dart:ui';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'core/theme/app_theme.dart';
import 'core/providers/locale_provider.dart';
import 'core/providers/favorites_provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/localization/app_localizations.dart';
import 'core/di/injection.dart';
import 'core/services/notification_service.dart';
import 'core/services/push_notification_service.dart';
import 'core/services/offline_service.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    FirebaseAnalytics.instance.logAppOpen();

    await configureDependencies(); // Initialize DI

    // Initialize Local Notifications
    await sl<NotificationService>().initialize();

    // Initialize Cloud Notifications (FCM)
    await sl<PushNotificationService>().initialize();

    // Initialize Offline Service
    await sl<OfflineService>().initialize();
  } catch (e) {
    debugPrint('Initialization failed: $e');
  }

  final prefs = await SharedPreferences.getInstance();
  final seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  runApp(TaaborApp(seenOnboarding: seenOnboarding));
}

class TaaborApp extends StatelessWidget {
  final bool seenOnboarding;

  const TaaborApp({super.key, required this.seenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        BlocProvider(create: (_) => sl<AuthBloc>()..add(AuthCheckRequested())),
      ],
      child: Consumer2<LocaleProvider, ThemeProvider>(
        builder: (context, localeProvider, themeProvider, child) {
          final textDirection =
              (localeProvider.locale.languageCode == 'ar' ||
                  localeProvider.locale.languageCode == 'ku')
              ? TextDirection.rtl
              : TextDirection.ltr;

          return Directionality(
            textDirection: textDirection,
            child: MaterialApp(
              title: 'Taabor',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.themeMode,
              locale: localeProvider.locale,
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
                Locale('ku'),
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: seenOnboarding ? const LoginPage() : const OnboardingPage(),
            ),
          );
        },
      ),
    );
  }
}
