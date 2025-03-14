//
//  ScreenDistanceView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/23/24.
//

import SwiftUI




struct ScreenDistanceView: View {

    static let screenDistance = """
    Screen Distance is a feature available on iPhones that helps users manage and maintain a healthy distance between their eyes and the device screen. This feature is particularly useful for reducing eye strain and improving overall visual health. It uses the device's front-facing camera and sensors to detect how close the device is to the user's face and provides reminders or adjustments to encourage a safer viewing distance.
    """

    static let howText = """
    To use the Screen Distance feature on your iPhone, follow these steps:

    Open Settings: Navigate to the settings app on your iPhone.
    Screen Time: Scroll down and tap on "Screen Time", Under the Screen Time, look for "Screen Distance" or a similar option.
    Enable Screen Distance: Toggle the feature to the "On" position.
    """

    static let benefits = """
    Using the Screen Distance feature on your iPhone offers several benefits:

    Reduced Eye Strain: Maintaining a proper distance from your screen helps in reducing the risk of eye strain, which can lead to headaches and visual discomfort.
    Improved Posture: Alerts to adjust the screen distance can encourage better overall posture, reducing neck and back strain.
    Better Sleep: By encouraging healthier interactions with your device, it can contribute to better sleep habits, especially if it reduces blue light exposure by advising on proper screen distance in low light conditions.
    Enhanced Focus: With optimal screen distance, readability improves, which can help in maintaining better focus and efficiency while using your device.
    """
        
    let steps: [ScreenTimeStep] = [
        ScreenTimeStep(title: "What is Screen Distance?", description: screenDistance),
        ScreenTimeStep(title: "How to Use It", description: howText),
        ScreenTimeStep(title: "Benefits of Using Screen Distance", description: benefits),
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
    ScreenDistanceView()
}
