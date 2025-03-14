//
//  VirtualBookshelfView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/18/24.
//

import SwiftUI

struct VirtualBookshelfView: View {
    
    @Binding var navigationPath: NavigationPath
    @State var isHorizontal: Bool = false
    @State private var isPresented = false

    
    var body: some View {
        
        ScrollView {
            VStack {
                
                if isHorizontal {
                    // Horizontal Grid
                     ScrollView(.horizontal, showsIndicators: true) {
                         LazyHStack(alignment: .top, spacing: 10) {
                             ForEach(VirtualBookshelfData.books) { book in
                                 BookCoverView(book: book)
                                     .onTapGesture {
                                         navigationPath.append(book)
                                     }
                                 .frame(width: 110, height: 155, alignment: .topLeading) // Specify min and max width
                             }
                         }
                     }
                    
                } else {
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 10) {
                        ForEach(VirtualBookshelfData.books, id: \.self) { book in
                            BookCoverView(book: book)
                                .frame(width: 180, height: 280, alignment: .topLeading)
                                .onTapGesture {
                                    navigationPath.append(book)
                                }
                        }
                    }
                    .padding()
                }

            }
            .background(Color.white)
            .fullScreenCover(isPresented: $isPresented, content: T2ilesApp.init)

        }
        .background(Color.white)
        .toolbar(.hidden, for: .tabBar)
        .navigationDestination(for: BookInfo.self) { book in
            
            switch book.bookType {
            case .pdf:
                PDFUIView(fileName: book.filename!)
                    .ignoresSafeArea()
                    .navigationTitle("Digital Book")
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
                
            case .audio:
                AudioBookView(book: book)
//                    .ignoresSafeArea()
                    .navigationTitle("Audio Book")
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
                    .colorScheme(.light)
            }

        }
    }
}


struct VirtualBookshelfView_Preview : View {
    @State private var navigationPath = NavigationPath()

     var body: some View {
         NavigationStack(path: $navigationPath) {
             VirtualBookshelfView(navigationPath: $navigationPath, isHorizontal: true)
                 .padding()
         }
     }
}

#Preview {
    VirtualBookshelfView_Preview()
}
