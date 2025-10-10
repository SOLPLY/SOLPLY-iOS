//
//  RegisterStore.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

@MainActor
final class RegisterStore: ObservableObject {
    @Published private(set) var state = RegisterState()
    private let effect = RegisterEffect()
    
    func dispatch(_ action: RegisterAction) {
        RegisterReducer.reduce(state: &state, action: action)
        
        switch action {
        default:
            break
        }
    }
}
