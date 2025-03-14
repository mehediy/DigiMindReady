//
//  ScreenTimeView.swift
//  ScreenSafeTots
//
//  Created by Md Mehedi Hasan on 11/11/23.
//

import SwiftUI

struct ScreenTimeView: View {
    
    @StateObject var familyControlsManager = FamilyControlsManager.shared
    @StateObject var scheduleViewModel = ScheduleViewModel()
    
    var body: some View {
        VStack {
            if !familyControlsManager.hasScreenTimePermission {
                PermissionView().preferredColorScheme(.light)
            } else {
                //ScreenTimePagerView().preferredColorScheme(.light)
                ScreenTimeHomeView().preferredColorScheme(.light)
            }
        }
        .onReceive(familyControlsManager.authorizationCenter.$authorizationStatus) { newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                familyControlsManager.updateAuthorizationStatus(authStatus: newValue)
            }
        }
        .onAppear {            
//            UIPageControl.appearance().currentPageIndicatorTintColor = .black
//            UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        }
        .environmentObject(familyControlsManager)
        .environmentObject(scheduleViewModel)
    }
}

//#Preview {
//    ScreenTimeView()
//}

