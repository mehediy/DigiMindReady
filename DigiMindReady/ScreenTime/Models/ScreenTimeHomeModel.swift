//
//  ScreenTimeHomeModel.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/20/24.
//

import Foundation


enum ScreenTimeHomePage: CaseIterable, Hashable {
    
    case guide
    case schedule
    case report
    
    var sectionItem: SectionItem {
        switch self {
        case .guide:
            SectionItem(title: "Guideline", iconName: "info.square.fill", eventType: .none, colorPalette: "blue2")
        case .schedule:
            SectionItem(title: "Schedule", iconName: "person.badge.shield.checkmark.fill", eventType: .none, colorPalette: "red2")
        case .report:
            SectionItem(title: "Report", iconName: "chart.bar.xaxis", eventType: .none, colorPalette: "red1")
        }
    }
    
    var labelInfo: (text: String, icon: String) {
        switch self {
        case .guide:
            return (text: "Guide", icon: "info.square.fill")
        case .schedule:
            return (text: "Schedule", icon: "person.badge.shield.checkmark.fill")
        case .report:
            return (text: "Report", icon: "chart.bar.xaxis")
        }
    }
}
