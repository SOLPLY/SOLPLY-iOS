//
//  DropDelegate.swift
//  Solply
//
//  Created by 김승원 on 7/11/25.
//

import SwiftUI

// MARK: - DropViewDelegate

struct DropViewDelegate: DropDelegate {
    let isEditing: Bool
    let destinationPlace : PlaceDetailInCourse
    let places: [PlaceDetailInCourse]
    let draggedPlace : PlaceDetailInCourse?
    let onMove: (Int, Int) -> Void
    let onDragEnd: () -> Void
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        guard isEditing else { return nil }
        
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        guard isEditing else { return false }
        
        onDragEnd()
        return true
    }
    
    func dropEntered(info: DropInfo) {
        guard isEditing else { return }

        if let draggedPlace,
           let fromIndex = places.firstIndex(of: draggedPlace),
           let toIndex = places.firstIndex(of: destinationPlace) {
            
            withAnimation(.interactiveSpring) {
                onMove(fromIndex, toIndex)
            }
        }
    }
}

// MARK: - DeleteDropDelegate

struct DeleteDropDelegate: DropDelegate {
    let draggedPlace: PlaceDetailInCourse?
    let onDelete: () -> Void
    let onEntered: () -> Void
    let onExited: () -> Void

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        if draggedPlace != nil {
            onDelete()
            return true
        }
        return false
    }

    func dropEntered(info: DropInfo) {
        onEntered()
    }

    func dropExited(info: DropInfo) {
        onExited()
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
