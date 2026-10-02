# Entrust IDV SDK — Flutter sample app

A minimal Flutter app that launches an identity verification flow using the
`entrust_idvsdk_flutter` package.

## Requirements

| | |
|---|---|
| Flutter | 3.0 or later |
| iOS | 15.0 or later, Xcode 16 |
| Android | API level 24 or later (Flutter's own minimum), JDK 17 |
| Device | A **physical device** — the capture flow needs a camera |

## Running the app

```bash
flutter pub get
flutter run
```

On iOS, `flutter run` runs `pod install` for you. To do it by hand:

```bash
cd ios && pod install && cd ..
```

### Signing (iOS)

The project ships without a development team so that it builds under your own
Apple account. On first run, open `ios/Runner.xcworkspace` in Xcode, select the
**Runner** target, and pick your team under **Signing & Capabilities**.

If Xcode reports that the bundle identifier is unavailable, change
**Bundle Identifier** to something unique to you.

### Swift Package Manager (optional)

The app integrates through CocoaPods by default. To use SPM instead:

```bash
flutter config --enable-swift-package-manager
flutter run
```

This is a global Flutter setting, not a per-project one. Check which mode you
are in with `flutter config --list | grep swift`, and turn it back off with
`flutter config --no-enable-swift-package-manager`.

## Adding your token

The app needs an SDK token to start a flow. Open `lib/main.dart` and set
`studioToken` to a token generated for your account. See the
[SDK Integration guide](https://documentation.identity.entrust.com/sdk/sdk-integration-guide-2025)
for how to generate one.

## What is already configured

These are requirements of the SDK. They are set up in this project, but you
will need to reproduce them in your own app:

- `ios/Podfile` — `platform :ios, '15.0'` and `use_frameworks!`. The SDK ships
  as dynamic xcframeworks and is written in Swift, so it cannot be linked
  statically.
- iOS deployment target of 15.0 on the Runner target.
- `ios/Runner/Info.plist` — `NSCameraUsageDescription` and
  `NSMicrophoneUsageDescription`. Both are required for App Store submission.
