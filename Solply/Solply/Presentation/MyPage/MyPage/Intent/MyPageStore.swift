//
//  MyPageStore.swift
//  Solply
//
//  Created by sun on 9/19/25.
//

import Foundation

@MainActor
final class MyPageStore: ObservableObject {
    @Published private(set) var state = MyPageState()
    
    func dispatch(_ action: MyPageAction) {
        MyPageReducer.reduce(state: &state, action: action)
        
        switch action {
        default:
            break
        }
    }
}
