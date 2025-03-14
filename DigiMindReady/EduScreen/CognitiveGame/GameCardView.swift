//
//  GameCardView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/18/24.
//

import SwiftUI

struct GameCardView: View {
    var game: CognitiveGame
    
    let colorSet = ColorPalette.colors["blue3"] ?? ColorPalette.colors.values.first!
    
    var body: some View {
        VStack {
            Image(game.iconName)
                .resizable()
                .scaledToFit()
                .padding(10)
                .frame(minWidth: 60, minHeight: 60)
                .padding(.top, 16)
                
            Text(game.title)
                .multilineTextAlignment(.center)
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 8)
                .padding(.bottom, 16)
                .foregroundStyle(Color.black)
            
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(hex: colorSet.fourth)))
    }
}
