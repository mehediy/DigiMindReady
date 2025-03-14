//
//  AudioRowView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/18/24.
//

import SwiftUI

struct AudioRowView: View {
    
    let audioItem: any AudioItem
    @ObservedObject var playerManager: AudioPlayerManager
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text(audioItem.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("Title"))

                Button(action: {
                    playerManager.playOrPause(audioItem)
                }) {
                    Image(systemName: playerManager.isPlayingThis(self.audioItem) ? "pause.fill" : "play.fill")
                        .foregroundColor(Color("Yellow"))
                }

//                Button(action: {
//                    playerManager.stop()
//                }) {
//                    Image(systemName: "stop.fill")
//                }
            }
            
            if playerManager.isPlayingThis(self.audioItem) {
                ProgressBar(value: $playerManager.progress).frame(maxWidth: .infinity, maxHeight: 3.0)
            }
            
        }

    }
}


//#Preview {
//    AudioRowView()
//}
