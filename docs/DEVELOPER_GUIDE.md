# Taabor Developer Onboarding Guide

## 👋 Welcome to the Team

This guide will get you set up to contribute to the Taabor codebase (Mobile & Web).

## 🛠 Prerequisites

1. **Flutter SDK**: Stable channel (3.x +).
2. **Node.js**: v18+ (for Admin Panel).
3. **Firebase CLI**: `npm install -g firebase-tools`.
4. **IDE**: VS Code (recommended) or Android Studio.

## 📂 Project Structure

### Mobile App (`/mobile_app`)

- **Architecture**: Clean Architecture + BLoC.
- **State Management**: `flutter_bloc`.
- **DI**: `get_it` + `injectable`.
- **Key Folders**:
  - `lib/core`: Shared utilities, network, errors.
  - `lib/features`: Feature-based (Auth, Booking, Queue, etc.).
    - `domain`: Entities, Repositories, UseCases.
    - `data`: Models, DataSources, Repo Implementations.
    - `presentation`: BLoCs, Pages, Widgets.

### Admin Panel (`/admin_panel`)

- **Stack**: React + Vite + TailwindCSS.
- **State**: React Context API.
- **Key Folders**:
  - `src/components`: Reusable UI parts.
  - `src/pages`: Main route views.
  - `src/context`: Global state (Auth, Toast).

## 🚀 Getting Started

### 1. Setup Mobile

```bash
cd mobile_app
flutter pub get
# Generate code (json_serializable, frozen, etc.)
dart run build_runner build --delete-conflicting-outputs
# Run
flutter run
```

### 2. Setup Admin Panel

```bash
cd admin_panel
npm install
npm run dev
```

### 3. Environment Variables

- Create `.env` files based on `.env.example`.
- Obtain `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) from the Engineering Lead.

## 📏 Coding Standards

- **Linting**: We follow the standard `flutter_lints`.
- **Commits**: Use Conventional Commits (e.g., `feat: login page`, `fix: sorting bug`).
- **Tests**: Every new BLoC must have unit tests.

## 🚢 Deployment

- **Android**: `flutter build appbundle`.
- **Web**: `npm run build` -> `firebase deploy`.

*Happy Coding!*
