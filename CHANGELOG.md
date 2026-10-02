## 100.10.0

### Added

- Introduce Flutter SDK wrapper for the Entrust IDV native iOS and Android SDKs, at full feature parity with the React Native wrapper
- Added support for custom remote fonts. Integrators can supply a remote font via URL in the theme resources, which is applied systematically across all native and web modules. When a list of remote fonts is provided, only the first one is used for now.
- Added support for custom local fonts. Integrators can bundle a font natively per-platform and pass it via `IdvTheme.resources.fonts` using the new `resolveLocalFont` helper, applied consistently across native and web modules. Missing fonts are reported through the `onError` callback of any constructed `EntrustIdv` instance.

### Changed

- Update Android SDK to 100.13.0
- Update Android SDK to 100.15.0
- Update Android SDK to 100.16.0
- Update iOS SDK to 100.12.0
- Update iOS SDK to 100.12.1
- Update iOS SDK to 100.14.0
- Update iOS SDK to 100.16.0
- Renamed the Flutter package from idvsdk_flutter to entrust_idvsdk_flutter, so it is unambiguously Entrust on pub.dev.
- Swift Package Manager integrators can now add native capture modules such as Document or NFC to their app by adding the product from the IdvSDK-iOS package in Xcode. The plugin previously shipped its own copies of the core frameworks, which collided with that package and stopped it resolving.
- Update Android SDK to 100.11.0
- Update iOS SDK to 100.11.0

### Fixed

- Fix Android media, complete, error and analytics callbacks crashing due to type mismatches with the native SDK contract (binary media data, document capture sides, error category, and nullable analytics runtimeId)
- Android: changing which callbacks are registered now rebuilds the native SDK, so turning `onMedia` off stops capture modules serialising media across the bridge.
