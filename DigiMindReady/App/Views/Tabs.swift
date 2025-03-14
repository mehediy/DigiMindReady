//
//  Tabs.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 11/7/23.
//

import SwiftUI

@MainActor
enum Tab: Int, Identifiable, Hashable {
    case home, screenTime, advocator, eduScreen, profile
    //case other
    
    nonisolated var id: Int {
        rawValue
    }
    
    //  static func loggedOutTab() -> [Tab] {
    //    [.timeline, .settings]
    //  }
    
    static func loggedInTabs() -> [Tab] {
        return [.home, .screenTime, .advocator, .eduScreen, .profile]
    }
    
    
    @ViewBuilder
    func makeContentView(popToRootTab: Binding<Tab>) -> some View {
        switch self {
        case .home:
            HomeView(popToRootTab: popToRootTab)
                .preferredColorScheme(.light)
                .background(Color.white)
        case .screenTime:
            ScreenTimeView()
                .preferredColorScheme(.dark)
                .background(Color.white)
                //.background(Color.background)
        case .advocator:
            AdvocatorView().background(Color.background)
        case .eduScreen:
            EduScreenView()
                .background(Color.white)
                .preferredColorScheme(.dark)
            //LearningModuleView(popToRootTab: popToRootTab).background(Color.background)
        case .profile:
            ProfileView(popToRootTab: popToRootTab)
                .background(Color.white)
                .preferredColorScheme(.dark)
        }
    }
    
    @ViewBuilder
    var label: some View {
        Label(labelTitle, systemImage: iconName)
    }


    var labelTitle: String {
        switch self {
        case .home:
            "tab.home".localizedString
        case .screenTime:
            "tab.screenTime".localizedString
        case .advocator:
            "tab.advocator".localizedString
        case .eduScreen:
            "tab.eduScreen".localizedString
        case .profile:
            "tab.profile".localizedString
        }
    }
    
    //Standard SwiftUI behaviour in iOS 15, is that it will always use the filled version
    //https://developer.apple.com/design/human-interface-guidelines/tab-bars
    var iconName: String {
        switch self {
        case .home:
            "house.fill"
        case .screenTime:
            "hourglass"
        case .advocator:
            "bubbles.and.sparkles.fill"
        case .eduScreen:
            "graduationcap.fill"
        case .profile:
            "person.fill"
        }
    }
    
}
