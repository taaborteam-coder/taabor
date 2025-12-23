# Testing Guide - Taabor Mobile App

## Overview

This guide covers all testing procedures for the Taabor application.

## Test Coverage Goals

- **Unit Tests**: 80%+ coverage
- **Widget Tests**: All critical UI components
- **Integration Tests**: Complete user flows

## Running Tests

### Unit Tests

```bash
flutter test test/unit/
```

### Widget Tests

```bash
flutter test test/widget/
```

### Integration Tests

```bash
flutter test integration_test/
```

### All Tests

```bash
flutter test
```

### Coverage Report

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## Test Structure

### Unit Tests (`test/unit/`)

- `auth_bloc_test.dart` - Authentication BLoC tests
- `queue_test.dart` - Queue use case tests
- `validators_test.dart` - Input validation tests
- Repository tests
- Use case tests
- Model tests

### Widget Tests (`test/widget/`)

- `empty_state_widget_test.dart` - Empty state component
- `home_page_widget_test.dart` - Home page UI
- Business card tests
- Form validation tests
- Navigation tests

### Integration Tests (`integration_test/`)

- `app_test.dart` - End-to-end user flows
  - Complete booking flow
  - Search and filter
  - Loyalty points
  - Payment processing

## Best Practices

### Best Practices: Unit Tests

- Test one thing at a time
- Use mocks for dependencies
- Follow AAA pattern (Arrange, Act, Assert)
- Test edge cases

### Best Practices: Widget Tests

- Test UI rendering
- Test user interactions
- Test state changes
- Use `pumpAndSettle()` for animations

### Best Practices: Integration Tests

- Test complete user journeys
- Use real navigation
- Test with realistic data
- Verify end-to-end functionality

## Mocking

Using Mockito for mocks:

```dart
@GenerateMocks([Repository, UseCase])
import 'test.mocks.dart';
```

Generate mocks:

```bash
flutter pub run build_runner build
```

## CI/CD Integration

Tests run automatically on:

- Every pull request
- Main branch commits
- Release tags

Minimum requirements:

- All tests must pass
- Coverage must be ≥ 80%
- No critical warnings

## Performance Testing

Monitor:

- Build times
- Test execution times
- Memory usage
- FPS in UI tests

## Debugging Tests

### Run specific test

```bash
flutter test test/unit/auth_bloc_test.dart
```

### Run with verbose output

```bash
flutter test --verbose
```

### Run in debug mode

```bash
flutter test --debug
```

## Common Issues

### Mock generation fails

```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### Tests timeout

Increase timeout in test:

```dart
testWidgets('test', (tester) async {
  // ...
}, timeout: const Timeout(Duration(seconds: 30)));
```

## Continuous Improvement

- Add tests for new features
- Update tests when refactoring
- Review coverage reports
- Fix flaky tests immediately
