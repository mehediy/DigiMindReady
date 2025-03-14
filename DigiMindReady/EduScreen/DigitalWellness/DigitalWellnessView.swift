//
//  DigitalWellnessView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/19/24.
//

import SwiftUI
//import AVFoundation
//import AVKit

struct DigitalWellnessView: View {
    
    @Binding var navigationPath: NavigationPath
    //@State var isHorizontal: Bool = false
    //@State private var isPresented = false
    
    let threeColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    //var selectedDocument
    

    var body: some View {
        
        ScrollView {
            VStack(spacing: 8.0) {
                
                LazyVGrid(columns: threeColumns, spacing: 10) {
                    ForEach(DigitalWellnessData.digitalWellnessItems) { item in
                        
                        CustomButton(item: item)
                            .onTapGesture {
                                navigationPath.append(item.title)
                            }
                        
                    }
                }
                .padding(.top, 8)
                .padding()
                
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .frame(height: 5)
                    .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                    .padding(.vertical, 8)
                
                
                Text("All Document")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.horizontal)
                    .foregroundColor(Color("Title"))
                
                ForEach(DigitalWellnessData.documents) { document in
                    DocumentCardView(document: document)
                        .onTapGesture {
                            navigationPath.append(document)
                        }
                }
                
            }

        }
        .background(Color.white)
        .navigationTitle("Digital Wellness Education")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color("Secondary"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)

        
    }
}


struct DigitalWellness_Preview : View {
    @State private var navigationPath = NavigationPath()

     var body: some View {
         NavigationStack(path: $navigationPath) {
             DigitalWellnessView(navigationPath: $navigationPath)
         }
     }
}

#Preview {
    DigitalWellness_Preview()
}
