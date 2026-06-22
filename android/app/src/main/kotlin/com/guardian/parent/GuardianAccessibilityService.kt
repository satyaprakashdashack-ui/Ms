package com.guardian.parent

import android.accessibilityservice.AccessibilityService
import android.view.accessibility.AccessibilityEvent

class GuardianAccessibilityService : AccessibilityService() {
    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        // Enforce only parent-approved, child-disclosed rules. Never capture private content.
    }
    override fun onInterrupt() = Unit
}
