# Secrets Configuration Guide

## Overview

This guide explains how to configure secrets for deployment.

---

## GitHub Secrets

### Required Secrets

#### Android Deployment

```text
KEYSTORE_BASE64: Base64 encoded keystore file
KEYSTORE_PASSWORD: Keystore password
KEY_PASSWORD: Key password
KEY_ALIAS: Key alias (usually "taabor")
SERVICE_ACCOUNT_JSON: Google Play service account JSON
```

#### iOS Deployment

```text
APPLE_ID: Apple Developer email
APPLE_PASSWORD: Apple Developer password
APP_SPECIFIC_PASSWORD: App-specific password
MATCH_PASSWORD: Fastlane match password
```

#### Firebase

```text
FIREBASE_TOKEN: Firebase CI token
```

### Setting Up Secrets

#### GitHub Repository Settings

```text
1. Go to repository Settings
2. Click on Secrets and variables > Actions
3. Click "New repository secret"
4. Add each secret with name and value
```

---

## Android Keystore

### Generate Keystore

```bash
keytool -genkey -v -keystore taabor-release-key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias taabor
```

### Convert to Base64

```bash
# Linux/Mac
base64 taabor-release-key.jks > keystore.txt

# Windows
certutil -encode taabor-release-key.jks keystore.txt
```

### Add Keystore Secret

```log
Name: KEYSTORE_BASE64
Value: [Paste base64 content]
```

---

## Google Play Service Account

### Create Service Account

```text
1. Go to Google Cloud Console
2. Create new project or select existing
3. Enable Google Play Android Developer API
4. Create service account
5. Download JSON key
```

### Grant Permissions

```text
1. Go to Play Console > Settings > API access
2. Link Google Cloud project
3. Grant permissions to service account
4. Enable access
```

### Add Service Account Secret

```text
Name: SERVICE_ACCOUNT_JSON
Value: [Paste entire JSON content]
```

---

## iOS Certificates

### Apple Developer Account

```text
1. Enroll in Apple Developer Program
2. Create App ID
3. Generate certificates
4. Create provisioning profiles
```

### App-Specific Password

```text
1. Go to appleid.apple.com
2. Sign in
3. Security > App-Specific Passwords
4. Generate new password
5. Save password
```

### Fastlane Match

```bash
# Initialize match
fastlane match init

# Set password
export MATCH_PASSWORD=your_password

# Generate certificates
fastlane match development
fastlane match appstore
```

---

## Firebase Setup

### Get CI Token

```bash
firebase login:ci
```

Output will be token like:

```text
1//abc123...
```

### Add Firebase Token Secret

```text
Name: FIREBASE_TOKEN
Value: [Your token]
```

---

## Environment Variables

### Local Development

Create `.env` file:

```env
# Android
KEYSTORE_PASSWORD=your_password
KEY_PASSWORD=your_key_password
KEY_ALIAS=taabor

# iOS
APPLE_ID=your@email.com
APPLE_PASSWORD=your_password
APP_SPECIFIC_PASSWORD=xxxx-xxxx-xxxx-xxxx

# Firebase
FIREBASE_TOKEN=1//abc123...
```

> **⚠️ Never commit .env to git**

### .gitignore

```gitignore
# Secrets
.env
*.jks
*.keystore
*.p12
*.mobileprovision
google-services.json
GoogleService-Info.plist
```

---

## Security Best Practices

1. **Rotate Secrets**: Change passwords periodically
2. **Limit Access**: Only necessary people
3. **Use Strong Passwords**: 16+ characters
4. **Enable 2FA**: On all accounts
5. **Monitor Access**: Review logs regularly
6. **Backup Keystore**: Store securely, multiple locations
7. **Never Share**: Don't share secrets via email/chat

---

## Troubleshooting

### Keystore Issues

```text
Error: Could not find keystore

Solution:
1. Check KEYSTORE_BASE64 secret exists
2. Verify base64 encoding is correct
3. Ensure keystore password is correct
```

### Service Account Issues

```text
Error: Insufficient permissions

Solution:
1. Check service account has proper roles
2. Verify API is enabled
3. Wait 24 hours after creating account
```

### iOS Signing Issues

```text
Error: No signing certificate

Solution:
1. Run fastlane match
2. Check provisioning profiles
3. Verify Apple Developer account status
```

---

## Verification

### Test Android Build Locally

```bash
export KEYSTORE_PASSWORD=your_password
export KEY_PASSWORD=your_key_password
export KEY_ALIAS=taabor

flutter build appbundle --release
```

### Test iOS Build Locally

```bash
export APPLE_ID=your@email.com
export FASTLANE_PASSWORD=your_password

flutter build ios --release
```

---

**Keep your secrets safe!** 🔐
