//
//  MaxLengthModifier.swift
//  Solply
//
//  Created by 선영주 on 7/11/25.
//

import SwiftUI

struct MaxLengthModifier: ViewModifier {
    @Binding var text: String
    let maxLength: Int

    func body(content: Content) -> some View {
        content
            .onChange(of: text) { _, newValue in
                if newValue.count > maxLength {
                    text = String(newValue.prefix(maxLength))
                }
            }
    }
}

extension View {
    func maxLength(text: Binding<String>, _ maxLength: Int) -> some View {
        modifier(MaxLengthModifier(text: text, maxLength: maxLength))
    }
}
