//
//  AuthScreen.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/22/24.
//

import SwiftUI

struct AuthScreen: View {
    
    @StateObject private var viewModel = AuthScreenViewModel()
    
    @EnvironmentObject private var appRootManager: AppRootManager
    
    var body: some View {
        
        LoginScreen()
        
    }
}

#Preview {
    AuthScreen()
}
