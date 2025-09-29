//
//  MyPageEditStore.swift
//  Solply
//
//  Created by sun on 9/26/25.
//

import Foundation

@MainActor
final class MyPageEditStore: ObservableObject {
    @Published private(set) var state = MyPageEditState()
    
    func dispatch(_ action: MyPageEditAction) {
        MyPageEditReducer.reduce(state: &state, action: action)
        
        switch action {
        default:
            break
        }
    }
}
