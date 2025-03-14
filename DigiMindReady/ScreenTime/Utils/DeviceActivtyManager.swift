//
//  DeviceActivtyManager.swift


import Foundation
import DeviceActivity
import ManagedSettings

// MARK: - Classes that control monitoring-related behavior
class DeviceActivityManager: ObservableObject {
    static let shared = DeviceActivityManager()
    private init() {}
    
    /// DeviceActivityCenter is a class that controls monitoring of the set schedule.
    /// Creates an instance to process actions such as starting and stopping monitoring.
    let deviceActivityCenter = DeviceActivityCenter()
    
    // MARK: - Device Activity Method to start activity monitoring
    /// You can also use warningTime to provide notifications before a specific event.
    /// Please refer to the link below for a screen time project using the notification function.
    /// https://github.com/DeveloperAcademy-POSTECH/MC2-Team18-sunghoyazaza
    func handleStartDeviceActivityMonitoring(
        startTime: DateComponents,
        endTime: DateComponents,
        deviceActivityName: DeviceActivityName = .daily,
        warningTime: DateComponents = DateComponents(minute: 5)
    ) {
        let schedule: DeviceActivitySchedule
        
        if deviceActivityName == .daily {
            schedule = DeviceActivitySchedule(
                intervalStart: startTime,
                intervalEnd: endTime,
                repeats: true,
                warningTime: warningTime
            )
            
            do {
                /// Starts monitoring for the period entered as schedule for the Device Activity whose name is received as the deviceActivityName argument.
                try deviceActivityCenter.startMonitoring(deviceActivityName, during: schedule)
                /// You can check the DeviceActivityName and schedule currently being monitored.
                print("\n\n")
                print("Start monitoring --> \(deviceActivityCenter.activities.description)")
                print("schedule --> \(schedule)")
                print("\n\n")
            } catch {
                print("Unexpected error: \(error).")
            }
        }
    }
    
    // MARK: - Device Activity - stop activity monitoring
    func handleStopDeviceActivityMonitoring() {
        /// Stop all monitoring.
        deviceActivityCenter.stopMonitoring()
        print("\n\n")
        print("Monitoring interruption --> \(deviceActivityCenter.activities.description)")
        print("\n\n")
    }
}

// MARK: - Schedule Name List
extension DeviceActivityName {
    static let daily = Self("daily")
}

// MARK: - MAnagedSettingsStore List
extension ManagedSettingsStore.Name {
    static let daily = Self("daily")
}
