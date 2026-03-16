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
    
    // MARK: - Initializer
    
    // TODO: - API 연동할 때 Effect 추가하기
    
    // MARK: - dispatch
    
    func dispatch(_ action: RecordListAction) {
        RecordListReducer.reduce(state: &state, action: action)
        
        switch action {
        default:
            break
        }
    }
}
        
