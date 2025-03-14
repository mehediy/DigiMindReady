//
//  CognitiveGameView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/17/24.
//

import SwiftUI

struct CognitiveGameView: View {
    
    @State var isHorizontal: Bool = false
    @State private var isPresented = false
    
    var body: some View {
        
        ScrollView {
            VStack {
                
                if isHorizontal {
                    // Horizontal Grid
                     ScrollView(.horizontal, showsIndicators: true) {
                         LazyHStack(alignment: .top, spacing: 10) {
                             ForEach(CognitiveGame.allCases) { game in
                                 GameCardView(game: game)
                                     .frame(width: 100)
                                     .onTapGesture {
                                         switch game {
                                         case .numberPuzzle:
                                             isPresented.toggle()
                                         default:
                                             break
                                         }
                                     }
                             }
                         }
                         .frame(height: 100)
                     }
                    

                    
                } else {
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 10) {
                        ForEach(CognitiveGame.allCases) { game in
                            GameCardView(game: game)
                                .frame(height: 150)
                                
                        }
                    }
                    .padding()
                }

            }
            .fullScreenCover(isPresented: $isPresented, content: T2ilesApp.init)
        }
        .background(Color.white)
    }
}


#Preview {
    CognitiveGameView()
}
