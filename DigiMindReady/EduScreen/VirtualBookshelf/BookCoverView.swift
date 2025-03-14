//
//  BookCoverView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/18/24.
//

import SwiftUI

struct BookCoverView: View {
    let book: BookInfo
    
    let colorSet = ColorPalette.colors["blue3"] ?? ColorPalette.colors.values.first!
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 10) {
            Text(book.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .minimumScaleFactor(0.1)

            Text(book.author)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .minimumScaleFactor(0.1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(12)
        .overlay(alignment: .bottomTrailing) {
            if book.isAudiobook {
                Image(systemName: "airpodsmax")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color("Brown"))
                    .minimumScaleFactor(0.25)
                    .padding(8)
            }
        }
        //.frame(width: 180, height: 280, alignment: .topLeading)
        //.frame(minWidth: 90, maxWidth: 140) // Specify min and max width
        //.aspectRatio(0.625, contentMode: .fit) // This maintains the 1:1.6 ratio
        .foregroundColor(.clear)
        .background(
          EllipticalGradient(
            stops: [
              Gradient.Stop(color: Color(red: 0.78, green: 0.02, blue: 0.13), location: 0.00),
              Gradient.Stop(color: Color("Yellow"), location: 1.00),
            ],
            center: UnitPoint(x: 0, y: 0)
          )
        )
        /*.background(
            LinearGradient(gradient: Gradient(colors: [Color("BlueLight"), Color("Yellow")]),
                           startPoint: .top,
                           endPoint: .bottomTrailing
                          ))*/
        .cornerRadius(8)
        .shadow(radius: 5)
        .padding(8)

        
    }
}
