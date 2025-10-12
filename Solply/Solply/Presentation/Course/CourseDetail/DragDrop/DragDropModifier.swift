//
//  DragDropModifier.swift
//  Solply
//
//  Created by 김승원 on 9/29/25.
//

import SwiftUI

struct DragDropModifier: ViewModifier {
    
    // MARK: - Properties
    
    private let isEditing: Bool
    private let startDragging: (() -> Void)?
    private let whileDragging: (() -> Void)?
    private let endDragging: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        isEditing: Bool,
        startDragging: (() -> Void)?,
        whileDragging: (() -> Void)?,
        endDragging: (() -> Void)?
    ) {
        self.isEditing = isEditing
        self.startDragging = startDragging
        self.whileDragging = whileDragging
        self.endDragging = endDragging
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        if isEditing {
            content
                .onDrag {
                    guard isEditing else { return NSItemProvider() }
                    
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                    
                    startDragging?()
                    
                    return NSItemProvider()
                }
                .onDrop(
                    of: [.text],
                    delegate: DragDropDelegate(
                        onMove: {
                            whileDragging?()
                        },
                        onDragEnd: {
                            endDragging?()
                        }
                    )
                )
        } else {
            content
        }
    }
}

// MARK: - DragDropDelegate

struct DragDropDelegate: DropDelegate {
    let onMove: () -> Void
    let onDragEnd: () -> Void
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        onDragEnd()
        return true
    }
    
    func dropEntered(info: DropInfo) {
        onMove()
    }
}

extension View {
    func dragDrop(
        isEditing: Bool,
        startDragging: (() -> Void)?,
        whileDragging: (() -> Void)?,
        endDragging: (() -> Void)?
    ) -> some View {
        self.modifier(
            DragDropModifier(
                isEditing: isEditing,
                startDragging: startDragging,
                whileDragging: whileDragging,
                endDragging: endDragging
            )
        )
    }
}
