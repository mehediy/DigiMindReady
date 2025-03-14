//
//  AppRootManager.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 11/7/23.
//

import Foundation

final class AppRootManager: ObservableObject {
    
    @Published var currentRoot: AppRoot = .authentication
    
    enum AppRoot {
        //case splash
        case authentication
        case home
    }
    
    func login() {
        // Implement login logic
        currentRoot = .home
    }

    func logout() {
        // Implement logout logic
        currentRoot = .authentication
    }
    
}
