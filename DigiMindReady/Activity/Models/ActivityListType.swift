//
//  ActivityListType.swift
//  ScreenSafeTots
//
//  Created by Md Mehedi Hasan on 10/9/23.
//

import Foundation


enum ActivityListType: String, Codable, CaseIterable {
    case allMatched
    case allSorted

    
    init?(intValue: Int) {
        switch intValue {
        case 0:
            self = .allMatched
        case 1:
            self = .allSorted
        default:
            return nil
        }
    }
    
//    var imageName: String {
//        switch self {
//        case .website:
//            return "link"
//        case .pdf:
//            return "doc.text"
//        case .video:
//            return "film"
//        case .all:
//            return ""
//        }
//    }
    
    var title: String {
        
        switch self {
        case .allMatched:
            return "Matched Activities"
        case .allSorted:
            return "View All"
        }
    }
    
}
