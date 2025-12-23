import 'package:flutter_test/flutter_test.dart';
import 'package:taabor/core/utils/validators.dart';

void main() {
  group('Validators', () {
    group('Email Validation', () {
      test('should return null for valid email', () {
        expect(Validators.validateEmail('test@example.com'), null);
        expect(Validators.validateEmail('user+tag@domain.co.uk'), null);
      });

      test('should return error for invalid email', () {
        expect(Validators.validateEmail('invalid'), isNot(null));
        expect(Validators.validateEmail('test@'), isNot(null));
        expect(Validators.validateEmail('@example.com'), isNot(null));
        expect(Validators.validateEmail(''), isNot(null));
      });
    });

    group('Password Validation', () {
      test('should return null for valid password', () {
        expect(Validators.validatePassword('Password123!'), null);
        expect(Validators.validatePassword('SecurePass1'), null);
      });

      test('should return error for short password', () {
        expect(Validators.validatePassword('Pass1'), isNot(null));
      });

      test('should return error for password without uppercase', () {
        expect(Validators.validatePassword('password123'), isNot(null));
      });

      test('should return error for password without number', () {
        expect(Validators.validatePassword('Password'), isNot(null));
      });
    });

    group('Phone Validation', () {
      test('should return null for valid phone', () {
        expect(Validators.validatePhone('07501234567'), null);
        expect(Validators.validatePhone('00964750123456'), null);
      });

      test('should return error for invalid phone', () {
        expect(Validators.validatePhone('123'), isNot(null));
        expect(Validators.validatePhone('abcdefghij'), isNot(null));
      });
    });

    group('Required Field Validation', () {
      test('should return null for non-empty string', () {
        expect(Validators.validateRequired('test'), null);
      });

      test('should return error for empty string', () {
        expect(Validators.validateRequired(''), isNot(null));
        expect(Validators.validateRequired('   '), isNot(null));
      });
    });

    group('Min Length Validation', () {
      test('should return null when length is sufficient', () {
        expect(Validators.validateMinLength('hello', 5), null);
        expect(Validators.validateMinLength('hello world', 5), null);
      });

      test('should return error when length is insufficient', () {
        expect(Validators.validateMinLength('hi', 5), isNot(null));
      });
    });

    group('Rating Validation', () {
      test('should return null for valid rating', () {
        expect(Validators.validateRating(1), null);
        expect(Validators.validateRating(3), null);
        expect(Validators.validateRating(5), null);
      });

      test('should return error for invalid rating', () {
        expect(Validators.validateRating(0), isNot(null));
        expect(Validators.validateRating(6), isNot(null));
        expect(Validators.validateRating(-1), isNot(null));
      });
    });
  });
}
