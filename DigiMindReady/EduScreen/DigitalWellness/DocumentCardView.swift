//
//  DocumentCardView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/20/24.
//

import SwiftUI

struct DocumentCardView: View {
    let document: DocumentInfo

    var body: some View {
        HStack {
    
            VStack(alignment: .center) {
                Image(systemName: document.type.iconName)
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(hex: document.type.colorSet.second))
                    
            }
            .frame(width: 60, height: 60)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(hex: document.type.colorSet.fourth)))
            
            VStack(alignment: .leading) {
                Text(document.title)
                    .font(.headline)
                    .foregroundColor(Color("Title"))
                Text(document.author)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.all, 10)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}
