//
//  GlobalDropModifier.swift
//  Solply
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

struct GlobalDropModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding private var dragDropState: DragDropState
    
    private let endDragging: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        dragDropState: Binding<DragDropState>,
        endDragging: (() -> Void)? = nil
    ) {
        self._dragDropState = dragDropState
        self.endDragging = endDragging
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .onDrop(
                of: [.text],
                delegate: GlobalDropDelegate(
                    onDragEnd: {
                        print("GlobalDropDelegate: \(dragDropState)")
                        dragDropState = .completed
                        endDragging?()
                    }
                )
            )
    }
}

extension View {
    func globalDrop(
        dragDropState: Binding<DragDropState>,
        endDragging: (() -> Void)?
    ) -> some View {
        self.modifier(
            GlobalDropModifier(
                dragDropState: dragDropState,
                endDragging: endDragging
            )
        )
    }
}
