//
//  ScreenTimeGuideView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/23/24.
//

import SwiftUI
//import AVFoundation
//import AVKit

struct ScreenTimeGuideView: View {
    
    @Binding var navigationPath: NavigationPath
    //@State var isHorizontal: Bool = false
    //@State private var isPresented = false
    
    let threeColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    //var selectedDocument
    

    var body: some View {
        
        ScrollView {
            VStack(spacing: 8.0) {
                

                Text("All Guidelines")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .foregroundColor(Color("Title"))
                
                ForEach(ScreenTimeGuideData.guidelines, id: \.self) { guideline in
                    GuidelineCardView(title: guideline)
                        .onTapGesture {
                            navigationPath.append(guideline)
                        }
                }
                
            }

        }

        
    }
}

//"info.square.fill", eventType: .none, colorPalette: "blue2")
struct GuidelineCardView: View {
    let title: String
    let colorSet = ColorPalette.colors["blue2"]!

    var body: some View {
        HStack {
    
            VStack(alignment: .center) {
                Image(systemName: "info.square.fill")
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(hex: colorSet.second))
                    
            }
            .frame(width: 60, height: 60)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(hex: colorSet.fourth)))
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color("Title"))
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


struct ScreenTimeGuideView_Preview : View {
    @State private var navigationPath = NavigationPath()

     var body: some View {
         NavigationStack(path: $navigationPath) {
             ScreenTimeGuideView(navigationPath: $navigationPath)
         }
     }
}

#Preview {
    ScreenTimeGuideView_Preview()
}

