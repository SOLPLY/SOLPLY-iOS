//
//  CustomDragDropModifier.swift
//  Solply
//
//  Created by 김승원 on 9/29/25.
//

import SwiftUI

struct CustomDragDropModifier: ViewModifier {
    let isEditing: Bool
    let placeDetailInCourse: PlaceDetailInCourse
    let placesDetailInCourse: [PlaceDetailInCourse]
    let draggedPlace: PlaceDetailInCourse?
    let startDragging: ((PlaceDetailInCourse) -> Void)?
    let whileDragging: ((Int, Int) -> Void)?
    let endDragging: (() -> Void)?
    
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
                        isEditing: isEditing,
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
