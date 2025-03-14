//
//  CustomTextfield.swift
//  SigninV2
//
//  Created by Гералд Бирген on 27.09.2020.
//

import SwiftUI

struct CustomTextfield: View {
    //MARK:- PROPERTIES
    var placeholder: Text
    var iconImage: Image?
    var fontName: String
    var fontSize: CGFloat
    var fontColor: Color
    var foregroundColor: Color?
    
    @Binding var username: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        
        HStack {
            if let iconImage = iconImage {
                iconImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.accent)
            }
            ZStack(alignment: .leading) {
                if username.isEmpty {
                    placeholder.modifier(CustomTextM(fontName: fontName, fontSize: fontSize, fontColor: fontColor))
                }
                TextField("", text: $username, onEditingChanged: editingChanged, onCommit: commit)
                    .foregroundColor((foregroundColor != nil) ?  foregroundColor : Color("Secondary"))
            }
        }
        //.padding()
    }
}
