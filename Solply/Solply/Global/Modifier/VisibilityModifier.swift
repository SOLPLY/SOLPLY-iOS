//
//  VisibilityModifier.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct VisibilityModifier: ViewModifier {
    let isVisible: Bool
    
    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .allowsHitTesting(isVisible)
    }
}

extension View {
    func visible(_ isVisible: Bool) -> some View {
        self.modifier(VisibilityModifier(isVisible: isVisible))
    }
}
