//
//  GlobalDropModifier.swift
//  Solply
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

struct GlobalDropModifier: ViewModifier {
    
    // MARK: - Properties
    
    private let endDragging: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        endDragging: (() -> Void)?
    ) {
        self.endDragging = endDragging
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .onDrop(
                of: [.text],
                delegate: GlobalDropDelegate(
                    onDragEnd: {
                        endDragging?()
                    }
                )
            )
    }
}

extension View {
    func globalDrop(endDragging: (() -> Void)? = nil) -> some View {
        self.modifier(
            GlobalDropModifier(
                endDragging: endDragging
            )
        )
    }
}
