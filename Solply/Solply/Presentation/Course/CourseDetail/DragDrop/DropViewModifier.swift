//
//  DropViewModifier.swift
//  Solply
//
//  Created by 김승원 on 9/29/25.
//

import SwiftUI

struct DropViewModifier: ViewModifier {
    
    // MARK: - Properties
    
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
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        if isEditing {
            content
                .onDrag {
                    guard isEditing else { return NSItemProvider() }
                    
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                    
                    startDragging?(placeDetailInCourse)
                    
                    return NSItemProvider()
                }
                .onDrop(
                    of: [.text],
                    delegate: DropViewDelegate(
                        destinationPlace: placeDetailInCourse,
                        places: placesDetailInCourse,
                        draggedPlace: draggedPlace,
                        onMove: { fromIndex, toIndex in
                            whileDragging?(fromIndex, toIndex)
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
            DropViewModifier(
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
