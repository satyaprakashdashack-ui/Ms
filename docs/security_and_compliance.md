# Security and compliance

Guardian Parent is designed as a consent-first parental-control application. It must not be marketed or implemented as spyware, hidden monitoring, private-message interception, credential capture, or unauthorized remote control.

## Required safeguards

- Explicit pairing is mandatory; using the same Gmail account on two devices never grants child-device access.
- Child setup must disclose every permission before requesting it.
- Parent approval is required before activation.
- The app must remain visible on the child device, including persistent notifications for background monitoring where Android requires them.
- Accessibility is limited to disclosed rule enforcement and browser/app safety signals; do not collect passwords, private messages, or unrelated content.
- Device Admin is limited to consented lock functionality and anti-tampering notices; users must have a clear removal path consistent with Google Play policy.
- Store only data necessary for child safety and family controls, with retention windows and deletion tools.
- Use Firebase Authentication, custom claims or Firestore role checks, strict Firestore Security Rules, HTTPS-only Firebase SDK transport, FCM token rotation, and secure local storage for sensitive parent-side state.
- Encrypt sensitive local data and avoid logging personal data to Analytics or Crashlytics.
- Comply with Google Play Families policies, local privacy law, COPPA/parental-consent requirements where applicable, and location/background permission policies.

## Not supported

The application does not bypass Android security, silently install agents, intercept private communications, hide from the launcher, defeat permission dialogs, or provide full control over another user's device without consent.
