import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taabor/core/widgets/shimmer_widget.dart';

void main() {
  group('ShimmerWidget Tests', () {
    testWidgets('should display shimmer effect', (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ShimmerWidget(width: 100, height: 50)),
        ),
      );

      // Assert
      expect(find.byType(ShimmerWidget), findsOneWidget);
    });

    testWidgets('BusinessCardShimmer should display multiple shimmers', (
      tester,
    ) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: BusinessCardShimmer())),
      );

      // Assert
      expect(find.byType(BusinessCardShimmer), findsOneWidget);
      expect(find.byType(ShimmerWidget), findsWidgets);
    });
  });
}
