# Asset Creation Guide - Taabor

## Overview

This guide provides instructions and specifications for creating all visual assets required for app store submissions.

---

## App Icon

### Specifications

- **Size**: 1024x1024 pixels
- **Format**: PNG (no transparency)
- **Color Space**: sRGB or P3
- **Design**: Simple, recognizable, memorable

### Design Guidelines

1. **Concept**: Queue/waiting/time management symbol
2. **Colors**: Modern, vibrant (blue/purple gradient suggested)
3. **Style**: Minimalist, flat design
4. **Text**: App name optional, keep minimal

### Recommended Tool

- Figma, Adobe Illustrator, or Sketch
- Icon generator: <https://appicon.co/>

### Icon Variants Needed

```text
Android:
- mipmap-mdpi: 48x48
- mipmap-hdpi: 72x72
- mipmap-xhdpi: 96x96
- mipmap-xxhdpi: 144x144
- mipmap-xxxhdpi: 192x192

iOS:
- AppIcon 20x20 @2x, @3x
- AppIcon 29x29 @2x, @3x
- AppIcon 40x40 @2x, @3x
- AppIcon 60x60 @2x, @3x
- AppIcon 76x76 @1x, @2x
- AppIcon 83.5x83.5 @2x
- AppIcon 1024x1024 @1x
```

### Generation Command

```bash
# Using flutter_launcher_icons
flutter pub run flutter_launcher_icons:main
```

---

## Splash Screen

### App Icon Specifications

- **Background**: Solid color or simple gradient
- **Logo**: Centered, proportional
- **Safe Area**: Keep content within 80% of screen

### Sizes Required

**Android:**

```text
drawable-ldpi: 320x426
drawable-mdpi: 320x470
drawable-hdpi: 480x640
drawable-xhdpi: 720x960
drawable-xxhdpi: 1080x1440
drawable-xxxhdpi: 1440x1920
```

**iOS:**

```text
LaunchImage@1x: 320x480
LaunchImage@2x: 640x960
LaunchImage-700@2x: 640x1136
LaunchImage-800-667h@2x: 750x1334
LaunchImage-800-Portrait-736h@3x: 1242x2208
LaunchImage-1200-Portrait@2x: 1536x2048
```

### Design Tips

- Keep it simple
- Match app branding
- Fast loading time
- No text (use logo only)

### Generation Tool

```yaml
# pubspec.yaml
flutter_native_splash:
  color: "#4A90E2"
  image: assets/images/logo.png
  android: true
  ios: true
```

```bash
flutter pub run flutter_native_splash:create
```

---

## Screenshots

### Requirements

**Android (Google Play):**

- Minimum: 2 screenshots
- Maximum: 8 screenshots
- Phones: 1080x1920 or 1080x2340
- Tablets: 1440x2560 or 1920x2560
- Format: PNG or JPEG

**iOS (App Store):**

- 6.5" Display: 1242x2688 or 2688x1242
- 5.5" Display: 1242x2208 or 2208x1242
- 12.9" iPad Pro: 2048x2732 or 2732x2048
- Format: PNG or JPEG

### Screenshot Ideas

1. **Home/Business Discovery** - Map view with businesses
2. **Queue Management** - Active queue with position
3. **Booking** - Appointment booking screen
4. **Loyalty** - Points and rewards
5. **Chat** - Business communication
6. **Profile** - User dashboard
7. **Search** - Search and filters
8. **Dark Mode** - Show dark theme

### Capturing Screenshots

**Android:**

```bash
# Using Android Studio
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png
```

**iOS:**

```bash
# Use Xcode Simulator
Cmd + S (to save screenshot)
```

### Framing Tools

- **Screely**: <https://screely.com/>
- **Mockuuups**: <https://mockuuups.studio/>
- **Previewed**: <https://previewed.app/>

---

## Feature Graphic (Android Only)

### Feature Graphic Specifications

- **Size**: 1024x500 pixels
- **Format**: PNG or JPEG
- **Purpose**: Promotional banner in Play Store

### Design Elements

- App logo
- Key feature highlights
- Tagline: "Your Queue, Your Time"
- Vibrant colors
- Call to action

### Template

```text
[Logo] | Skip the Queue
       | Save Time
       | [App Features Icons]
```

---

## Promotional Graphics

### Play Store Promotional Image

- Size: 180x120 pixels
- Format: PNG
- Used in search results

### Promotional Video (Optional)

- Length: 30 seconds max
- Format: YouTube link
- Showcase key features

---

## Brand Assets

### Logo Variations

- Full color
- White version
- Black version
- Transparent background

### Color Palette

```text
Primary: #4A90E2 (Blue)
Secondary: #7B68EE (Purple)
Accent: #FF6B6B (Coral)
Success: #51CF66 (Green)
Background: #FFFFFF (White)
Dark: #1A1A1A (Almost Black)
```

### Typography

- **Primary Font**: Inter / Roboto
- **Secondary Font**: SF Pro / Product Sans

---

## Asset Checklist

### Checklist: App Icon

- [ ] 1024x1024 master icon
- [ ] Android variants generated
- [ ] iOS variants generated
- [ ] Adaptive icon (Android)

### Checklist: Splash Screen

- [ ] Android splash screens
- [ ] iOS launch images
- [ ] Dark mode variants

### Checklist: Screenshots

- [ ] 8 phone screenshots (Android)
- [ ] 8 phone screenshots (iOS 6.5")
- [ ] 4 tablet screenshots (optional)
- [ ] Localized versions (AR/EN)

### Store Graphics

- [ ] Feature graphic (1024x500)
- [ ] Promotional image (180x120)
- [ ] Promotional video (optional)

### Brand

- [ ] Logo variants
- [ ] Color palette documented
- [ ] Brand guidelines

---

## Tools & Resources

### Design Tools

- **Figma**: Free, collaborative
- **Adobe Illustrator**: Professional
- **Canva**: Quick mockups
- **Sketch**: Mac-only

### Icon Generators

- <https://appicon.co/>
- <https://makeappicon.com/>
- <https://apetools.webprofusion.com/>

### Screenshot Tools

- <https://www.screely.com/>
- <https://mockuuups.studio/>
- <https://previewed.app/>

### Asset Management

```text
mobile_app/
├── assets/
│   ├── icons/
│   │   ├── app_icon.png (1024x1024)
│   │   └── adaptive_icon.png
│   ├── splash/
│   │   └── logo.png
│   └── store/
│       ├── screenshots/
│       ├── feature_graphic.png
│       └── promotional.png
```

---

## Automation

### Flutter Launcher Icons

```yaml
# pubspec.yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icons/app_icon.png"
  adaptive_icon_background: "#4A90E2"
  adaptive_icon_foreground: "assets/icons/adaptive_icon.png"
```

### Flutter Native Splash

```yaml
flutter_native_splash:
  color: "#4A90E2"
  image: assets/splash/logo.png
  android_12:
    image: assets/splash/logo.png
    color: "#4A90E2"
```

---

## Tips for Success

1. **Consistency**: Use same style across all assets
2. **Localization**: Create assets for each language
3. **Testing**: Test on real devices
4. **Optimization**: Compress images without quality loss
5. **Branding**: Maintain brand identity

---

## Timeline

- **Day 1**: Design app icon and logo
- **Day 2**: Create splash screens
- **Day 3**: Capture and edit screenshots
- **Day 4**: Create promotional graphics
- **Day 5**: Review and finalize all assets

**Total Time**: 5 days for complete asset creation

---

**Good luck with your designs!** 🎨
