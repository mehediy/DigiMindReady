//
//  HomeView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 11/7/23.
//

import SwiftUI

@MainActor
struct HomeView: View {
    
    @State private var selectedItemId: UUID?
    
    //@StateObject var eventViewModel = EventViewModel()
    
    @Binding var popToRootTab: Tab
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    init(popToRootTab: Binding<Tab>) {
        _popToRootTab = popToRootTab
    }
    

    private func choose(_ item: SectionItem) {
        if item.eventType != .none {
            print(item.title)
            self.selectedItemId = item.id
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                VStack(spacing: 8.0) {
                    
                    Text("Welcome  👋")
                        .font(.title)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .foregroundColor(Color(red: 0, green: 0.03, blue: 0.24))

                    Text("Need a helping hand today?")
                        .font(.title2)
                        .foregroundColor(.black.opacity(0.5))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    
                    Text("Edu Screen")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.top, 8)
                        .foregroundColor(Color("Title"))

                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(HomeViewData.eduScreenItems) { item in

                            NavigationLink {
                                switch item.eventType {
                                default:
                                    EmptyView()
                                }
                            } label: {
                                CustomButton(item: item)
                            }
                        }
                    }
                    

                    Text("AI Advocator")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.top, 12)
                        .foregroundColor(Color("Title"))
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(HomeViewData.advocatorItems) { item in
                            CustomButton(item: item)
                        }
                    }
                    
                    Text("Screen Time")                        
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.top, 12)
                        .foregroundColor(Color("Title"))
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(HomeViewData.screenItems) { item in
                            CustomButton(item: item)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 24, topTrailing: 24)))
                
                
            }
            .background(VStack(spacing: .zero) { Color("Secondary"); Color.white })
            .navigationTitle("DigiMindReady")
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
            
            
            
            // Conditional navigation links
            ForEach(HomeViewData.eduScreenItems) { item in
                Group {
                    switch item.eventType {
                        //                    case .learning:
                        //
                        //                        NavigationLink(destination: LearningModuleView(popToRootTab: self.$popToRootTab),
                        //                                       tag: item.id,
                        //                                       selection: $selectedItemId) {
                        //                            EmptyView()
                        //                        }
                    default:
                        EmptyView()
                    }
                }
            }
        }
    }
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let binding: Binding<Tab> = .constant(.home)
        return HomeView(popToRootTab: binding)
    }
}






struct CustomButton: View {
    var item: SectionItem
    
    var body: some View {
        VStack {
            Image(systemName: item.iconName)
                .resizable()
                .scaledToFit()
                .padding(10)
                .frame(width: 40, height: 40)
                .background(Color(hex: item.colorSet.third))
                .clipShape(Circle())
                .foregroundColor(Color(hex: item.colorSet.second))
                .padding(.top, 16)
                
            Text(item.title)
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 8)
                .padding(.top, 8)
                .padding(.bottom, 12)
                .foregroundStyle(Color.black)
            
        }
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(hex: item.colorSet.fourth)))
    }
}




