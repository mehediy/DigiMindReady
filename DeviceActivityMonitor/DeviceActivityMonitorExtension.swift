//
//  DeviceActivityMonitorExtension.swift
//  DeviceActivityMonitor
//
//  Created by Md Mehedi Hasan on 4/20/24.
//

import DeviceActivity
import ManagedSettings
import SwiftUI

// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    let store = ManagedSettingsStore(named: .daily)
    @StateObject var scheduleVM = ScheduleViewModel()
    
    // MARK: - Method called when the device is used for the first time after the start of the schedule
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        
        // Handle the start of the interval.
        // FamilyActivityPicker Apply shield (restrictions) to apps selected with
        let appTokens = scheduleVM.selection.applicationTokens
        let categoryTokens = scheduleVM.selection.categoryTokens
        
        if appTokens.isEmpty {
            store.shield.applications = nil
        } else {
            store.shield.applications = appTokens
        }
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(categoryTokens)
    }
    
    // MARK: - Method called when the device is used for the first time after the end of the schedule or when monitoring is stopped
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        // Handle the end of the interval.
        // Remove all shields applied to that store
        store.clearAllSettings()
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        // Handle the event reaching its threshold.
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        
        // Handle the warning before the interval starts.
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        
        // Handle the warning before the interval ends.
    }
    
    override func eventWillReachThresholdWarning(
        _ event: DeviceActivityEvent.Name,
        activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        
        // Handle the warning before the event reaches its threshold.
    }
}
