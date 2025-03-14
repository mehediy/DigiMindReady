//
//  MonitoringView.swift


import DeviceActivity
import SwiftUI

// MARK: - Device Activity Report
struct MonitoringView: View {
    @EnvironmentObject var scheduleViewModel: ScheduleViewModel
    
    @State private var context: DeviceActivityReport.Context = .totalActivity
    
    
    @State private var filter = DeviceActivityFilter(
        segment: .weekly(
            during: getWeekInterval()
        )
    )
    
    
    static func getWeekInterval() -> DateInterval {
        let calendar = Calendar.current
        let today = Date()
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        let currentDateTime = Date()
        
        let startOfWeekToTodayInterval = DateInterval(start: startOfWeek, end: currentDateTime)
        print("Start of week to today interval: \(startOfWeekToTodayInterval)")
        
        return startOfWeekToTodayInterval
    }

    
    
    var body: some View {
        DeviceActivityReport(context, filter: filter)
            .onAppear {
                print("DeviceActivityReport onAppear")
                filter = DeviceActivityFilter(
                    segment: .weekly(
                        during: MonitoringView.getWeekInterval()
                    ),
                    users: .all,
                    devices: .init([.iPhone]),
                    applications: scheduleViewModel.selection.applicationTokens,
                    categories: scheduleViewModel.selection.categoryTokens
                )
                
                //                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                //                    filter = DeviceActivityFilter(
                //                        segment: .daily(
                //                            during: Calendar.current.dateInterval(
                //                                of: .day, for: .now
                //                            ) ?? DateInterval()
                //                        ),
                //                        users: .all,
                //                        devices: .init([.iPhone]),
                //                        applications: scheduleViewModel.selection.applicationTokens,
                //                        categories: scheduleViewModel.selection.categoryTokens
                //                    )
                //                }
            }
    }
}

//struct MonitoringView_Previews: PreviewProvider {
//    static var previews: some View {
//        MonitoringView()
//    }
//}
