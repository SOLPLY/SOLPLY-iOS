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

// MARK: - GlobalDropDelegate

struct GlobalDropDelegate: DropDelegate {
    let onDragEnd: () -> Void
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        onDragEnd()
        return true
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
