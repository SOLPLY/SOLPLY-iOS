//
//  DropViewDelegate.swift
//  Solply
//
//  Created by 김승원 on 7/11/25.
//

import SwiftUI

struct DropViewDelegate: DropDelegate {
    
    let destinationPlace : Place
    let places: [Place]
    let draggedPlace : Place?
    let isEditing: Bool
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
           draggedPlace.id != destinationPlace.id,
           let fromIndex = places.firstIndex(of: draggedPlace),
           let toIndex = places.firstIndex(of: destinationPlace),
           fromIndex != toIndex {
            
            if places[toIndex] != draggedPlace {
                withAnimation(.interactiveSpring()) {
                    onMove(fromIndex, toIndex)
                }
            }
        }
    }
}

