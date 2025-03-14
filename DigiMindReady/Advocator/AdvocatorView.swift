//
//  AdvocatorView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 6/14/24.
//

import SwiftUI
import AVFoundation
import AVKit


struct AdvocatorView: View {
    
    @State private var navigationPath = NavigationPath()
    @State private var isSleepAdvocatorPresented = false
    
    let threeColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 8.0) {
                        
                        LazyVGrid(columns: threeColumns, spacing: 10) {
                            ForEach(HomeViewData.advocatorItems) { item in
                                CustomButton(item: item)
                                    .onTapGesture {
                                        //FIXME: - fullscreen or With Top Nav!
                                        //navigationPath.append(item.title)
                                        self.isSleepAdvocatorPresented.toggle()
                                    }
                            }
                        }
                        .padding(.top, 8)
                        .padding()
                        
                        Spacer(minLength: geometry.size.height * 0.5)
                        
                    }
                    
                }
                .background(Color.white)
                .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 24, topTrailing: 24)))
                
            }
            .background(VStack(spacing: .zero) { Color("Secondary"); Color.white })
            .navigationTitle("AI Advocator")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color("Secondary"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        print("Pressed")
                    } label: {
                        Image(systemName: "bell.fill")
                    }
                }
            }
            .toolbar(.visible, for: .tabBar)
            .navigationDestination(for: String.self) {title in
                switch title {
                case "Sleep Advocator":
                    SleepAdvocatorView()
                        .ignoresSafeArea()
                        .navigationTitle("Sleep Advocator")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarBackground(Color("Secondary"), for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .toolbar(.hidden, for: .tabBar)
                case "Activity Advocator":
                    EmptyView()
                case "Integrity Advocator":
                    EmptyView()
                default:
                    EmptyView()
                }
            }
            
        }
        .fullScreenCover(isPresented: $isSleepAdvocatorPresented) {
            SleepAdvocatorView()
        }
    }
    
}


#Preview {
    AdvocatorView()
}

