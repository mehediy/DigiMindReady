//
//  AuthManager.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 1/17/24.
//

import Foundation

class AuthManager: ObservableObject {
    @Published var isAuthenticated = false

    func login() {
        // Implement login logic
        isAuthenticated = true
    }

    func logout() {
        // Implement logout logic
        isAuthenticated = false
    }
}
