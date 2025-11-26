//
//  RegisteredPlacesStore.swift
//  Solply
//
//  Created by seozero on 11/18/25.
//

import Foundation

@MainActor
final class RegisteredPlacesStore: ObservableObject {
    @Published private(set) var state = RegisteredPlacesState()
    private let effect = RegisteredPlacesEffect(
        userService: UserService()
    )
    
    func dispatch(_ action: RegisteredPlacesAction) {
        RegisteredPlacesReducer.reduce(state: &state, action: action)
        
        switch action {
        case let .fetchRegisteredPlaces(userId, _, _):
            Task {
                let results = await effect.fetchRegisteredPlaces(userId: userId)
                self.dispatch(results)
            }
            
        default:
            break
        }
    }
}
