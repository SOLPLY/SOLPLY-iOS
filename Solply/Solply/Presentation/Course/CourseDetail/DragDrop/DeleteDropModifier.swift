//
//  DeleteDropModifier.swift
//  Solply
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

struct DeleteDropModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding private var dragDropState: DragDropState
    
    private let places: [PlaceDetailInCourse]
    private let draggedPlace: PlaceDetailInCourse?
    private let onDelete: ((Bool) -> Void)?
    private let onEntered: (() -> Void)?
    private let onExited: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        dragDropState: Binding<DragDropState>,
        places: [PlaceDetailInCourse],
        draggedPlace: PlaceDetailInCourse?,
        onDelete: ((Bool) -> Void)?,
        onEntered: (() -> Void)?,
        onExited: (() -> Void)?
    ) {
        self._dragDropState = dragDropState
        self.places = places
        self.draggedPlace = draggedPlace
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
                    draggedPlace: draggedPlace,
                    onDelete: {
                        dragDropState = .completed
                        
                        if places.count > 2 {
                            onDelete?(true)
                        } else {
                            onDelete?(false)
                        }
                    },
                    onEntered: {
                        onEntered?()
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    },
                    onExited: {
                        onExited?()
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
                )
            )
    }
}

extension View {
    func deleteDrop(
        dragDropState: Binding<DragDropState>,
        places: [PlaceDetailInCourse],
        draggedPlace: PlaceDetailInCourse?,
        onDelete: ((Bool) -> Void)? = nil,
        onEntered: (() -> Void)? = nil,
        onExited: (() -> Void)? = nil
    ) -> some View {
        self.modifier(
            DeleteDropModifier(
                dragDropState: dragDropState,
                places: places,
                draggedPlace: draggedPlace,
                onDelete: onDelete,
                onEntered: onEntered,
                onExited: onExited
            )
        )
    }
}
