import 'package:flutter_test/flutter_test.dart';
import 'package:taabor/features/home/data/models/business_model.dart';
import 'package:taabor/features/home/domain/entities/business.dart';

void main() {
  group('BusinessModel', () {
    final testBusiness = BusinessModel(
      id: '1',
      name: 'Test Business',
      category: 'Restaurant',
      address: '123 Test St',
      phoneNumber: '07501234567',
      latitude: 36.1925,
      longitude: 44.0092,
      rating: 4.5,
      currentQueueLength: 5,
      imageUrl: 'https://example.com/image.jpg',
      isOpen: true,
      estimatedWaitTimeMinutes: 15,
    );

    test('should be a subclass of Business entity', () {
      expect(testBusiness, isA<Business>());
    });

    group('fromMap', () {
      test('should return a valid model from Firestore data', () {
        // Arrange
        final data = {
          'name': 'Test Business',
          'category': 'Restaurant',
          'address': '123 Test St',
          'phoneNumber': '07501234567',
          'latitude': 36.1925,
          'longitude': 44.0092,
          'rating': 4.5,
          'currentQueueLength': 5,
          'imageUrl': 'https://example.com/image.jpg',
          'isOpen': true,
          'estimatedWaitTimeMinutes': 15,
        };

        // Act
        final result = BusinessModel.fromMap(data, '1');

        // Assert
        expect(result.id, '1');
        expect(result.name, 'Test Business');
        expect(result.category, 'Restaurant');
        expect(result.rating, 4.5);
        expect(result.currentQueueLength, 5);
      });
    });

    group('toMap', () {
      test('should return a valid Firestore map', () {
        // Act
        final result = testBusiness.toMap();

        // Assert
        expect(result['name'], 'Test Business');
        expect(result['category'], 'Restaurant');
        expect(result['rating'], 4.5);
        expect(result['currentQueueLength'], 5);
      });
    });
  });
}
