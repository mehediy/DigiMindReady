//
//  AppManager.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/22/24.
//

import Foundation

final class AppManager {
    
    //MARK: - Stored Properties
    var submittedSurvey: Survey?
    
    static let shared = AppManager()
    
    private init() {
        //Do some initialization
    }
    
    
    //MARK: - Computed Properties
    
    var profileQuizSurveryEvent: QuestionnaireEvent {
        set {
            UserDefaultsStore<Int>.profileQuizSurveryEvent.intValue = newValue.rawValue
        }
        get {
            guard let value = UserDefaultsStore<Int>.profileQuizSurveryEvent.intValue else { return .notSubmitted }
            return QuestionnaireEvent(rawValue: value) ?? .notSubmitted
        }
    }
    
}
