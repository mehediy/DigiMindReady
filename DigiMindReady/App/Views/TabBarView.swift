//
//  TabBarView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 11/7/23.
//

import SwiftUI

struct TabBarView: View {
    
    @State var selectedTab: Tab = .home
    @State var popToRootTab: Tab = .home
    
    
    var availableTabs: [Tab] = [.home, .screenTime, .advocator, .eduScreen, .profile]
    //{ appAccountsManager.currentClient.isAuth ? Tab.loggedInTabs() : Tab.loggedOutTab() }
    
//    init() {
//        UITabBar.appearance().isTranslucent = false
//        UITabBar.appearance().barTintColor = UIColor(named: "Secondary")
//        UITabBar.appearance().backgroundColor = UIColor(named: "Secondary")
//    }
    
    var body: some View {
        
        
        TabView(selection: .init(get: {
          selectedTab
        }, set: { newTab in
          if newTab == selectedTab {
            /// Stupid hack to trigger onChange binding in tab views.
            popToRootTab = .home
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
              popToRootTab = selectedTab
            }
          }
        
          //HapticManager.shared.fireHaptic(of: .tabSelection)
          //SoundEffectManager.shared.playSound(of: .tabSelection)
        
          selectedTab = newTab
        
          /*DispatchQueue.main.async {
            if selectedTab == .notifications {

            }
          }*/
        
        })) {
            
          ForEach(availableTabs) { tab in
            tab.makeContentView(popToRootTab: $popToRootTab)
              .tabItem {
                  tab.label
              }
              .tag(tab)
              .toolbarBackground(.visible, for: .tabBar)
              .toolbarBackground(Color("Secondary"), for: .tabBar)
              .toolbarColorScheme(.dark, for: .tabBar)
//              .badge(badgeFor(tab: tab))
          }

          
        }
        .id("current.id")
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Color("Primary"))
        .background(Color.background)
        .accentColor(Color.red)
        
    }
}


#Preview {
    TabBarView()
}



