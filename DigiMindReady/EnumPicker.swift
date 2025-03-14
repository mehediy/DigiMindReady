//
//  EnumPicker.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 11/6/23.
//

import SwiftUI


struct EnumPicker<T: Hashable & CaseIterable, V: View>: View {
    
    @Binding var selected: T
    var title: String? = nil
    
    let mapping: (T) -> V
    
    var body: some View {
        Picker(selection: $selected, label: Text(title ?? "")) {
            ForEach(Array(T.allCases), id: \.self) {
                mapping($0).tag($0)
            }
        }
    }
}


extension EnumPicker where T: RawRepresentable, T.RawValue == String, V == Text {
    init(selected: Binding<T>, title: String? = nil) {
        self.init(selected: selected, title: title) {
            Text($0.rawValue)
        }
    }
}
