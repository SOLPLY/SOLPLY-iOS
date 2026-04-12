//
//  RecordListStore.swift
//  Solply
//
//  Created by 김승원 on 3/14/26.
//

import Foundation

@MainActor
final class RecordListStore: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var state = RecordListState()
    private let effect: RecordListEffect
    
    let placeId: Int
    
    // MARK: - Initializer
    
    init(
        effect: RecordListEffect = RecordListEffect(
            placeService: PlaceService()
        ),
        placeId: Int
    ) {
        self.effect = effect
        self.placeId = placeId
    }
    
    // MARK: - dispatch
    
    func dispatch(_ action: RecordListAction) {
        RecordListReducer.reduce(state: &state, action: action)
        
        switch action {
        case .onAppear:
            dispatch(.fetchPlaceRecordList)
            
        case .fetchPlaceRecordList:
            Task {
                let result = await effect.fetchPlaceRecordList(placeId: placeId)
                self.dispatch(result)
            }
            
        default:
            
            break
        }
    }
}
        
