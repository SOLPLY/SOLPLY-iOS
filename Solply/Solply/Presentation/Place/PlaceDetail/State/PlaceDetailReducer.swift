//
//  PlaceDetailReducer.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

enum PlaceDetailReducer {
    static func reduce(state: inout PlaceDetailState, action: PlaceDetailAction) {
        switch action {
        case .toggleAddToCourse:
            state.addButtonSelected.toggle()
            state.findDirectionEnabled = state.addButtonSelected ? false : true
            state.saveButtonEnabled = state.addButtonSelected ? false : true
            
        case .toggleSavePlace:
            state.saveButtonSelected.toggle()
            
        case .requestFindDirection:
            print("길찾기 버트 누름")
        }
    }
}
