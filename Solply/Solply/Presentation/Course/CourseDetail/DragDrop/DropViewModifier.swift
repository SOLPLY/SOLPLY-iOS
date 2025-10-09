//
//  DropViewModifier.swift
//  Solply
//
//  Created by 김승원 on 9/29/25.
//

import SwiftUI

struct DropViewModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding private var dragDropState: DragDropState
    
    private let isEditing: Bool
    private let placeDetailInCourse: PlaceDetailInCourse
    private let placesDetailInCourse: [PlaceDetailInCourse]
    private let draggedPlace: PlaceDetailInCourse?
    private let startDragging: ((PlaceDetailInCourse) -> Void)?
    private let whileDragging: ((Int, Int) -> Void)?
    private let endDragging: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        dragDropState: Binding<DragDropState>,
        isEditing: Bool,
        placeDetailInCourse: PlaceDetailInCourse,
        placesDetailInCourse: [PlaceDetailInCourse],
        draggedPlace: PlaceDetailInCourse?,
        startDragging: ((PlaceDetailInCourse) -> Void)?,
        whileDragging: ((Int, Int) -> Void)?,
        endDragging: (() -> Void)?
    ) {
        self._dragDropState = dragDropState
        self.isEditing = isEditing
        self.placeDetailInCourse = placeDetailInCourse
        self.placesDetailInCourse = placesDetailInCourse
        self.draggedPlace = draggedPlace
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
                    
                    switch dragDropState {
                    case .prepared:
                        startDragging?(placeDetailInCourse)
                        dragDropState = .dragging
                    case .dragging, .completed:
                        dragDropState = .prepared
                    }
                    
                    return NSItemProvider()
                }
                .onDrop(
                    of: [.text],
                    delegate: DropViewDelegate(
                        isEditing: isEditing,
                        destinationPlace: placeDetailInCourse,
                        places: placesDetailInCourse,
                        draggedPlace: draggedPlace,
                        onMove: { fromIndex, toIndex in
                            whileDragging?(fromIndex, toIndex)
                        },
                        onDragEnd: {
                            dragDropState = .completed
                            endDragging?()
                        }
                    )
                )
        } else {
            content
        }
    }
}

extension View {
    func customDragDrop(
        dragDropState: Binding<DragDropState>,
        isEditing: Bool,
        placeDetailInCourse: PlaceDetailInCourse,
        placesDetailInCourse: [PlaceDetailInCourse],
        draggedPlace: PlaceDetailInCourse?,
        startDragging: ((PlaceDetailInCourse) -> Void)?,
        whileDragging: ((Int, Int) -> Void)?,
        endDragging: (() -> Void)?
    ) -> some View {
        self.modifier(
            DropViewModifier(
                dragDropState: dragDropState,
                isEditing: isEditing,
                placeDetailInCourse: placeDetailInCourse,
                placesDetailInCourse: placesDetailInCourse,
                draggedPlace: draggedPlace,
                startDragging: startDragging,
                whileDragging: whileDragging,
                endDragging: endDragging
            )
        )
    }
}
