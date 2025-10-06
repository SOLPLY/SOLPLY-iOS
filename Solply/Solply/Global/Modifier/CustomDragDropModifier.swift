//
//  CustomDragDropModifier.swift
//  Solply
//
//  Created by 김승원 on 9/29/25.
//

import SwiftUI

struct CustomDragDropModifier: ViewModifier {
    
    // MARK: - Properties
    
    @State private var dragDropState: DragDropState = .prepared
    
    private let isEditing: Bool
    private let placeDetailInCourse: PlaceDetailInCourse
    private let placesDetailInCourse: [PlaceDetailInCourse]
    private let draggedPlace: PlaceDetailInCourse?
    private let startDragging: ((PlaceDetailInCourse) -> Void)?
    private let whileDragging: ((Int, Int) -> Void)?
    private let endDragging: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        isEditing: Bool,
        placeDetailInCourse: PlaceDetailInCourse,
        placesDetailInCourse: [PlaceDetailInCourse],
        draggedPlace: PlaceDetailInCourse?,
        startDragging: ((PlaceDetailInCourse) -> Void)?,
        whileDragging: ((Int, Int) -> Void)?,
        endDragging: (() -> Void)?
    ) {
        self.isEditing = isEditing
        self.placeDetailInCourse = placeDetailInCourse
        self.placesDetailInCourse = placesDetailInCourse
        self.draggedPlace = draggedPlace
        self.startDragging = startDragging
        self.whileDragging = whileDragging
        self.endDragging = endDragging
    }
    
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
        isEditing: Bool,
        placeDetailInCourse: PlaceDetailInCourse,
        placesDetailInCourse: [PlaceDetailInCourse],
        draggedPlace: PlaceDetailInCourse?,
        startDragging: ((PlaceDetailInCourse) -> Void)?,
        whileDragging: ((Int, Int) -> Void)?,
        endDragging: (() -> Void)?
    ) -> some View {
        self.modifier(
            CustomDragDropModifier(
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
