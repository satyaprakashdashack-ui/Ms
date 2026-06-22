# Guardian Parent

Guardian Parent is an APK-ready Flutter/Firebase starter for a consent-first Android parental-control system. It includes parent authentication, family pairing by invite code or QR link, child setup disclosure screens, permission onboarding, dashboards, rules, reports, Firestore services, WorkManager background hooks, Android Accessibility/Device Admin declarations, and compliance documentation.

## Stack

- Flutter with Material Design 3 and Riverpod
- Firebase Authentication, Firestore, FCM, Analytics, and Crashlytics
- Google Maps SDK-ready location package integration
- WorkManager background synchronization
- Android Accessibility Service and Device Admin integration stubs

## Build setup

1. Install Flutter and Android SDK.
2. Create a Firebase project and run `flutterfire configure`.
3. Add Android `google-services.json` to `android/app/`.
4. Review `docs/security_and_compliance.md` and implement production Firestore Security Rules before release.
5. Run `flutter pub get` and `flutter build apk`.
