//
//  DeleteDropModifier.swift
//  Solply
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

struct DeleteDropModifier: ViewModifier {
    
    // MARK: - Properties
    
    private let onDelete: (() -> Void)?
    private let onEntered: (() -> Void)?
    private let onExited: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        onDelete: (() -> Void)?,
        onEntered: (() -> Void)?,
        onExited: (() -> Void)?
    ) {
        self.onDelete = onDelete
        self.onEntered = onEntered
        self.onExited = onExited
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .onDrop(
                of: [.text],
                delegate: DeleteDropDelegate(
                    onDelete: {
                        onDelete?()
                    },
                    onEntered: {
                        onEntered?()
                    },
                    onExited: {
                        onExited?()
                    }
                )
            )
    }
}

// MARK: - DeleDropDelegate

struct DeleteDropDelegate: DropDelegate {
    let onDelete: () -> Void
    let onEntered: () -> Void
    let onExited: () -> Void

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        onDelete()
        return true
    }

    func dropEntered(info: DropInfo) {
        onEntered()
    }

    func dropExited(info: DropInfo) {
        onExited()
    }
}

extension View {
    func deleteDrop(
        onDelete: (() -> Void)? = nil,
        onEntered: (() -> Void)? = nil,
        onExited: (() -> Void)? = nil
    ) -> some View {
        self.modifier(
            DeleteDropModifier(
                onDelete: onDelete,
                onEntered: onEntered,
                onExited: onExited
            )
        )
    }
}
