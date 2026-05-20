# PoochCare

Flutter application for PoochCare.

## Prerequisites

- Flutter SDK managed with FVM
- Dart SDK (comes with Flutter)
- Xcode (iOS) and/or Android Studio (Android)

## Project Setup

1. Install dependencies:

```bash
fvm flutter pub get
```
or 
```bash
fvm flutter pub get && sh scripts/setup.sh
```

2. Ensure environment file exists in project root:

```bash
.env
```

Use `.env.example` as a reference for required variables.

3. Enable shared Git hooks (required for team consistency):

```bash
sh scripts/setup.sh
```

This configures Git to use shared hooks from `scripts/git-hooks/`.
On each commit, hooks will run formatting (`dart format .`) and lint checks (`flutter analyze`).

## Run the Project

Run on connected device/emulator:

```bash
fvm flutter run
```

Run with a specific target (example):

```bash
fvm flutter run -d ios
```

Run on Android emulator/device:

```bash
fvm flutter run -d android
```

## Platform-Specific Build Commands

### iOS

Debug run:

```bash
fvm flutter run -d ios
```

Release build (without codesign):

```bash
fvm flutter build ios --release --no-codesign
```

### Android

Debug run:

```bash
fvm flutter run -d android
```

Release APK:

```bash
fvm flutter build apk --release
fvm flutter build apk --flavor dev --release --split-per-abi
```

Release App Bundle (Play Store):

```bash
fvm flutter build appbundle --release
```

## Generate Builder Code (dart_mappable / auto_route)

Run the generator:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

Optional watch mode during development:

```bash
fvm flutter pub run build_runner watch --delete-conflicting-outputs
```

## Useful Commands

Clean and reinstall dependencies:

```bash
fvm flutter clean
fvm flutter pub get
```

Check project issues:

```bash
fvm flutter analyze
```

Run tests:

```bash
fvm flutter test
```

## Code Formatting

This project uses Dart's built-in formatter only:

```bash
fvm dart format .
```

No custom formatter is used.

## VS Code Team Settings (Required)

Configure VS Code with:

- `editor.formatOnSave = true`
- `editor.defaultFormatter = Dart-Code.dart-code`


# For Kerla cache issue
```bash
dart pub global deactivate fvm
dart pub global activate fvm
hash -r
```

# Quick Ref
```bash
fvm dart format .
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter analyze
```

# to Run on web
flutter run -d chrome #// Run Locally
flutter build web # // Build for Production
build/web/   # // After this, you’ll get: 