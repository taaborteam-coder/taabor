# Taabor Project

![Taabor Logo](https://via.placeholder.com/150)

## نظام ذكي لإدارة الطوابير والحجوزات

[![Flutter](https://img.shields.io/badge/Flutter-3.24.0-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![CI](https://github.com/yourusername/taabor/workflows/Flutter%20CI/badge.svg)](https://github.com/yourusername/taabor/actions)

---

## 🌟 Features

- 🔐 **Authentication** - Secure user login and registration
- 📋 **Queue Management** - Real-time ticket tracking
- 🏪 **Business Listings** - Browse nearby businesses
- 🎁 **Offers & Deals** - Special discounts and promotions
- 🗺️ **Map Integration** - Find businesses on map
- 📱 **Cross-Platform** - Android, iOS, Web, Desktop

## 🏗️ Architecture

Built with **Clean Architecture** + **BLoC** pattern:

```text
lib/
├── features/
│   ├── auth/
│   ├── queue/
│   ├── home/
│   └── engagement/
├── core/
│   ├── di/
│   ├── error/
│   └── utils/
```

## 🚀 Quick Start

### Prerequisites

- Flutter SDK >= 3.0.0  
- Firebase Project
- Dart >= 3.0.0

### Installation

```bash
# Clone repository
git clone https://github.com/yourusername/taabor.git
cd taabor/mobile_app

# Install dependencies
flutter pub get

# Run app
flutter run -d windows
```

## 📱 Screenshots

| Home | Queue | Offers |
|------|-------|--------|
| ![Home](https://via.placeholder.com/200x400) | ![Queue](https://via.placeholder.com/200x400) | ![Offers](https://via.placeholder.com/200x400) |

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# View coverage report
genhtml coverage/lcov.info -o coverage/html
```

## 📚 Documentation

- [Contributing Guidelines](CONTRIBUTING.md)
- [Architecture Overview](mobile_app/README.md)
- [Testing Guide](mobile_app/test/README.md)
- [Project Summary](mobile_app/PROJECT_SUMMARY.md)

## 🛠️ Tech Stack

- **Framework**: Flutter
- **State Management**: BLoC
- **DI**: GetIt
- **Backend**: Firebase (Auth, Firestore)
- **Testing**: flutter_test, mocktail, bloc_test

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) first.

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file.

## 👥 Team

- **Project Lead** - [@yourusername](https://github.com/yourusername)
- **Contributors** - See [CONTRIBUTORS.md](CONTRIBUTORS.md)

## 📞 Contact

- Website: <https://taabor.com>
- Email: <support@taabor.com>
- Twitter: [@taabor_app](https://twitter.com/taabor_app)

---

Made with ❤️ using Flutter
