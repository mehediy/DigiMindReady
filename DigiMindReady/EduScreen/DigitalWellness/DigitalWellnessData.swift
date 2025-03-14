//
//  DigitalWellnessData.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/20/24.
//

import Foundation

struct DigitalWellnessData {

    static let digitalWellnessItems = [
        SectionItem(title: "Article", iconName: "doc.fill", eventType: .none, colorPalette: "red2"),
        SectionItem(title: "Video", iconName: "film.fill", eventType: .none, colorPalette: "blue1"),
        SectionItem(title: "Infographic", iconName: "text.below.photo.fill", eventType: .none, colorPalette: "brown1")
    ]
    
    static let documents: [DocumentInfo] = [
        DocumentInfo(title: "Taxonomy Of Military Readiness", author: "Mehedi Hasan", type: .infographic, filename: "MilitaryReadiness.png", fileExtension: nil, coverPhoto: nil),
        DocumentInfo(title: "Digital Health Readiness", author: "Mehedi Hasan", type: .video, filename: "digital-health-readiness", fileExtension: "mov", coverPhoto: nil),
        DocumentInfo(title: "Health Impact of Excessive Screen Time", author: "Ernest F. Martin Jr.", type: .article, filename: "Health Impact of EST", fileExtension: nil, coverPhoto: nil),
        DocumentInfo(title: "PSD, TBI, Sleep, and Performance in Military Personnel", author: "Brian A. Moore et al", type: .article, filename: "sleep-in-military-personnel", fileExtension: nil, coverPhoto: nil),
        DocumentInfo(title: "Improving mental health in U.S. Veterans using mHealth tools", author: "Chase Latour et al", type: .article, filename: "sleep-in-military-personnel", fileExtension: nil, coverPhoto: nil)
    ]
    
    static func documentsOf(_ type: DocumentInfo.DocumentType) -> [DocumentInfo] {
        DigitalWellnessData.documents.filter { $0.type == type }
    }
    
}


