//
//  ProfileType.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/21/24.
//

import Foundation

enum ProfileType: Int, CaseIterable, Codable {
    
    case profile
    case changePassword
    case logout
    
    case language
    case survey
    case tnc
    case privacy
    case faq
    case contactUs
    case aboutUs
    case version
    
    
    var titleKey: String {
        switch self {
        case .profile:
            //"My Profile"
            "profile.row.my.profile"
        case .changePassword:
            //"Change Password"
            "profile.row.change.password"
        case .logout:
            //"Log Out"
            "profile.row.log.out"
            
        case .language:
            //"Choose Language"
            "profile.row.language"
        case .survey:
            //"Submit a Survey"
            "profile.row.submit.survey"
        case .tnc:
            //"Terms & Conditions"
            "profile.row.terms"
        case .privacy:
            //"Privacy Policy"
            "profile.row.privacy"
        case .faq:
            //"FAQ"
            "profile.row.faq"
        case .contactUs:
            //"Contact Us"
            "profile.row.contact.us"
        case .aboutUs:
            //"About Us"
            "profile.row.about.us"
        case .version:
            //"Version"
            "profile.row.version"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .profile:
            nil
        case .changePassword:
            nil
        case .language:
            nil
        case .survey:
            nil
        case .contactUs:
            nil
        case .aboutUs:
            nil
        case .logout:
            nil
        case .version:
            "1.0.0"
        default:
            nil
        }
    }
    
    static var profileModels: [ProfileModel] {
        
        let firstSection: [ProfileType] = [.profile, .changePassword, .logout]
        //[, .changePassword, .contactUs]
        let secondSection: [ProfileType] = [.tnc, .privacy, .faq, .contactUs, .aboutUs, .version]
        
        let settings = [
            ProfileModel(
                group: "User Profile",
                items: firstSection.map { ProfileItem(titleKey: $0.titleKey, text: $0.subtitle, type: $0) }
            ),
            ProfileModel(
                group: "Others",
                items: secondSection.map { ProfileItem(titleKey: $0.titleKey, text: $0.subtitle, type: $0) }
            )
        ]
        
        return settings
    }
    
    var isNavigationLink: Bool {
        switch self {
        case .language, .survey, .logout, .version:
            false
        default:
            true
        }
    }
    
}


struct ProfileItem: Identifiable {
    var id = UUID()
    var titleKey: String
    var text: String? = ""
    var type: ProfileType
    
    mutating func setTitle(_ title: String) {
        self.titleKey = title
    }
}

struct ProfileModel: Identifiable {
    var id = UUID()
    var group: String
    var items: [ProfileItem]
    
    mutating func updateTitle(_ title: String, item: ProfileItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            //items[index].titleKey = title
            items[index].setTitle(title)
        }
    }
}
