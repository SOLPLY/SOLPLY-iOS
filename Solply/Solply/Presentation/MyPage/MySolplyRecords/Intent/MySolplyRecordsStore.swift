//
//  MySolplyRecordsStore.swift
//  Solply
//
//  Created by 김승원 on 4/18/26.
//

import Foundation

@MainActor
final class MySolplyRecordsStore: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var state = MySolplyRecordsState()
    private let effect: MySolplyRecordsEffect
    
    // MARK: - Initializer
    
    init() {
        self.effect = MySolplyRecordsEffect(placeService: PlaceService())
    }
    
    // MARK: - Dispatch
    
    func dispatch(_ action: MySolplyRecordsAction) {
        MySolplyRecordsReducer.reduce(state: &state, action: action)
        
        switch action {
            
        case .onAppear:
            dispatch(.fetchMySolplyRecords)
            
        case .fetchMySolplyRecords:
            Task {
                let result = await effect.fetchMySolplyRecords()
                dispatch(result)
            }
            
        default:
            break
        }
    }
}
