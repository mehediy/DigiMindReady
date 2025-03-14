//
//  EduScreenView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/17/24.
//

import SwiftUI
import AVFoundation
import AVKit


struct EduScreenView: View {
    
    @State private var navigationPath = NavigationPath()
    
    let threeColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        
        NavigationStack(path: $navigationPath) {
            
            ScrollView {
                VStack(spacing: 8.0) {
                    
                    Text("Edu Screen")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.top, 20)
                        .padding(.horizontal)
                        .foregroundColor(Color("Title"))
                    
                    LazyVGrid(columns: threeColumns, spacing: 10) {
                        ForEach(HomeViewData.eduScreenItems) { item in
                            
                            CustomButton(item: item)
                                .onTapGesture {
                                    navigationPath.append(item.title)
                                }
                            
                        }
                    }
                    .padding(.horizontal)
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .frame(height: 6)
                        .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                        .padding(.vertical)
                    
                    Text("Cognitive Game")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.horizontal)
                        .foregroundColor(Color("Title"))
                    
                    CognitiveGameView(isHorizontal: true)
                        .padding(.horizontal)
                    
                    Text("Virtual Bookshelf")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.top, 8)
                        .padding(.horizontal)
                        .foregroundColor(Color("Title"))
                    
                    VirtualBookshelfView(navigationPath: $navigationPath, isHorizontal: true)
                        .padding(.horizontal)
                    
                    Text("Digital Wellness Education")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.top, 8)
                        .padding(.horizontal)
                        .foregroundColor(Color("Title"))
                    
                    ForEach(DigitalWellnessData.documents) { document in
                        DocumentCardView(document: document)
                            .onTapGesture {
                                navigationPath.append(document)
                            }
                    }
                    
                    Spacer(minLength: 20)
                    
                    
                }
                .background(Color.white)
                .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 24, topTrailing: 24)))
                
                
            }
            .background(VStack(spacing: .zero) { Color("Secondary"); Color.white })
            .navigationTitle("Edu Screen Repository")
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
            .navigationDestination(for: String.self) { pathValue in
                switch pathValue {
                case "Offline Game":
                    //let surveyViewModel = SurveyViewModel()
                    //SurveyListView(navigationPath: $navigationPath, viewModel: surveyViewModel)
                    CognitiveGameView(isHorizontal: false)
                        .navigationTitle("Offline Game")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarBackground(Color("Secondary"), for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .toolbar(.hidden, for: .tabBar)
                    
                case "Virtual Bookshelf":
                    VirtualBookshelfView(navigationPath: $navigationPath)
                        .navigationTitle("Virtual Bookshelf")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarBackground(Color("Secondary"), for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .toolbar(.hidden, for: .tabBar)
                    
                case "Digital Wellness Education":
                    DigitalWellnessView(navigationPath: $navigationPath)
                        .navigationTitle("Digital Wellness Education")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarBackground(Color("Secondary"), for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .toolbar(.hidden, for: .tabBar)
                default:
                    EmptyView()
                }
            }
            .navigationDestination(for: DocumentInfo.self) { document in
                
                switch document.type {
                case .article:
                    PDFUIView(fileName: document.filename)
                        .ignoresSafeArea()
                        .navigationTitle("Article")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarBackground(Color("Secondary"), for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    print("Done tapped!")
                                    navigationPath.removeLast(navigationPath.count)
                                }
                            }
                        }
                        .toolbar(.hidden, for: .tabBar)
                    
                case .video:
                    VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: document.filename, withExtension: document.fileExtension)!))
                        .ignoresSafeArea()
                        .navigationTitle("Video")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarBackground(Color("Secondary"), for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    print("Done tapped!")
                                    navigationPath.removeLast(navigationPath.count)
                                }
                            }
                        }
                        .toolbar(.hidden, for: .tabBar)
                case .infographic:
                        ImageViewer(imageName: document.filename)
                    
                }

            }
            
            
        }
    }
}


#Preview {
    EduScreenView()
}

