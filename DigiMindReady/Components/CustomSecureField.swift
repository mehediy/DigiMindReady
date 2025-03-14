//
//  CustomSecureField.swift
//  SigninV2
//
//  Created by Гералд Бирген on 27.09.2020.
//

import SwiftUI

struct CustomSecureField: View {
    //MARK:- PROPERTIES    
    var placeholder: Text
    var iconImage: Image?
    var fontName: String
    var fontSize: CGFloat
    var fontColor: Color
    
    @Binding var password: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        HStack {
            if let iconImage = iconImage {
                iconImage.foregroundColor(Color.accent)
            }
            
            ZStack(alignment: .leading) {
                if password.isEmpty { placeholder.modifier(CustomTextM(fontName: fontName, fontSize: fontSize, fontColor: fontColor)) }
                SecureField("", text: $password, onCommit: commit)
                    .foregroundColor(Color("Secondary"))
            }
        }
    }
}

