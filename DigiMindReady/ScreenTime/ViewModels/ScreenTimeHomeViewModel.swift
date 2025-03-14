//
//  ScreenTimeHomeViewModel.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/20/24.
//

import Foundation
import SwiftUI

class ScreenTimeHomeViewModel: ObservableObject {
    @Published var tabIndex = 0
}


extension ScreenTimeHomePage {
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .guide:
            ScreenTimeTutorial()
        case .schedule:
            ScheduleView()
        case .report:
            MonitoringView()
        }
    }
}
