//
//  LoginScreenViewModel.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/22/24.
//

import Foundation
import SwiftUI

class LoginScreenViewModel: ObservableObject {

    @Published var isQuizPresentingFullScreen = false
    @Published var isSignupDone = false
    
    
    func openHomeScreen() {
        //appRootManager.currentRoot = .home
        isQuizPresentingFullScreen = false
    }
}


extension LoginScreenViewModel : SurveyViewDelegate {
    
    func surveyCompleted(with survey: Survey) {
        //let jsonUrl = URL.documentsDirectory().appendingPathComponent("survey_filled" + String(Int.random(in: 0...100)) + ".json")
        let jsonUrl = URL.documentsDirectory().appendingPathComponent("survey_filled.json")
        try? Survey.SaveToFile(survey: survey, url: jsonUrl)
        print( " Saved survey to: \n" , jsonUrl.path )
        
        AppManager.shared.profileQuizSurveryEvent = .submitted
        openHomeScreen()
    }
    
    func surveyDeclined() {
        AppManager.shared.profileQuizSurveryEvent = .declined
        openHomeScreen()
    }
    
    func surveyRemindMeLater() {
        AppManager.shared.profileQuizSurveryEvent = .remindLater
        openHomeScreen()
    }
    
}

