//
//  AudioBookView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/18/24.
//

import SwiftUI

struct AudioBookView: View {
    
    let book: BookInfo
    
    @ObservedObject var playerManager: AudioPlayerManager = AudioPlayerManager()
    
    init(book: BookInfo) {
        
        self.book = book
    }
    
    var body: some View {
        
        if let chapters = book.AudioBook?.chapters {

            List {
                Section {
                    ForEach(chapters) { chapter in
                        AudioRowView(audioItem: chapter, playerManager: playerManager)
                        //AudioRowView(audioItem: chapter)
                    }
                } header: {
                    VStack(alignment: .center, spacing: 8) {
                        
                        if let coverPhoto = book.coverPhoto {
                            HStack {
                                Spacer()
                                Image(coverPhoto)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                                Spacer()
                            }

                        }
                        
                        Text(book.title)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 12)
                            .foregroundColor(Color("Title"))
                        

                    }
                } footer: {
                    Text("All audio files are downloaded from LibriVox, which provides free public domain audiobooks. LibriVox recordings are in the Public Domain in the USA. If you are accessing this from outside the USA, please verify the copyright status of these works in your own country before accessing, to ensure compliance with local copyright laws.")
                        .padding(.top, 12)
                }
                .headerProminence(.increased)
            }
        }
    }
}

#Preview {
    AudioBookView(book: VirtualBookshelfData.books.last!)
}
