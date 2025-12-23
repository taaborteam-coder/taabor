# Production Release Checklist

## 1. Pre-Flight Check

- [ ] **Remote Config**: Defaults validated.
- [ ] **Analytics**: `AnalyticsService` enabled.
- [ ] **Crashlytics**: `CrashlyticsService` enabled.
- [ ] **Permissions**: `AndroidManifest.xml` and `Info.plist` checked.
- [ ] **Secrets**: API Keys (Google Maps, Stripe) verified in build.

## 2. Android Release

- [ ] Update `version` in `pubspec.yaml` (e.g., `1.0.0+1`).
- [ ] Run `flutter clean`.
- [ ] Run `flutter build appbundle --release --obfuscate --split-debug-info=./debug_info`.
- [ ] Upload `.aab` to Google Play Console.

## 3. iOS Release

- [ ] Update `version` in `pubspec.yaml`.
- [ ] Run `flutter build ipa --release`.
- [ ] Open `Runner.xcworkspace` in Xcode.
- [ ] Validate and Distribute to App Store Connect.

## 4. Web Release

- [ ] Run `flutter build web --release`.
- [ ] Deploy to Firebase Hosting: `firebase deploy --only hosting`.

## 5. Post-Release

- [ ] Monitor Crashlytics for stability.
- [ ] Check Analytics for user engagement.
- [ ] Celebrate! 🚀
