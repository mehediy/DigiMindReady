//
//  DigiMindReadyApp.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 3/17/24.
//

import SwiftUI

@main
struct DigiMindReadyApp: App {
    
    //@ObservedObject var authState = AuthState.shared
    @StateObject private var appRootManager = AppRootManager()
    
     
    var body: some Scene {
        WindowGroup {

            Group {
                
                switch appRootManager.currentRoot {
                    
                case .authentication:
//                    //LoginScreen()
                    AuthScreen()
                case .home:
                    TabBarView()
                }
            }
            .environmentObject(appRootManager)
        }
    }
}
