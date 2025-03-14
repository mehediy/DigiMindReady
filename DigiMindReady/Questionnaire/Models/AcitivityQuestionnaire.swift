//
//  Questionnaire.swift
//  ScreenSafeTots
//
//  Created by Md Mehedi Hasan on 10/6/23.
//

import Foundation

enum ActivityAttribute: String {
    case isWorkingParent = "is-working-parent"
    case childAgeRange = "child-age-range"
    case childGender = "child-gender"
    case preferredActivity = "preferred-activity"
    case parentSupervision = "parent-supervision"
    case interestedInHolidays = "interested-in-holidays"
    case childDynamicityLevel = "child-dynamicity-level"
    case parentAvailableDuration = "parent-available-duration"
    case preferredCategories = "preferred-categories"
}


struct ActivityQuestionnaire: Codable {
    var isWorkingParent: Bool
    var childAgeRange: AgeRange
    var childGender: ChildGender
    var preferredActivityType: ActivityType
    var parentSupervision: SupervisionLevel
    var interestedInHolidays: Bool
    var childDynamicityLevel: DynamicityLevel
    var parentAvailableDuration: ActivityDuration
    var preferredCategories: [ActivityCategory]
    
    
    init(filledSurvey: Survey) {
        
        var isWorkingParent: Bool = true
        var childAgeRange: AgeRange = .thirtySixPlus
        var childGender: ChildGender = .preferNot
        var preferredActivityType: ActivityType = .indoor
        var parentSupervision: SupervisionLevel = .limited
        var interestedInHolidays: Bool = true
        var childDynamicityLevel: DynamicityLevel = .lessDynamic
        var parentAvailableDuration: ActivityDuration = .zero_thirty
        var preferredCategories: [ActivityCategory] = []
        
        for question in filledSurvey.questions {
            
            if let activityAtributeType = ActivityAttribute(rawValue: question.tag) {
                switch activityAtributeType {
                case .isWorkingParent:
                    if let binaryQuestion = question as? BinaryQuestion {
                        if let selectedChoice = binaryQuestion.choices.filter( { $0.selected }).first {
                            isWorkingParent = Self.stringToBool(stringValue: selectedChoice.text)
                        }
                    }
                case .childAgeRange:
                    if let mcQuestion = question as? MultipleChoiceQuestion {
                        if let selectedChoice = mcQuestion.choices.filter( { $0.selected }).first {
                            childAgeRange = AgeRange(questionText: selectedChoice.text)
                        }
                    }
                case .childGender:
                    if let mcQuestion = question as? MultipleChoiceQuestion {
                        if let selectedChoice = mcQuestion.choices.filter( { $0.selected }).first {
                            childGender = ChildGender(rawValue: selectedChoice.text)
                        }
                    }
                case .preferredActivity:
                    if let mcQuestion = question as? MultipleChoiceQuestion {
                        if let selectedChoice = mcQuestion.choices.filter( { $0.selected }).first {
                            preferredActivityType = ActivityType(questionText: selectedChoice.text)
                        }
                    }
                case .parentSupervision:
                    if let mcQuestion = question as? MultipleChoiceQuestion {
                        if let selectedChoice = mcQuestion.choices.filter( { $0.selected }).first {
                            parentSupervision = SupervisionLevel(questionText: selectedChoice.text)
                        }
                    }
                case .interestedInHolidays:
                    if let binaryQuestion = question as? BinaryQuestion {
                        if let selectedChoice = binaryQuestion.choices.filter( { $0.selected }).first {
                            interestedInHolidays = Self.stringToBool(stringValue: selectedChoice.text)
                        }
                    }
                case .childDynamicityLevel:
                    if let mcQuestion = question as? MultipleChoiceQuestion {
                        if let selectedChoice = mcQuestion.choices.filter( { $0.selected }).first {
                            childDynamicityLevel = DynamicityLevel(questionText: selectedChoice.text)
                        }
                    }
                case .parentAvailableDuration:
                    if let mcQuestion = question as? MultipleChoiceQuestion {
                        if let selectedChoice = mcQuestion.choices.filter( { $0.selected }).first {
                            parentAvailableDuration = ActivityDuration(questionText: selectedChoice.text)
                        }
                    }
                case .preferredCategories:
                    if let mcQuestion = question as? MultipleChoiceQuestion {
                        preferredCategories = mcQuestion.choices.filter( { $0.selected }).map { ActivityCategory(questionText: $0.text) }
                    }
                }
            }
        }
        
        self.isWorkingParent = isWorkingParent
        self.childAgeRange = childAgeRange
        self.childGender = childGender
        self.preferredActivityType = preferredActivityType
        self.parentSupervision = parentSupervision
        self.interestedInHolidays = interestedInHolidays
        self.childDynamicityLevel = childDynamicityLevel
        self.parentAvailableDuration = parentAvailableDuration
        self.preferredCategories = preferredCategories
    }
    
    
    static func stringToBool(stringValue: String) -> Bool {
        switch stringValue.lowercased() {
        case "yes": return true
        case "no": return false
        default: return true
        }
    }
    
}


enum ChildGender: String, Codable {
    case male = "Male"
    case female = "Female"
    case preferNot = "Prefer not to disclose"
    
    init(from decoder: Decoder) throws {
        let stringValue = try decoder.singleValueContainer().decode(String.self)
        self = ChildGender(rawValue: stringValue)
    }
    
    init(rawValue: String) {
        switch rawValue {
        case "Male": self = .male
        case "Female": self = .female
        case "Prefer not to disclose": self = .preferNot
        default: self = .preferNot
        }
    }
}
