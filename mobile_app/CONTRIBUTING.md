# Contributing to Taabor

Thank you for your interest in contributing to Taabor! This document provides guidelines for contributing to the project.

## Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct:

- Be respectful and inclusive
- Welcome newcomers
- Focus on constructive feedback
- Respect differing viewpoints

## Getting Started

### 1. Fork the Repository

```bash
git clone https://github.com/YOUR_USERNAME/taabor.git
cd taabor/mobile_app
```

### 2. Set Up Development Environment

```bash
flutter pub get
flutter run
```

### 3. Create a Branch

```bash
git checkout -b feature/your-feature-name
```

## Development Guidelines

### Code Style

Follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines:

```dart
// Good
class UserProfile {
  final String userId;
  final String name;
  
  const UserProfile({
    required this.userId,
    required this.name,
  });
}

// Bad
class user_profile {
  String user_id;
  String name;
}
```

### Architecture

We follow **Clean Architecture**:

- **Domain**: Business logic and entities
- **Data**: Repositories and data sources
- **Presentation**: UI and state management (BLoC)

### Commit Messages

Use conventional commits:

```text
feat: add dark mode support
fix: resolve queue update bug
docs: update API documentation
test: add unit tests for auth
refactor: simplify business logic
```

## Testing

### Write Tests

All new features must include tests:

```dart
// Unit test example
test('should return user data when sign in succeeds', () async {
  // Arrange
  when(mockAuth.signIn(any, any))
      .thenAnswer((_) async => Right('user123'));
  
  // Act
  final result = await useCase(params);
  
  // Assert
  expect(result, Right('user123'));
});
```

### Run Tests

```bash
flutter test
flutter test --coverage
```

### Coverage Requirements

- Minimum 80% code coverage
- All new features must be tested
- Fix failing tests before submitting PR

## Pull Request Process

### 1. Update Your Branch

```bash
git fetch upstream
git rebase upstream/main
```

### 2. Run Tests

```bash
flutter test
flutter analyze
```

### 3. Create Pull Request

**PR Template:**

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests added/updated
- [ ] Widget tests added/updated
- [ ] Integration tests pass
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-reviewed code
- [ ] Commented complex code
- [ ] Updated documentation
- [ ] No new warnings
- [ ] Tests pass
```

### 4. Review Process

- At least 1 approval required
- All checks must pass
- Address review comments
- Keep PR up to date

## Areas for Contribution

### High Priority

- [ ] Payment gateway integration
- [ ] More language translations
- [ ] Accessibility improvements
- [ ] Performance optimizations

### Good First Issues

- [ ] UI improvements
- [ ] Documentation updates
- [ ] Bug fixes
- [ ] Test coverage

### Feature Requests

- [ ] Voice commands
- [ ] Widget support
- [ ] Apple Watch app
- [ ] Advanced analytics

## Questions?

- 📧 Email: <dev@taabor.com>
- 💬 Discord: [Join our community](https://discord.gg/taabor)
- 📖 Docs: [Documentation](API_DOCUMENTATION.md)

Thank you for contributing to Taabor! 🎉
