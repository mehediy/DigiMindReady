//
//  ImageViewer.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/20/24.
//

import SwiftUI

struct ImageViewer: View {
    
    let imageName: String
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScaleValue: CGFloat = 1.0
    @State private var offset: CGSize = .zero

    var body: some View {
        GeometryReader { geometry in
            ScrollView([.horizontal, .vertical], showsIndicators: false) {
                if let image = UIImage(named: imageName) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(scale)
                        .offset(offset)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    let delta = value / self.lastScaleValue
                                    self.lastScaleValue = value
                                    let newScale = self.scale * delta
                                    self.scale = newScale
                                }
                                .onEnded { _ in
                                    self.lastScaleValue = 1.0
                                }
                        )
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    self.offset = CGSize(width: self.offset.width + value.translation.width, height: self.offset.height + value.translation.height)
                                }
                                .onEnded { _ in
                                    self.offset = self.offset
                                }
                        )
                        .onTapGesture(count: 2) {
                            if scale > 1 {
                                scale = 1
                                offset = .zero
                            } else {
                                scale = 3
                            }
                        }
                }
            }
        }
    }
}
