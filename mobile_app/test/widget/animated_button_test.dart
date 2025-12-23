import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taabor/core/widgets/animated_button.dart';

void main() {
  group('AnimatedButton Widget Tests', () {
    testWidgets('should display text and icon', (tester) async {
      // Arrange

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedButton(
              text: 'Click Me',
              icon: Icons.add,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Click Me'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should trigger callback when tapped', (tester) async {
      // Arrange
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedButton(
              text: 'Click Me',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.text('Click Me'));
      await tester.pumpAndSettle();

      // Assert
      expect(pressed, true);
    });

    testWidgets('should show loading indicator when isLoading is true', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedButton(
              text: 'Click Me',
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Click Me'), findsNothing);
    });

    testWidgets('should not trigger callback when loading', (tester) async {
      // Arrange
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedButton(
              text: 'Click Me',
              onPressed: () => pressed = true,
              isLoading: true,
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(AnimatedButton));
      await tester.pump(
        const Duration(milliseconds: 100),
      ); // Wait short time for tap handling

      // Assert
      expect(pressed, false);
    });
  });
}
