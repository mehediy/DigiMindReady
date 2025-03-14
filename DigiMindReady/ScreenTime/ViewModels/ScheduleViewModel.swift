//
//  ScheduleVM.swift
//  ScreenTime_Barebones
//
//  Created by Yun Dongbeom on 2023/08/09.
//

import Foundation
import FamilyControls
import SwiftUI

enum ScheduleSectionInfo {
    case time
    case apps
    case monitoring
    case revoke
    
    var header: String {
        switch self {
        case .time:
            return "setup Time"
        case .apps:
            return "setup Apps"
        case .monitoring:
            return "stop Schedule Monitoring"
        case .revoke:
            return "Revoke Authorization"
        }
    }
    
    var footer: String {
        switch self {
        case .time:
            return "You can set a schedule time when you want to restrict app use by setting the start time and end time."
        case .apps:
            return "You can press the Change button to select the apps and web domains you want to restrict use for the selected time."
        case .monitoring:
            return "Stop monitoring the currently monitored schedule."
        case .revoke:
            return ""
        }
    }
}


class ScheduleViewModel: ObservableObject {
    // MARK: - Member variable for schedule setting
    @AppStorage("scheduleStartTime", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var scheduleStartTime = Date() + 60 // current time
    @AppStorage("scheduleEndTime", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var scheduleEndTime = Date() + 1*60*60 // current time + 60 minutes
    // MARK: - Member variable containing the app/domain set by the user
    @AppStorage("selection", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var selection = FamilyActivitySelection()
    
    @Published var isFamilyActivitySectionActive = false
    @Published var isSaveAlertActive = false
    @Published var isRevokeAlertActive = false
    @Published var isStopMonitoringAlertActive = false
    
    private func resetAppGroupData() {
        scheduleStartTime = Date() + 60
        scheduleEndTime = Date() + 1*60*60
        selection = FamilyActivitySelection()
    }
}

extension ScheduleViewModel {
    // MARK: - FamilyActivity Sheet
    /// When making a call, select the app or web domain installed on the device that the user wants to restrict.
    /// Opens a FamilyActivitySelection for selection.
    func showFamilyActivitySelection() {
        isFamilyActivitySectionActive = true
    }
    
    // MARK: - ScreenTime API - Open Delete Permission alert
    /// When called, open an alert that can remove permissions to use the app.
    /// You can remove the ScreenTIme API permissions you granted.
    func showRevokeAlert() {
        isRevokeAlertActive = true
    }
    
    // TODO: - I changed it to check with tempSelection of ScheduleView and moved it to ScheduleView. (delete after confirmation)
    // /// This method checks whether the app & domain token selected by the user is empty.
    //    func isSelectionEmpty() -> Bool {
    //        selection.applicationTokens.isEmpty &&
    //        selection.categoryTokens.isEmpty &&
    //        selection.webDomainTokens.isEmpty
    //    }
    
    // MARK: - Save schedule
    /// Set time You can monitor the set time by passing it through DeviceActivityManager.
    /// If you register monitoring, you can use DeviceActivityMonitorExtension to detect events at a specific point in time.
    func saveSchedule(selectedApps: FamilyActivitySelection) {
        selection = selectedApps
        
        let startTime = Calendar.current.dateComponents([.hour, .minute], from: scheduleStartTime)
        let endTime = Calendar.current.dateComponents([.hour, .minute], from: scheduleEndTime)
        
        DeviceActivityManager.shared.handleStartDeviceActivityMonitoring(
            startTime: startTime,
            endTime: endTime
        )
        
        isSaveAlertActive = true
    }
    
    // MARK: - Stop monitoring schedules
    /// Stops monitoring of the schedule currently being monitored.
    func stopScheduleMonitoring() {
        DeviceActivityManager.shared.handleStopDeviceActivityMonitoring()
        resetAppGroupData()
    }
    
    // MARK: -Open schedule monitoring interruption alert
    /// Opens an alert that can stop monitoring when called.
    /// You can stop monitoring the currently monitored schedule.
    func showStopMonitoringAlert() {
        isStopMonitoringAlertActive = true
    }
}


// MARK: - FamilyActivitySelection Parser
extension FamilyActivitySelection: RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data)
        else {
            return nil
        }
        self = result
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
// MARK: - Date Parser
extension Date: RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(Date.self, from: data)
        else {
            return nil
        }
        self = result
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
