//
//  VirtualBookshelfData.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/18/24.
//

import Foundation

struct VirtualBookshelfData {
    
    static private let audioBook = AudioBookInfo(chapters: [
        AudioBookChapter(name: "01 - Laying Plans / 02 - Waging War",
                                       reader: "Moira Fogarty",
                                       time: "00:08:26",
                                       filename: "art_of_war_01-02"),
        
        AudioBookChapter(name: "03 - Attack By Stratagem / 04 - Tactical Dispositions",
                                       reader: "Moira Fogarty",
                                       time: "00:07:45",
                                       filename: "art_of_war_03-04"),
        
        AudioBookChapter(name: "05 - Energy / 06 - Weak Points and Strong",
                                       reader: "Moira Fogarty",
                                       time: "00:10:36",
                                       filename: "art_of_war_05-06"),
        
        AudioBookChapter(name: "07 - Maneuvering / 08 - Variation in Tactics",
                                       reader: "Moira Fogarty",
                                       time: "00:08:50",
                                       filename: "art_of_war_07-08"),
        
        AudioBookChapter(name: "09 - The Army on the March / 10 - Terrain",
                                       reader: "Moira Fogarty",
                                       time: "00:14:42",
                                       filename: "art_of_war_09-10"),
        
        AudioBookChapter(name: "11 - The Nine Situations",
                                       reader: "Moira Fogarty",
                                       time: "00:12:56",
                                       filename: "art_of_war_11"),
        
        AudioBookChapter(name: "12 - The Attack By Fire / 13 - The Use of Spies",
                                       reader: "Moira Fogarty",
                                       time: "00:08:59",
                                       filename: "art_of_war_12-13"),
                                             
                                            ])
    
    static public let books: [BookInfo] = [
        BookInfo(title: "The Fundamentals of Military Readiness", author: "Herrera, G. James", bookType: .pdf, filename: "Military-Readiness", AudioBook: nil, coverPhoto: nil),
        BookInfo(title: "Study on Effects of Sleep Deprivation", author: "U.S. Naval Institute Staff", bookType: .pdf, filename: "Sleep-Deprivation", AudioBook: nil, coverPhoto: nil),
        BookInfo(title: "The Art of War", author: "Sun Tzu", bookType: .audio, filename: nil, AudioBook: VirtualBookshelfData.audioBook, coverPhoto: "Art_War_1107")
    ]
}
