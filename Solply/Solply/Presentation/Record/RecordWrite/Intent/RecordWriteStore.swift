//
//  RecordWriteStore.swift
//  Solply
//
//  Created by sun on 3/21/26.
//

import Foundation

@MainActor
final class RecordWriteStore: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var state = RecordWriteState()
    let placeId: Int
    let placeName: String
    
    // MARK: - Initializer
    
    init(placeId: Int, placeName: String) {
        self.placeId = placeId
        self.placeName = placeName
    }
    
    // MARK: - Dispatch
    
    func dispatch(_ action: RecordWriteAction) {
        RecordWriteReducer.reduce(state: &state, action: action)
        
        switch action {
        default:
            break
        }
    }
}
