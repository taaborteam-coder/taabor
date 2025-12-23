import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taabor/core/widgets/empty_state.dart';

void main() {
  group('EmptyState Widget Tests', () {
    testWidgets('should display icon, title, and message', (tester) async {
      // Arrange
      const testIcon = Icons.inbox;
      const testTitle = 'No Items';
      const testMessage = 'You have no items yet';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: testIcon,
              title: testTitle,
              subtitle: testMessage,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(testIcon), findsOneWidget);
      expect(find.text(testTitle), findsOneWidget);
      expect(find.text(testMessage), findsOneWidget);
    });

    testWidgets('should display action button when provided', (tester) async {
      // Arrange
      bool buttonPressed = false;
      const testButtonText = 'Add Item';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.inbox,
              title: 'No Items',
              subtitle: 'Add your first item',
              action: ElevatedButton(
                onPressed: () => buttonPressed = true,
                child: Text(testButtonText),
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(testButtonText), findsOneWidget);

      // Act - tap button
      await tester.tap(find.text(testButtonText));
      await tester.pump();

      // Assert
      expect(buttonPressed, true);
    });

    testWidgets('should not display action button when not provided', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.inbox,
              title: 'No Items',
              subtitle: 'You have no items yet',
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(ElevatedButton), findsNothing);
    });
  });
}
