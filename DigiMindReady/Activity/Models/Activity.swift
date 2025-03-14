//
//  Activity.swift
//  ScreenSafeTots
//
//  Created by Md Mehedi Hasan on 9/15/23.
//

import Foundation

struct ActivityResponse: Codable {
    let activities: [Activity]
}

struct Activity: Codable {
    var name: String
    var explanation: String
    var impact: String
    var image: String?
    
    var activityType: ActivityType?
    var ageRange: AgeRange?
    var categories: [ActivityCategory]
    var duration: ActivityDuration?
    var parentSupervision: SupervisionLevel?
    var dynamicityLevel: DynamicityLevel?
    var specialOccasion: Bool
    
    var timelineStart: String
    var timelineEnd: String?
    

    var isFavorite: Bool {
        set { UserDefaults.standard.set(newValue, forKey: "isFavorite_\(name)") }
        get { return UserDefaults.standard.bool(forKey: "isFavorite_\(name)") }
    }
    
    var isMatched: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case name, categories
        case ageRange = "age_range"
        case dynamicityLevel = "level"
        case activityType = "activity_type"
        case duration
        case parentSupervision = "parent_supervision"
        case specialOccasion = "special_occasion"
        case explanation, impact, image
        case timelineStart = "timeline_start"
        case timelineEnd = "timeline_end"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        explanation = try values.decodeIfPresent(String.self, forKey: .explanation) ?? ""
        impact = try values.decodeIfPresent(String.self, forKey: .impact) ?? ""
        image = try values.decodeIfPresent(String.self, forKey: .image)
        activityType = try values.decodeIfPresent(ActivityType.self, forKey: .activityType)
        ageRange = try values.decodeIfPresent(AgeRange.self, forKey: .ageRange)
        categories = (try? values.decodeIfPresent([ActivityCategory].self, forKey: .categories)) ?? []
        duration = try values.decodeIfPresent(ActivityDuration.self, forKey: .duration)
        parentSupervision = try values.decodeIfPresent(SupervisionLevel.self, forKey: .parentSupervision)
        dynamicityLevel = try values.decodeIfPresent(DynamicityLevel.self, forKey: .dynamicityLevel)
        specialOccasion = try values.decodeIfPresent(Bool.self, forKey: .specialOccasion) ?? false
        
        timelineStart = try values.decodeIfPresent(String.self, forKey: .timelineStart) ?? "01-01"
        timelineEnd = try values.decodeIfPresent(String.self, forKey: .timelineEnd)
    }
    
    init(name: String, explanation: String, impact: String, image: String? = nil, activityType: ActivityType? = nil, ageRange: AgeRange? = nil, categories: [ActivityCategory], duration: ActivityDuration? = nil, parentSupervision: SupervisionLevel? = nil, dynamicityLevel: DynamicityLevel? = nil, specialOccasion: Bool, timelineStart: String, timelineEnd: String? = nil) {
        self.name = name
        self.explanation = explanation
        self.impact = impact
        self.image = image
        self.activityType = activityType
        self.ageRange = ageRange
        self.categories = categories
        self.duration = duration
        self.parentSupervision = parentSupervision
        self.dynamicityLevel = dynamicityLevel
        self.specialOccasion = specialOccasion
        self.timelineStart = timelineStart
        self.timelineEnd = timelineEnd
    }
}


enum AgeRange: String, Codable {
    case zero_eighteen = "0_18"
    case eighteen_thirtySix = "18_36"
    case all = "all"
    case thirtySixPlus = "36+"
    
    init(questionText: String) {
        switch questionText {
        case "0-18 months": self = .zero_eighteen
        case "18-36 months": self = .eighteen_thirtySix
        case "36+ months": self = .thirtySixPlus
        default: self = .thirtySixPlus
        }
    }
}

enum ActivityType: String, Codable {
    case indoor = "indoor"
    case outdoor = "outdoor"
    case indoorOutdoor = "indoor_outdoor"
    
    init(questionText: String) {
        switch questionText {
        case "Indoor": self = .indoor
        case "Outdoor": self = .outdoor
        case "Both Indoor and Outdoor": self = .indoorOutdoor
        default: self = .indoor
        }
    }
}

enum DynamicityLevel: String, Codable {
    case lessDynamic = "less_dynamic"
    case dynamic = "dynamic"
    case veryDynamic = "very_dynamic"
    
    init(questionText: String) {
        switch questionText {
        case "Not much, my child is less dynamic": self = .lessDynamic
        case "Moderate, my child is somewhat dynamic": self = .dynamic
        case "A lot, my child is very dynamic": self = .veryDynamic
        default: self = .dynamic
        }
    }
}

enum SupervisionLevel: String, Codable, Comparable {

    
    case limited = "limited"
    case moderate = "moderate"
    case constant = "constant"
    
    
    init(questionText: String) {
        switch questionText {
        case "I can constantly supervise my child during activities": self = .constant
        case "I can moderately supervise my child during activities": self = .moderate
        case "I can limitedly supervise my child during activities": self = .limited
        default: self = .limited
        }
    }
    
    var comparableValue: Int {
        switch self {
        case .limited:
            return 1
        case .moderate:
            return 2
        case .constant:
            return 3
        }
    }
    
    static func < (lhs: SupervisionLevel, rhs: SupervisionLevel) -> Bool {
        return lhs.comparableValue < rhs.comparableValue
    }
    
}

enum ActivityDuration: String, Codable, Comparable {

    case zero_thirty = "0_30"
    case thirtyOne_sixty = "31_60"
    case sixtyPlus = "60+"
    
    init(questionText: String) {
        switch questionText {
        case "Limited time: 30 minutes": self = .zero_thirty
        case "Moderate time: 30-60 minutes": self = .thirtyOne_sixty
        case "Extended time: 60+ minutes": self = .sixtyPlus
        default: self = .zero_thirty
        }
    }
    
    var comparableValue: Int {
        switch self {
        case .zero_thirty:
            return 30
        case .thirtyOne_sixty:
            return 60
        case .sixtyPlus:
            return 90
        }
    }
    
    static func < (lhs: ActivityDuration, rhs: ActivityDuration) -> Bool {
        return lhs.comparableValue < rhs.comparableValue
    }
}


enum ActivityCategory: String, Codable {
    case creative          // activities like painting, crafting, etc.
    case active            // sports, exercise, etc.
    case relaxation        // meditation, spa, reading, etc.
    case educational       // museums, lectures, reading, etc.
    case entertainment     // movies, concerts, theatre, etc.
    case social            // group outings, meetups, parties, etc.
    case culinary          // cooking, baking, etc.
    case digital           // tech, digital using electronics, etc.
    case adventure         // backpacking, traveling, etc.
    //case musical         // playing instruments, listening to music, etc.
    //case exploringNature   // hiking, bird watching, etc.
    case diy               // do it yourself projects, home improvement, etc.
    case gardening         // planting, landscaping, etc.
    case shopping          // mall visits, online shopping, etc.
    case occasional
    case other
    
    init(from decoder: Decoder) throws {
        let stringValue = try decoder.singleValueContainer().decode(String.self)
        self = ActivityCategory(rawValue: stringValue.lowercased()) ?? .other
    }
    
    init(questionText: String) {
        switch questionText {
        case "Creative (e.g., finger painting, clay modeling)": self = .creative
        case "Active (e.g., playing tag, jumping on a trampoline)": self = .active
        case "Relaxation (e.g., storytime, watching clouds)": self = .relaxation
        case "Educational (e.g., puzzle solving, learning numbers)": self = .educational
        case "Entertainment (e.g., puppet show, magic show)": self = .entertainment
        case "Social (e.g., playdates, birthday parties)": self = .social
        case "Culinary (e.g., cookie decorating, making pizza)": self = .culinary
        case "Digital (e.g., educational apps, animated cartoons)": self = .digital
        case "Adventure (e.g., treasure hunt, visiting a zoo)": self = .adventure
        case "DIY (e.g., making bird feeders, creating masks)": self = .diy
        case "Gardening (e.g., planting sunflowers, creating a fairy garden)": self = .gardening
        case "Shopping (e.g., picking toys, choosing snacks)": self = .shopping
        case "Occasional (e.g., Easter egg hunt, Halloween trick-or-treating)": self = .occasional
        default: self = .entertainment
        }
    }
    
    /*init(from decoder: Decoder) throws {
     let label = try decoder.singleValueContainer().decode(String.self)
     switch label {
     case "creative": self = .creative
     case "active": self = .active
     case "relaxation": self = .relaxation
     case "educational": self = .educational
     case "entertainment": self = .entertainment
     case "social": self = .social
     case "culinary": self = .culinary
     case "digital": self = .digital
     case "adventure": self = .adventure
     case "diy": self = .diy
     case "gardening": self = .gardening
     case "shopping": self = .shopping
     case "occasional": self = .occasional
     default: self = .other
     }
     }*/
    
}
