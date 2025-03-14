//
//  Advocator.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 3/18/24.
//

import Foundation

struct Advocator: Codable {
    let type: AdvocatorType
    let title: String
    let modelName: String
    let chat: String
    
    
    enum AdvocatorType: Codable {
        case sleep
        case activity
        case integrity  //Self-regulation
        
        var title: String {
            switch self {
            case .sleep:
                "Sleep Advisor"
            case .activity:
                "Activity Advisor"
            case .integrity:
                "Integrity Advisor"
            }
        }
        
        var subtitle: String {
            switch self {
            case .sleep:
                "Sleep Advisor"
            case .activity:
                "Activity Advisor"
            case .integrity:
                "Integrity Advisor"
            }
        }
        
        var iconName: String {
            switch self {
            case .sleep:
                "Sleep Advisor"
            case .activity:
                "Activity Advisor"
            case .integrity:
                "Integrity Advisor"
            }
        }
    }
    
}



