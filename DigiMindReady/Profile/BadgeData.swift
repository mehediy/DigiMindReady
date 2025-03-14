//
//  BadgeData.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/21/24.
//

import Foundation


enum BadgeData {
    
    static func getTrophyImageName(achievement: Float) -> String {
        switch Int(ceil(achievement)) {
        case 0...20:
            "icon-cup-blue-star-1"
        case 21...40:
            "icon-cup-blue-star-2"
        case 41...60:
            "icon-cup-yellow-star-3"
        case 61...80:
            "icon-cup-yellow-star-4"
        case 81...100:
            "icon-cup-red-star-5"
        default:
            "icon-cup-red-star-5"
        }
    }
    
    static func getBadgeImageName(achievement: Float) -> String {
        switch Int(ceil(achievement)) {
        case 0...20:
            "icon-shield-badge-star-1"
        case 21...40:
            "icon-shield-badge-star-2"
        case 41...60:
            "icon-shield-badge-star-3"
        case 61...80:
            "icon-shield-badge-star-4"
        case 81...100:
            "icon-shield-badge-star-5"
        default:
            "icon-shield-badge-star-5"
        }
    }
    
    
    static func getBadgeImageName(type: BadgeType, achievement: Float) -> String {
        var iconPrefix: String
        switch type {
        case .education:
            iconPrefix = "icon-star-badge"
        case .screen:
            iconPrefix = "icon-shield-light-badge"
        case .sleep:
            iconPrefix = "icon-star-dark-badge"
        case .regulation:
            iconPrefix = "icon-shield-dark-badge"
        case .activity:
            iconPrefix = "icon-star-light-badge"
        }
        
        switch Int(ceil(achievement)) {
        case 0...20:
            return "\(iconPrefix)-star-1"
        case 21...40:
            return "\(iconPrefix)-star-2"
        case 41...60:
            return "\(iconPrefix)-star-3"
        case 61...80:
            return "\(iconPrefix)-star-4"
        case 81...100:
            return "\(iconPrefix)-star-5"
        default:
            return "\(iconPrefix)-star-5"
        }
    }
    
    static func getBadgeImageName(type: BadgeType, star: Int) -> String {
        var iconPrefix: String
        switch type {
        case .education:
            iconPrefix = "icon-star-badge"
        case .screen:
            iconPrefix = "icon-shield-light-badge"
        case .sleep:
            iconPrefix = "icon-star-dark-badge"
        case .regulation:
            iconPrefix = "icon-shield-dark-badge"
        case .activity:
            iconPrefix = "icon-star-light-badge"
        }
        
        switch star {
        case 1:
            return "\(iconPrefix)-star-1"
        case 2:
            return "\(iconPrefix)-star-2"
        case 3:
            return "\(iconPrefix)-star-3"
        case 4:
            return "\(iconPrefix)-star-4"
        case 5:
            return "\(iconPrefix)-star-5"
        default:
            return "\(iconPrefix)-star-5"
        }
    }
    
}


enum BadgeType: CaseIterable {
    case education
    case screen
    case sleep
    case regulation
    case activity
    
    var progressTitle: String {
        switch self {
        case .education:
            "Education Progress"
        case .screen:
            "Screen Progress"
        case .sleep:
            "Sleep Progress"
        case .regulation:
            "Regulation Progress"
        case .activity:
            "Activity Progress"
        }
    }
}


enum SkillLevel: Int, CaseIterable {
    case beginner = 1
    case intermediate = 2
    case skillful = 3
    case advanced = 4
    case expert = 5
    
    
    var title: String {
        switch self {
        case .beginner:
            "Beginner"
        case .intermediate:
            "Intermediate"
        case .skillful:
            "Skillful"
        case .advanced:
            "Advanced"
        case .expert:
            "Expert"
        }
    }
    
    
    var starCount: Int {
        rawValue
    }
    
    
    init(achievement: Float) {
        switch Int(ceil(achievement)) {
        case 0...20:
            self = .beginner
        case 21...40:
            self = .intermediate
        case 41...60:
            self = .skillful
        case 61...80:
            self = .advanced
        case 81...100:
            self = .expert
        default:
            self = .expert
        }
    }
}
