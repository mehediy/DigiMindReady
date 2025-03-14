//
//  PermissionVM.swift
//  ScreenTime_Barebones
//
//  Created by Yun Dongbeom on 2023/08/13.
//

import Foundation
import SwiftUI

class PermissionViewModel: ObservableObject {
    @Published var isViewLoaded = false
    @Published var isSheetActive = false
    
    let HEADER_ICON_LABEL = "info.circle.fill"
    
    let DECORATION_TEXT_INFO = (
        imgSrc: "AppLogo",
        title: "Screen Time Tracking",
        subTitle: "Let's learn the basic functions of the Screen Time Tracking feature."
    )
    
    let PERMISSION_BUTTON_LABEL = "Get started"
    
    let SHEET_INFO_LIST = [
        "Utilize the ScreenTime API to limit and monitor app/web usage at specific times."
    ]

}

extension PermissionViewModel {
    func handleTranslationView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                self.isViewLoaded = true
            }
        }
    }
    
    func showIsSheetActive() {
        isSheetActive = true
    }
    
    @MainActor
    func handleRequestAuthorization() {
        FamilyControlsManager.shared.requestAuthorization()
    }
}
