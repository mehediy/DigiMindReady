//
//  ScreenTimeTutorial.swift
//  ScreenSafeTots
//
//  Created by Md Mehedi Hasan on 11/12/23.
//

import SwiftUI


struct ScreenTimeStep: Identifiable {
    var id = UUID()
    var title: String
    var description: String
}

let accessScreenTime = """
• Go to the Settings app on your iPhone.
• Scroll down and tap on "Screen Time."
"""

let setupPersonalUse = """
• Tap "Turn On Screen Time."
• Read the Screen Time information and tap "Continue."
• Select "This is My iPhone" to set it up for personal use.
"""

let setupChildPhone = """
• Go to the "Family" section in Screen Time settings if you're part of Family Sharing.
• Choose your child's name and then "Turn On Screen Time" for them.
• Select "This is My Child's iPhone" and follow the on-screen instructions to set up Downtime, App Limits, and Content & Privacy with a parent passcode.
"""


struct ScreenTimeTutorial: View {
    
    let steps: [ScreenTimeStep] = [
        ScreenTimeStep(title: "Access Screen Time", description: accessScreenTime),
        ScreenTimeStep(title: "Set Up for Personal Use", description: setupPersonalUse),
        ScreenTimeStep(title: "Set Up for a Child", description: setupChildPhone),
        ScreenTimeStep(title: "Understanding Screen Time Reports", description: "Screen Time gives you a report detailing how you use your device, including the use of specific apps, websites, and the number of notifications you receive."),
        ScreenTimeStep(title: "Set Downtime", description: "Schedule a time away from the screen by setting Downtime. Only phone calls and apps you choose to allow will be available during Downtime."),
        ScreenTimeStep(title: "Set App Limits", description: "Set daily time limits for app categories you want to manage."),
        ScreenTimeStep(title: "Always Allowed Apps", description: "Choose apps that can be used at any time, even during downtime."),
        ScreenTimeStep(title: "Content & Privacy Restrictions", description: "Set content and privacy limits, including purchases, downloads, and explicit content settings."),
        ScreenTimeStep(title: "Manage Different Devices", description: "Turn on \"Share Across Devices\" to view your total usage across devices signed in with the same Apple ID.")
    ]
    
    
    var body: some View {
        NavigationView {
            List(steps) { step in
                Section(header: Text(step.title)) {
                    Text(step.description)
                        .padding(.vertical, 8.0)
                        .font(.system(size: 16))
                }
            }
//            .navigationTitle("Screen Time Guide")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ScreenTimeTutorial()
}
