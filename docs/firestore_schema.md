# Firestore schema

`users/{uid}` stores display name, email, guardianship status, and consent timestamps.

`families/{familyId}` stores the family name, invite code hash, owner uid, creation time, and policy version.

`families/{familyId}/members/{uid}` stores `role` (`owner`, `guardian`, `child`), permissions, and join timestamps.

`families/{familyId}/pairingRequests/{requestId}` stores invite-code/QR pairing requests, disclosed consent, device info, and parent approval status.

`families/{familyId}/devices/{deviceId}` stores child device status including battery, model, Android version, storage, RAM, network, last online, FCM token, and tamper signals.

`families/{familyId}/devices/{deviceId}/rules/current` stores screen-time limits, schedules, school/study/bedtime modes, app allow/block lists, category restrictions, web filter lists, and install approval requirements.

`families/{familyId}/devices/{deviceId}/events/{eventId}` stores append-only activity events such as app installs, app usage summaries, geofence transitions, permission changes, low battery, and offline alerts.

`families/{familyId}/devices/{deviceId}/locations/{locationId}` stores consented location history with retention policy fields.

`families/{familyId}/chat/{messageId}` stores family chat messages with sender uid, text, createdAt, and moderation metadata.
