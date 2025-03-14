//
//  BookInfo.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/18/24.
//

import Foundation

struct BookInfo: Identifiable, Hashable {

    let id = UUID()
    
    let title: String
    let author: String
    let bookType: BookType
    let filename: String?
    let AudioBook: AudioBookInfo?
    let coverPhoto: String?
    
    var isAudiobook: Bool {
        return bookType == .audio
    }
    
    enum BookType {
        case pdf
        case audio
    }
    
    static func == (lhs: BookInfo, rhs: BookInfo) -> Bool {
        return lhs.id == rhs.id
    }
}



struct AudioBookInfo: Identifiable, Hashable {
    let id = UUID()
    let chapters: [AudioBookChapter]
    

    
    static func == (lhs: AudioBookInfo, rhs: AudioBookInfo) -> Bool {
        return lhs.id == rhs.id
    }
    
//    public func hash(into hasher: inout Hasher) {
//        return hasher.combine(id)
//    }
}

struct AudioBookChapter: AudioItem, Hashable {

    let id = UUID()
    //let section: String
    let name: String
    let reader: String
    let time: String
    let filename: String
    
    var title: String {
        return name
    }
    
    var singer: String {
        return reader
    }
}


protocol AudioItem: Identifiable, Equatable {
    var id: UUID { get }
    var title: String { get }
    var singer: String { get }
    var time: String { get }
    var filename: String { get }
}



