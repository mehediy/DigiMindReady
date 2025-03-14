//
//  HomeViewData.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/16/24.
//

import Foundation


struct HomeViewData {
    
    static let eduScreenItems = [
        SectionItem(title: "Digital Wellness Education", iconName: "book.fill", eventType: .none, colorPalette: "blue1"),
        SectionItem(title: "Virtual Bookshelf", iconName: "books.vertical.fill", eventType: .none, colorPalette: "blue2"),
        SectionItem(title: "Offline Game", iconName: "gamecontroller.fill", eventType: .none, colorPalette: "blue3")
    ]

    static let advocatorItems = [
        SectionItem(title: "Sleep Advocator", iconName: "powersleep", eventType: .none, colorPalette: "green1"),
        SectionItem(title: "Activity Advocator", iconName: "figure.run", eventType: .none, colorPalette: "green2"),
        SectionItem(title: "Integrity Advocator", iconName: "hand.raised.slash.fill", eventType: .none, colorPalette: "brown1")
    ]
    
    static let screenItems = [
        SectionItem(title: "Screen Time Tracking", iconName: "sleep", eventType: .none, colorPalette: "red1"),
        SectionItem(title: "Screen Time Guideline", iconName: "book.fill", eventType: .none, colorPalette: "red2")
    ]
    
}


enum SectionEventType {
    case none // Use this for items without a detail view
}


struct SectionItem: Identifiable {
    let id = UUID()
    let title: String
    let iconName: String
    let eventType: SectionEventType
    let colorPalette: String
     
    var colorSet: ColorPalette.QuadColorSet {
        return ColorPalette.colors[colorPalette] ?? ColorPalette.colors.values.first!
    }
    
}

struct ColorPalette {
    static let colors: [String : QuadColorSet] = [
        "red1": QuadColorSet(first: "#A10513", second: "#C70520", third: "#FFCAD0", fourth: "#FFEAED"),
        "red2": QuadColorSet(first: "#522645", second: "#522645", third: "#E1B9D2", fourth: "#F2E3ED"),
        "blue1": QuadColorSet(first: "#0024A4", second: "#2155D9", third: "#C5D8F4", fourth: "#E8EEFB"),
        "blue2": QuadColorSet(first: "#221F75", second: "#2F308A", third: "#C5C8E6", fourth: "#E8E9F5"),
        "blue3": QuadColorSet(first: "#2164C7", second: "#3494FB", third: "#BDDEFE", fourth: "#E3F2FE"),
        "brown1": QuadColorSet(first: "#D36B10", second: "#D9A521", third: "#F2E6B4", fourth: "#FAF6E1"),
        "brown2": QuadColorSet(first: "#493201", second: "#704D00", third: "#F2E6B4", fourth: "#FAF6E1"),
        "green1": QuadColorSet(first: "#15351E", second: "#265233", third: "#BCE1D0", fourth: "#E3F3EC"),
        "green2": QuadColorSet(first: "#006119", second: "#089237", third: "#C3E8C9", fourth: "#E6F6E9"),
        "green3": QuadColorSet(first: "#15351E", second: "#4FBF67", third: "#4FBF67", fourth: "#E3F3EC")
    ]
    
    struct QuadColorSet {
        let first: String
        let second: String
        let third: String
        let fourth: String
    }
}
