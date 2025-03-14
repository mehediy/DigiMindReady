//
//  ProgressBar.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/18/24.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color.blue)
                    .animation(.linear, value: value)
            }.cornerRadius(45.0)
        }
    }
}
