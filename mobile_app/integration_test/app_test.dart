import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:taabor/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End User Flow Tests', () {
    testWidgets('Complete booking flow - from login to ticket creation', (
      tester,
    ) async {
      // Start app
      app.main();
      await tester.pumpAndSettle();

      // Step 1: Navigate to login if not authenticated
      if (find.text('تسجيل الدخول').evaluate().isNotEmpty) {
        // Find email field
        final emailField = find.byKey(const Key('email_field'));
        expect(emailField, findsOneWidget);
        await tester.enterText(emailField, 'test@example.com');

        // Find password field
        final passwordField = find.byKey(const Key('password_field'));
        expect(passwordField, findsOneWidget);
        await tester.enterText(passwordField, 'password123');

        // Tap login button
        final loginButton = find.byKey(const Key('login_button'));
        expect(loginButton, findsOneWidget);
        await tester.tap(loginButton);
        await tester.pumpAndSettle(const Duration(seconds: 3));
      }

      // Step 2: Navigate to business list
      expect(find.text('الرئيسية'), findsOneWidget);
      await tester.pumpAndSettle();

      // Step 3: Select a business
      final firstBusiness = find.byType(Card).first;
      await tester.tap(firstBusiness);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Step 4: Join queue
      final joinQueueButton = find.text('انضم للطابور');
      if (joinQueueButton.evaluate().isNotEmpty) {
        await tester.tap(joinQueueButton);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // Verify ticket created
        expect(find.textContaining('رقم الدور'), findsOneWidget);
      }

      // Step 5: Navigate to my tickets
      final myTicketsTab = find.text('تذاكري');
      if (myTicketsTab.evaluate().isNotEmpty) {
        await tester.tap(myTicketsTab);
        await tester.pumpAndSettle();

        // Verify ticket appears in list
        expect(find.byType(Card), findsWidgets);
      }
    });

    testWidgets('Search and filter businesses flow', (tester) async {
      // Start app
      app.main();
      await tester.pumpAndSettle();

      // Step 1: Find search field
      final searchField = find.byIcon(Icons.search);
      if (searchField.evaluate().isNotEmpty) {
        await tester.tap(searchField);
        await tester.pumpAndSettle();

        // Step 2: Enter search query
        final searchInput = find.byType(TextField).first;
        await tester.enterText(searchInput, 'مطعم');
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Step 3: Verify results filtered
        expect(find.byType(Card), findsWidgets);
      }

      // Step 4: Open filter
      final filterButton = find.byIcon(Icons.filter_list);
      if (filterButton.evaluate().isNotEmpty) {
        await tester.tap(filterButton);
        await tester.pumpAndSettle();

        // Step 5: Select category
        final categoryChip = find.text('مطاعم');
        if (categoryChip.evaluate().isNotEmpty) {
          await tester.tap(categoryChip);
          await tester.pumpAndSettle();
        }

        // Step 6: Apply filter
        final applyButton = find.text('تطبيق');
        if (applyButton.evaluate().isNotEmpty) {
          await tester.tap(applyButton);
          await tester.pumpAndSettle(const Duration(seconds: 1));
        }
      }
    });

    testWidgets('Loyalty points flow', (tester) async {
      // Start app
      app.main();
      await tester.pumpAndSettle();

      // Navigate to profile/loyalty
      final profileIcon = find.byIcon(Icons.person);
      if (profileIcon.evaluate().isNotEmpty) {
        await tester.tap(profileIcon);
        await tester.pumpAndSettle();

        // Find loyalty section
        final loyaltyButton = find.text('نقاط الولاء');
        if (loyaltyButton.evaluate().isNotEmpty) {
          await tester.tap(loyaltyButton);
          await tester.pumpAndSettle();

          // Verify points displayed
          expect(find.textContaining('نقطة'), findsWidgets);

          // Verify rewards section
          expect(find.text('المكافآت'), findsOneWidget);
        }
      }
    });
  });
}
