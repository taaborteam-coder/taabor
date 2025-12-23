# Deployment Guide - Taabor Mobile App

## Overview

This guide covers the complete deployment process for the Taabor mobile application to Google Play Store and Apple App Store.

---

## Pre-Deployment Checklist

### Code Readiness

- [x] All features implemented
- [x] Tests passing (80%+ coverage)
- [x] No critical bugs
- [x] Performance optimized
- [x] Security reviewed

### Assets

- [ ] App icon (1024x1024)
- [ ] Splash screens (all sizes)
- [ ] Screenshots (phone & tablet)
- [ ] Promotional graphics
- [ ] Feature graphic

### Legal

- [x] Privacy Policy
- [x] Terms of Service
- [ ] EULA (if applicable)

### Configuration

- [ ] Production Firebase project
- [ ] API keys configured
- [ ] Environment variables set
- [ ] Analytics enabled

---

## Android Deployment

### 1. App Signing

#### Generate Keystore

```bash
keytool -genkey -v -keystore taabor-release-key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias taabor
```

#### Configure Signing in `android/app/build.gradle`

```gradle
android {
    signingConfigs {
        release {
            storeFile file('taabor-release-key.jks')
            storePassword System.getenv("KEYSTORE_PASSWORD")
            keyAlias 'taabor'
            keyPassword System.getenv("KEY_PASSWORD")
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
        }
    }
}
```

### 2. Build Release APK/AAB

```bash
# Build AAB (preferred for Play Store)
flutter build appbundle --release

# Build APK
flutter build apk --release --split-per-abi
```

### 3. Play Store Console Setup

#### App Information

- **App Name**: Taabor
- **Short Description**: Skip the queue, save time
- **Full Description**: [See STORE_DESCRIPTION.md]
- **Category**: Business
- **Content Rating**: Everyone

#### Store Listing

- Upload screenshots (minimum 2, recommended 8)
- Upload feature graphic (1024x500)
- Upload app icon
- Set promotional text

#### Pricing & Distribution

- Free app with in-app payments (if applicable)
- Select countries for distribution
- Comply with export laws

#### App Content

- Privacy Policy URL
- Ads declaration: No ads
- Target audience: 13+
- Content rating questionnaire

### 4. Release Tracks

- **Internal Testing**: For team testing
- **Closed Testing (Beta)**: For beta testers
- **Open Testing**: Public beta
- **Production**: Live release

### 5. Upload AAB

```bash
# Upload to Google Play Console
# Or use fastlane:
fastlane android deploy
```

---

## iOS Deployment

### 1. Apple Developer Account Setup

- Enroll in Apple Developer Program ($99/year)
- Create App ID in Developer Portal
- Generate certificates and provisioning profiles

### 2. App Store Connect

#### Create App

- Bundle ID: `com.taabor.app`
- App Name: Taabor
- Primary Language: English
- SKU: taabor-ios

#### iOS App Information

- Privacy Policy URL
- Category: Business
- Content Rights: No
- Age Rating: 4+

### 3. Build & Archive

#### Configure `ios/Runner/Info.plist`

```xml
<key>CFBundleDisplayName</key>
<string>Taabor</string>
<key>CFBundleIdentifier</key>
<string>com.taabor.app</string>
<key>CFBundleVersion</key>
<string>1.0.0</string>
```

#### Build

```bash
flutter build ios --release

# Then in Xcode:
# Product > Archive
# Distribute App > App Store Connect
```

### 4. TestFlight (Beta Testing)

- Upload build to TestFlight
- Add internal testers
- Create external test group
- Submit for beta review

### 5. App Store Submission

- Add screenshots (6.5", 5.5")
- Promotional text
- Description
- Keywords
- Support URL
- Marketing URL
- Submit for review

---

## Firebase Configuration

### Production Project Setup

```bash
# Create production Firebase project
firebase projects:create taabor-prod

# Initialize Firebase
firebase init

# Deploy Firestore rules
firebase deploy --only firestore:rules

# Deploy Cloud Functions (if any)
firebase deploy --only functions
```

### Environment Configuration

```dart
// lib/core/config/environment.dart
class Environment {
  static const String firebaseProjectId = 'taabor-prod';
  static const String apiBaseUrl = 'https://api.taabor.com';
  // ... other config
}
```

---

## CI/CD with GitHub Actions

### `.github/workflows/deploy.yml`

```yaml
name: Deploy

on:
  push:
    tags:
      - 'v*'

jobs:
  android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test
      - run: flutter build appbundle --release
      - name: Upload to Play Store
        uses: r0adkll/upload-google-play@v1
        with:
          serviceAccountJsonPlainText: ${{ secrets.SERVICE_ACCOUNT_JSON }}
          packageName: com.taabor.app
          releaseFiles: build/app/outputs/bundle/release/app-release.aab
          track: production

  ios:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test
      - run: flutter build ios --release --no-codesign
      - name: Build & Upload
        run: |
          fastlane ios release
```

---

## Version Management

### Versioning Strategy

Follow Semantic Versioning: `MAJOR.MINOR.PATCH`

Example:

- `1.0.0` - Initial release
- `1.0.1` - Bug fixes
- `1.1.0` - New features
- `2.0.0` - Breaking changes

### Update Version

```yaml
# pubspec.yaml
version: 1.0.0+1  # version+buildNumber
```

---

## Monitoring & Analytics

### Post-Launch Monitoring

- Firebase Crashlytics: Track crashes
- Firebase Analytics: User behavior
- Firebase Performance: App performance
- Play Console/App Store Connect: Reviews & ratings

### Crash Response

1. Monitor Crashlytics dashboard
2. Prioritize critical crashes
3. Fix and release patch
4. Communicate with users

---

## Release Checklist

### Pre-Release

- [ ] Code freeze
- [ ] Final testing on devices
- [ ] Performance testing
- [ ] Security audit
- [ ] Backup data

### Release Day

- [ ] Build production version
- [ ] Upload to stores
- [ ] Submit for review
- [ ] Monitor analytics
- [ ] Respond to reviews

### Post-Release

- [ ] Monitor crash reports
- [ ] Track user feedback
- [ ] Gather metrics
- [ ] Plan next release

---

## Rollout Strategy

### Staged Rollout

1. **Internal Testing** (1-2 days)
2. **Closed Beta** (1 week)
3. **Open Beta** (2 weeks)
4. **Production 10%** (3 days)
5. **Production 50%** (3 days)
6. **Production 100%** (rollout complete)

### Rollback Plan

- Keep previous version ready
- Monitor key metrics
- Rollback if crash rate > 2%
- Communicate issues to users

---

## Support

### User Support Channels

- In-app support
- Email: <support@taabor.com>
- Social media
- FAQ/Help Center

### Issue Tracking

- Use GitHub Issues for bugs
- Prioritize based on severity
- Weekly release cycle for patches

---

## Marketing Launch

### Pre-Launch

- Social media announcements
- Press releases
- Beta tester feedback
- Landing page

### Launch Day

- App Store Optimization (ASO)
- Social media campaign
- Email to waitlist
- PR outreach

### Post-Launch

- Monitor app store rankings
- Gather reviews
- Run ads (if applicable)
- Feature updates

---

## Success Metrics

### KPIs to Track

- Downloads
- Active users (DAU/MAU)
- Retention rate
- User ratings
- Crash-free rate
- Queue operations
- Booking conversions

### Targets (Month 1)

- Downloads: 1,000+
- Rating: 4.5+
- Crash-free: 99%+
- DAU: 200+

---

## Conclusion

This guide provides a comprehensive deployment strategy. Adjust timelines and strategies based on your specific needs and resources.

**Good luck with your launch!** 🚀
