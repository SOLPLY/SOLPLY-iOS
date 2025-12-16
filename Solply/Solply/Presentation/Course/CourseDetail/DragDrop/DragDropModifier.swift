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
    private let endWithoutDragging: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        isEditing: Bool,
        startDragging: (() -> Void)?,
        whileDragging: (() -> Void)?,
        endDragging: (() -> Void)?,
        endWithoutDragging: (() -> Void)?
    ) {
        self.isEditing = isEditing
        self.startDragging = startDragging
        self.whileDragging = whileDragging
        self.endDragging = endDragging
        self.endWithoutDragging = endWithoutDragging
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        if isEditing {
            content
                .overlay(
                    LongPressRecognizerView {
                        endWithoutDragging?()
                    }
                )
                .onDrag {
                    guard isEditing else { return NSItemProvider() }
                    
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
        endDragging: (() -> Void)?,
        endWithoutDragging: (() -> Void)?
    ) -> some View {
        self.modifier(
            DragDropModifier(
                isEditing: isEditing,
                startDragging: startDragging,
                whileDragging: whileDragging,
                endDragging: endDragging,
                endWithoutDragging: endWithoutDragging
            )
        )
    }
}
