//
//  ScreenTimeHomeView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/20/24.
//

import SwiftUI
import AVFoundation
import AVKit


struct ScreenTimeHomeView: View {
    
    @State private var navigationPath = NavigationPath()
    
    let threeColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        
        NavigationStack(path: $navigationPath) {
            
            ScrollView {
                VStack(spacing: 8.0) {
                    
                    LazyVGrid(columns: threeColumns, spacing: 10) {
                        ForEach(ScreenTimeHomePage.allCases, id: \.self) { page in
                            
                            CustomButton(item: page.sectionItem)
                                .onTapGesture {
                                    navigationPath.append(page)
                                }
                            
                        }
                    }
                    .padding(.top, 8)
                    .padding()
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .frame(height: 6)
                        .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                        .padding(.vertical)
                    
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
                    
                    Spacer(minLength: 20)
                    
                    
                }
                .background(Color.white)
                .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 24, topTrailing: 24)))
                
                
            }
            .background(VStack(spacing: .zero) { Color("Secondary"); Color.white })
            .navigationTitle("Screen Time")
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
            .navigationDestination(for: ScreenTimeHomePage.self) { page in
                
                switch page {
                case .guide:
                    ScreenTimeGuideView(navigationPath: $navigationPath)
                        .background(Color.white)
                        .navigationTitle("Screen Time Guidelines")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarBackground(Color("Secondary"), for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .toolbar(.hidden, for: .tabBar)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    print("Done tapped!")
                                    navigationPath.removeLast(navigationPath.count)
                                }
                            }
                        }
                        .toolbar(.hidden, for: .tabBar)
                case .schedule:
                    ScheduleView()
                        .ignoresSafeArea()
                        .navigationTitle("Screen Time Schedule")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarBackground(Color("Secondary"), for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .toolbar(.hidden, for: .tabBar)
                case .report:
                    MonitoringView()
                        .ignoresSafeArea()
                        .navigationTitle("Screen Time Report")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarBackground(Color("Secondary"), for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .toolbar(.hidden, for: .tabBar)
                }
                
            }
            .navigationDestination(for: String.self) { guidelineTitle in
                
                switch guidelineTitle {
                case "Optimizing Digital Wellbeing with Screen Time":
                    ScreenTimeTutorial()
                        .ignoresSafeArea()
                        .navigationTitle("Screen Time")
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
                case "Screen Distance feature on your iPhone offers several benefits":
                    ScreenDistanceView()
                        .ignoresSafeArea()
                        .navigationTitle("Screen Distance")
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
                default:
                    EmptyView()
                }
                
            }
            
            
        }
    }
}


#Preview {
    ScreenTimeHomeView()
}

