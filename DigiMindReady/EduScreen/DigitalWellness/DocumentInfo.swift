//
//  DocumentInfo.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/20/24.
//

import Foundation

struct DocumentInfo: Identifiable, Hashable {

    let id = UUID()
    
    let title: String
    let author: String
    let type: DocumentType
    let filename: String
    let fileExtension: String?
    let coverPhoto: String?
    
    enum DocumentType {
        case article
        case video
        case infographic
        
        var iconName: String {
            switch self {
            case .article:
                "doc.fill"
            case .video:
                "film.fill"
            case .infographic:
                "text.below.photo.fill"
            }
        }
        
        var colorSet: ColorPalette.QuadColorSet {
            switch self {
            case .article:
                ColorPalette.colors["red2"]!
            case .video:
                ColorPalette.colors["blue1"]!
            case .infographic:
                ColorPalette.colors["brown1"]!
            }
        }
    }
    
    static func == (lhs: DocumentInfo, rhs: DocumentInfo) -> Bool {
        return lhs.id == rhs.id
    }
}
